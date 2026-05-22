import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../features/herbaria/presentation/pages/herbaria_page.dart';
import '../../../features/notifications/presentation/pages/notifications_page.dart';
import '../../../features/auth/presentation/pages/profile_page.dart';
import '../../../features/friends/presentation/pages/friends_page.dart';
import '../../../l10n/app_localizations.dart';
import '../../../features/notifications/presentation/bloc/notification_bloc.dart';
import '../../../features/notifications/presentation/bloc/notification_event.dart';
import '../../../features/notifications/presentation/bloc/notification_state.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;
  late final NotificationBloc _notificationBloc;

  final List<Widget> _pages = [
    const HerbariaPage(),
    const NotificationsPage(),
    const FriendsPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _notificationBloc = context.read<NotificationBloc>();
    _notificationBloc.add(StartPollingNotifications());
  }

  @override
  void dispose() {
    _notificationBloc.add(StopPollingNotifications());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          int unreadCount = 0;
          if (state is NotificationLoaded) {
            unreadCount = state.notifications.where((n) => !n.isRead).length;
          }

          return BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.green.shade800,
            unselectedItemColor: Colors.grey.shade500,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.eco),
                label: l10n.navHerbaria,
              ),
              BottomNavigationBarItem(
                icon: unreadCount > 0
                    ? Badge(
                        label: Text(unreadCount.toString()),
                        child: const Icon(Icons.notifications),
                      )
                    : const Icon(Icons.notifications),
                label: l10n.navNotifications,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.people_alt_rounded),
                label: l10n.navFriends,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label: l10n.navProfile,
              ),
            ],
          );
        },
      ),
    );
  }
}
