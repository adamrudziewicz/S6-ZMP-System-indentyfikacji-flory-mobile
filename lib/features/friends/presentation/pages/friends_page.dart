import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/friends_bloc.dart';
import '../bloc/friends_event.dart';
import '../bloc/friends_state.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<FriendsBloc>().add(LoadFriends());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1B5E20),
        title: Text(
          l10n.friendsTitle,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 22,
            letterSpacing: -0.5,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 4,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: l10n.friendsTabList),
            Tab(text: l10n.friendsTabRequests),
          ],
        ),
      ),
      body: BlocConsumer<FriendsBloc, FriendsState>(
        listener: (context, state) {
          if (state is FriendActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green.shade700,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is FriendsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.exception.getLocalizedMessage(l10n)),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is FriendsLoading) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF2E7D32)));
          } else if (state is FriendsLoaded) {
            return TabBarView(
              controller: _tabController,
              children: [
                _buildFriendsList(state, l10n),
                _buildRequestsList(state, l10n),
              ],
            );
          }
          return Center(child: Text(l10n.herbariaLoadError));
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: const Icon(Icons.person_add_alt_1_rounded),
        label: Text(l10n.addFriendTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
        onPressed: () {
          _showAddFriendDialog(context, l10n);
        },
      ),
    );
  }

  Widget _buildFriendsList(FriendsLoaded state, AppLocalizations l10n) {
    if (state.friends.isEmpty) {
      return _buildEmptyState(l10n.noFriendsText, Icons.group_outlined);
    }
    
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16, bottom: 80, left: 16, right: 16),
      itemCount: state.friends.length,
      itemBuilder: (context, index) {
        final friend = state.friends[index];
        final displayUsername = friend.username;

        return _buildFriendCard(
          username: displayUsername,
          actionIcon: Icons.person_remove_rounded,
          actionColor: Colors.red.shade400,
          onActionPressed: () {
            _showRemoveFriendConfirmation(context, l10n, friend.friendshipId, displayUsername);
          },
        );
      },
    );
  }

  Widget _buildRequestsList(FriendsLoaded state, AppLocalizations l10n) {
    if (state.incomingRequests.isEmpty && state.sentRequests.isEmpty) {
      return _buildEmptyState(l10n.noRequestsText, Icons.mail_outline_rounded);
    }

    return ListView(
      padding: const EdgeInsets.only(top: 16, bottom: 80, left: 16, right: 16),
      children: [
        if (state.incomingRequests.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              l10n.incomingRequestsHeader,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
            ),
          ),
          ...state.incomingRequests.map((request) {
            return _buildRequestCard(
              username: request.username,
              onAccept: () {
                context.read<FriendsBloc>().add(AcceptFriendRequest(request.friendshipId));
              },
              onDecline: () {
                context.read<FriendsBloc>().add(RemoveFriendship(request.friendshipId));
              },
            );
          }).toList(),
          const SizedBox(height: 16),
        ],
        if (state.sentRequests.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              l10n.sentRequestsHeader,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
            ),
          ),
          ...state.sentRequests.map((request) {
            return _buildFriendCard(
              username: request.username,
              actionIcon: Icons.close_rounded,
              actionColor: Colors.grey.shade600,
              onActionPressed: () {
                context.read<FriendsBloc>().add(RemoveFriendship(request.friendshipId));
              },
            );
          }).toList(),
        ],
      ],
    );
  }

  Widget _buildEmptyState(String message, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendCard({
    required String username,
    required IconData actionIcon,
    required Color actionColor,
    required VoidCallback onActionPressed,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: Colors.green.shade100,
          foregroundColor: Colors.green.shade800,
          child: Text(username.isNotEmpty ? username[0].toUpperCase() : '?'),
        ),
        title: Text(username, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        trailing: IconButton(
          icon: Icon(actionIcon, color: actionColor),
          onPressed: onActionPressed,
        ),
      ),
    );
  }

  Widget _buildRequestCard({
    required String username,
    required VoidCallback onAccept,
    required VoidCallback onDecline,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.orange.shade50,
              foregroundColor: Colors.orange.shade800,
              child: Text(username.isNotEmpty ? username[0].toUpperCase() : '?'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(username, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.close_rounded, color: Colors.grey.shade500),
                  onPressed: onDecline,
                  tooltip: 'Odrzuć',
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.check_rounded, color: Colors.green.shade700),
                    onPressed: onAccept,
                    tooltip: 'Akceptuj',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddFriendDialog(BuildContext context, AppLocalizations l10n) {
    final usernameController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Text(l10n.addFriendTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: l10n.addFriendLabel,
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.cancel, style: const TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                final username = usernameController.text.trim();
                if (username.isNotEmpty) {
                  this.context.read<FriendsBloc>().add(SendFriendRequest(username));
                  Navigator.pop(ctx);
                }
              },
              child: Text(l10n.sendRequestButton),
            ),
          ],
        );
      },
    );
  }

  void _showRemoveFriendConfirmation(BuildContext context, AppLocalizations l10n, String friendshipId, String username) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Text(l10n.removeFriendTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
          content: Text(l10n.removeFriendContent(username)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.cancel, style: const TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                this.context.read<FriendsBloc>().add(RemoveFriendship(friendshipId));
                Navigator.pop(ctx);
              },
              child: Text(l10n.removeFriendButton),
            ),
          ],
        );
      },
    );
  }
}
