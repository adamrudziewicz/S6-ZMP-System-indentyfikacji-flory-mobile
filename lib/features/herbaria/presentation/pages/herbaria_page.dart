import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/herbarium.dart';
import '../bloc/herbaria_bloc.dart';
import '../bloc/herbaria_event.dart';
import '../bloc/herbaria_state.dart';
import 'herbarium_details_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HerbariaPage extends StatefulWidget {
  const HerbariaPage({super.key});

  @override
  State<HerbariaPage> createState() => _HerbariaPageState();
}

class _HerbariaPageState extends State<HerbariaPage> {
  @override
  void initState() {
    super.initState();
    context.read<HerbariaBloc>().add(LoadMyHerbaria());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: BlocConsumer<HerbariaBloc, HerbariaState>(
        listener: (context, state) {
          if (state is HerbariumActionSuccess) {
            String message;
            switch (state.action) {
              case HerbariumActionType.created:
                message = l10n.herbariumCreatedSuccess;
                break;
              case HerbariumActionType.updated:
                message = l10n.herbariumUpdatedSuccess;
                break;
              case HerbariumActionType.deleted:
                message = l10n.herbariumDeletedSuccess;
                break;
              case HerbariumActionType.madePublic:
                message = l10n.herbariumMadePublicSuccess;
                break;
              case HerbariumActionType.madePrivate:
                message = l10n.herbariumMadePrivateSuccess;
                break;
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.green.shade700,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is HerbariaError) {
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
          return RefreshIndicator(
            color: const Color(0xFF2E7D32),
            onRefresh: () async {
              context.read<HerbariaBloc>().add(LoadMyHerbaria());
              await Future.delayed(const Duration(seconds: 1));
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                _buildSliverAppBar(l10n),
                if (state is HerbariaLoading)
                  const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator(color: Color(0xFF2E7D32))),
                  )
                else if (state is HerbariaLoaded && state.herbaria.isEmpty)
                  _buildEmptyState(l10n)
                else if (state is HerbariaLoaded)
                  _buildGrid(state, l10n)
                else
                  SliverFillRemaining(
                    child: Center(child: Text(l10n.herbariaLoadError)),
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: const Icon(Icons.add_rounded),
        label: Text(l10n.newHerbariumTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
        onPressed: () {
          _showCreateHerbariumDialog(context, l10n);
        },
      ),
    );
  }

  Widget _buildSliverAppBar(AppLocalizations l10n) {
    return SliverAppBar(
      expandedHeight: 180.0,
      floating: true,
      pinned: true,
      elevation: 0,
      backgroundColor: const Color(0xFF1B5E20),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
        title: Text(
          l10n.myHerbariaTitle,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 24,
            letterSpacing: -0.5,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2E7D32), Color(0xFF1B5E20)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Positioned(
              right: -50,
              top: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              right: 80,
              bottom: -20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.energy_savings_leaf_outlined, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              l10n.emptyHerbariaTitle,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.emptyHerbariaSubtitle,
              style: TextStyle(color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(HerbariaLoaded state, AppLocalizations l10n) {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final herbarium = state.herbaria[index];
            final isOffline = herbarium.id.startsWith('local_');
            
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => HerbariumDetailsPage(herbarium: herbarium),
                  ),
                );
              },
              onLongPress: isOffline ? null : () => _showHerbariumOptions(context, herbarium, l10n),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CachedNetworkImage(
                          imageUrl: 'https://picsum.photos/seed/${herbarium.id}/400/400',
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Container(
                            color: Colors.green.shade50,
                            child: Center(
                              child: Icon(Icons.energy_savings_leaf_outlined, color: Colors.green.shade200, size: 60),
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.white.withOpacity(0.85),
                                Colors.white,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.3, 0.7, 1.0],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.auto_awesome_mosaic_rounded, color: Colors.green.shade700, size: 20),
                                ),
                                  if (isOffline)
                                  Tooltip(
                                    message: l10n.offlineSyncTooltip,
                                    child: Icon(Icons.cloud_off_rounded, color: Colors.orange.shade400, size: 20),
                                  )
                                else if (herbarium.isPublic)
                                  Icon(Icons.public_rounded, color: Colors.blue.shade400, size: 20)
                                else
                                  Icon(Icons.lock_outline_rounded, color: Colors.grey.shade400, size: 20),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              herbarium.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B5E20),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              herbarium.description ?? l10n.noDescription,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                height: 1.3,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          childCount: state.herbaria.length,
        ),
      ),
    );
  }

  void _showHerbariumOptions(BuildContext context, Herbarium herbarium, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 24),
              ListTile(
                leading: Icon(herbarium.isPublic ? Icons.lock_outline_rounded : Icons.public_rounded, color: const Color(0xFF2E7D32)),
                title: Text(l10n.changeVisibility, style: const TextStyle(fontWeight: FontWeight.w600)),
                onTap: () {
                  Navigator.pop(ctx);
                  _showVisibilityDialog(context, herbarium, l10n);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit_rounded, color: Color(0xFF2E7D32)),
                title: Text(l10n.editHerbariumTitle, style: const TextStyle(fontWeight: FontWeight.w600)),
                onTap: () {
                  Navigator.pop(ctx);
                  _showEditHerbariumDialog(context, herbarium, l10n);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline_rounded, color: Colors.red),
                title: Text(l10n.deleteHerbarium, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.red)),
                onTap: () {
                  Navigator.pop(ctx);
                  _showDeleteConfirmDialog(context, herbarium, l10n);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmDialog(BuildContext context, Herbarium herbarium, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(l10n.deleteHerbariumTitle, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
        content: Text(l10n.deleteHerbariumContent(herbarium.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancelAction, style: const TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              context.read<HerbariaBloc>().add(DeleteHerbarium(herbarium.id));
              Navigator.pop(ctx);
            },
            child: Text(l10n.deleteAction),
          ),
        ],
      ),
    );
  }

  void _showVisibilityDialog(BuildContext context, Herbarium herbarium, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(l10n.changeVisibility, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text(herbarium.isPublic ? l10n.makePrivateConfirm : l10n.makePublicConfirm),
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
              context.read<HerbariaBloc>().add(
                    UpdateHerbarium(
                      id: herbarium.id,
                      name: herbarium.name,
                      description: herbarium.description,
                      isPublic: !herbarium.isPublic,
                      isVisibilityChange: true,
                    ),
                  );
              Navigator.pop(ctx);
            },
            child: Text(l10n.confirm),
          ),
        ],
      ),
    );
  }

  void _showEditHerbariumDialog(BuildContext context, Herbarium herbarium, AppLocalizations l10n) {
    final nameController = TextEditingController(text: herbarium.name);
    final descController = TextEditingController(text: herbarium.description ?? '');

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Text(l10n.editHerbariumTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: l10n.nameLabel,
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: l10n.descriptionOptionalLabel,
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.cancel, style: const TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                final name = nameController.text.trim();
                if (name.isNotEmpty) {
                  this.context.read<HerbariaBloc>().add(
                    UpdateHerbarium(
                      id: herbarium.id,
                      name: name,
                      description: descController.text.trim(),
                      isPublic: herbarium.isPublic,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: Text(l10n.saveButton),
            ),
          ],
        );
      },
    );
  }

  void _showCreateHerbariumDialog(BuildContext context, AppLocalizations l10n) {
    final nameController = TextEditingController();
    final descController = TextEditingController();
    bool isPublic = false;

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              title: Text(l10n.newHerbariumTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: l10n.nameLabel,
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: descController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: l10n.descriptionOptionalLabel,
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      title: Text(l10n.publicLabel, style: const TextStyle(fontWeight: FontWeight.w500)),
                      subtitle: Text(l10n.publicDescription, style: const TextStyle(fontSize: 12)),
                      value: isPublic,
                      activeColor: const Color(0xFF2E7D32),
                      onChanged: (val) => setState(() => isPublic = val),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l10n.cancel, style: const TextStyle(color: Colors.grey)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    final name = nameController.text.trim();
                    if (name.isNotEmpty) {
                      this.context.read<HerbariaBloc>().add(
                        CreateHerbarium(
                          name: name,
                          description: descController.text.trim(),
                          isPublic: isPublic,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text(l10n.createButton),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
