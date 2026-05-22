import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../features/herbaria/domain/entities/herbarium.dart';
import '../../../../features/plants/presentation/bloc/list/plant_list_bloc.dart';
import '../../../../features/plants/presentation/bloc/list/plant_list_event.dart';
import '../../../../features/plants/presentation/bloc/list/plant_list_state.dart';
import '../../../../features/plants/presentation/pages/camera_capture_page.dart';
import '../../../../core/widgets/authenticated_image.dart';
import '../../../../features/plants/domain/entities/plant.dart';

class HerbariumDetailsPage extends StatefulWidget {
  final Herbarium herbarium;

  const HerbariumDetailsPage({super.key, required this.herbarium});

  @override
  State<HerbariumDetailsPage> createState() => _HerbariumDetailsPageState();
}

class _HerbariumDetailsPageState extends State<HerbariumDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<PlantListBloc>().add(LoadPlants(widget.herbarium.id));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: BlocConsumer<PlantListBloc, PlantListState>(
        listener: (context, state) {
          if (state is PlantListError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
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
              context.read<PlantListBloc>().add(LoadPlants(widget.herbarium.id));
              await Future.delayed(const Duration(seconds: 1));
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                _buildSliverAppBar(),
                if (state is PlantListLoading)
                  const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator(color: Color(0xFF2E7D32))),
                  )
                else if (state is PlantListLoaded && state.plants.isEmpty)
                  _buildEmptyState(l10n)
                else if (state is PlantListLoaded)
                  _buildPlantsGrid(state, l10n)
                else
                  SliverFillRemaining(
                    child: Center(child: Text(l10n.plantsLoadError)),
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
        icon: const Icon(Icons.camera_alt_rounded),
        label: Text(l10n.identifyButton, style: const TextStyle(fontWeight: FontWeight.bold)),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CameraCapturePage(herbariumId: widget.herbarium.id),
            ),
          ).then((_) {
            if (mounted) {
              context.read<PlantListBloc>().add(LoadPlants(widget.herbarium.id));
            }
          });
        },
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 180.0,
      floating: true,
      pinned: true,
      elevation: 0,
      backgroundColor: const Color(0xFF1B5E20),
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final topPadding = MediaQuery.of(context).padding.top;
          final minHeight = kToolbarHeight + topPadding;
          final maxHeight = 180.0 + topPadding;
          
          double t = (constraints.maxHeight - minHeight) / (maxHeight - minHeight);
          t = t.clamp(0.0, 1.0);
          
          final leftPadding = 48.0 - (32.0 * t);

          return FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(left: leftPadding, bottom: 16, right: 16),
            title: Text(
              widget.herbarium.name,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
                fontSize: 22,
                letterSpacing: -0.5,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://picsum.photos/seed/${widget.herbarium.id}/800/600',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: const Color(0xFF2E7D32),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFF2E7D32).withOpacity(0.7), const Color(0xFF1B5E20).withOpacity(0.95)],
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
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
            if (widget.herbarium.description != null && widget.herbarium.description!.isNotEmpty)
              Positioned(
                left: 16,
                bottom: 50,
                right: 16,
                child: Text(
                  widget.herbarium.description!,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      );
        },
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.local_florist_outlined, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              l10n.emptyPlantsTitle,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.emptyPlantsSubtitle,
              style: TextStyle(color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlantsGrid(PlantListLoaded state, AppLocalizations l10n) {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final plant = state.plants[index];
            
            return GestureDetector(
              onTap: () => _showPlantDetails(context, plant, l10n),
              onLongPress: () => _showPlantOptions(context, plant, l10n),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: plant.photos.isNotEmpty
                            ? AuthenticatedImage(
                                filename: plant.photos.first.url.split('/').last,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                color: Colors.grey.shade200,
                                child: Icon(Icons.image_outlined, size: 40, color: Colors.grey.shade400),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              (plant.name != null && plant.name!.isNotEmpty) ? plant.name! : (plant.detectedSpecies ?? l10n.unknownSpecies),
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B5E20),
                                height: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            if (plant.confidence != null)
                              Text(
                                '${l10n.confidenceLabel}${(plant.confidence! * 100).toStringAsFixed(0)}%',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.green.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
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
          childCount: state.plants.length,
        ),
      ),
    );
  }

  void _showPlantDetails(BuildContext context, Plant initialPlant, AppLocalizations l10n) {
    int currentPhotoIndex = 0;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BlocBuilder<PlantListBloc, PlantListState>(
          builder: (context, state) {
            Plant plant = initialPlant;
            if (state is PlantListLoaded) {
              plant = state.plants.firstWhere(
                (p) => p.id == initialPlant.id,
                orElse: () => initialPlant,
              );
            }
            return DraggableScrollableSheet(
              initialChildSize: 0.85,
              minChildSize: 0.5,
              maxChildSize: 0.95,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF9FBF9),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 12),
                        Center(
                          child: Container(
                            width: 48,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (plant.photos.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: StatefulBuilder(
                                builder: (context, setStateSheet) {
                                  return SizedBox(
                                    height: 260,
                                    width: double.infinity,
                                    child: Stack(
                                      children: [
                                        PageView.builder(
                                          itemCount: plant.photos.length,
                                          onPageChanged: (index) {
                                            setStateSheet(() {
                                              currentPhotoIndex = index;
                                            });
                                          },
                                          itemBuilder: (context, index) {
                                            return AuthenticatedImage(
                                              filename: plant.photos[index].url.split('/').last,
                                              height: 260,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                        Positioned(
                                          bottom: 16,
                                          left: 16,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: Colors.black54,
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  plant.recognized ? Icons.verified_rounded : Icons.help_outline_rounded,
                                                  color: plant.recognized ? Colors.green.shade400 : Colors.orange.shade400,
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  plant.recognized ? l10n.plantRecognized : l10n.plantNotRecognized,
                                                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (plant.photos.length > 1)
                                          Positioned(
                                            top: 16,
                                            right: 16,
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: Colors.black54,
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                '${currentPhotoIndex + 1} / ${plant.photos.length}',
                                                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        else
                          Container(
                            height: 180,
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Icon(Icons.image_outlined, size: 64, color: Colors.grey.shade400),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      (plant.name != null && plant.name!.isNotEmpty) ? plant.name! : l10n.unnamedPlant,
                                      style: const TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF1B5E20),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit_rounded, color: Color(0xFF2E7D32)),
                                    onPressed: () {
                                      _showEditNameDialog(context, plant, l10n);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
                                    onPressed: () {
                                      _showDeletePlantConfirmDialog(context, plant, l10n);
                                    },
                                  ),
                                ],
                              ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.03),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                _buildDetailRow(l10n.plantDetailsHeader, plant.detectedSpecies ?? l10n.unknownSpecies, isItalic: true),
                                if (plant.genus != null && plant.genus!.isNotEmpty) ...[
                                  const Divider(height: 24),
                                  _buildDetailRow(l10n.genusLabel, plant.genus!),
                                ],
                                if (plant.family != null && plant.family!.isNotEmpty) ...[
                                  const Divider(height: 24),
                                  _buildDetailRow(l10n.familyLabel, plant.family!),
                                ],
                                if (plant.commonNames != null && plant.commonNames!.isNotEmpty) ...[
                                  const Divider(height: 24),
                                  _buildDetailRow(l10n.commonNamesLabel, plant.commonNames!),
                                ],
                                if (plant.confidence != null) ...[
                                  const Divider(height: 24),
                                  _buildDetailRow(
                                    l10n.confidenceLabel.replaceAll(':', '').trim(), 
                                    '${(plant.confidence! * 100).toStringAsFixed(1)}%',
                                    valueColor: Colors.green.shade700,
                                    valueWeight: FontWeight.bold,
                                  ),
                                ],
                                if (plant.createdAt != null) ...[
                                  const Divider(height: 24),
                                  _buildDetailRow(
                                    l10n.createdAtLabel, 
                                    '${plant.createdAt!.day.toString().padLeft(2, '0')}.${plant.createdAt!.month.toString().padLeft(2, '0')}.${plant.createdAt!.year}',
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          if (plant.photos.isNotEmpty) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  l10n.descriptionLabel,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1B5E20),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit_rounded, color: Color(0xFF2E7D32), size: 20),
                                  onPressed: () {
                                    _showEditDescriptionDialog(context, plant, l10n);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () {
                                _showEditDescriptionDialog(context, plant, l10n);
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.grey.shade100),
                                ),
                                child: Text(
                                  (plant.photos.first.description != null && plant.photos.first.description!.isNotEmpty)
                                      ? plant.photos.first.description!
                                      : l10n.addDescriptionLabel,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: (plant.photos.first.description != null && plant.photos.first.description!.isNotEmpty)
                                        ? Colors.black87
                                        : Colors.grey.shade400,
                                    fontStyle: (plant.photos.first.description != null && plant.photos.first.description!.isNotEmpty)
                                        ? FontStyle.normal
                                        : FontStyle.italic,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  },
);
}

  Widget _buildDetailRow(String label, String value, {bool isItalic = false, Color? valueColor, FontWeight? valueWeight}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              color: valueColor ?? Colors.black87,
              fontSize: 15,
              fontWeight: valueWeight ?? FontWeight.w600,
              fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ),
      ],
    );
  }

  void _showEditNameDialog(BuildContext context, Plant plant, AppLocalizations l10n) {
    final controller = TextEditingController(text: (plant.name != null && plant.name!.isNotEmpty) ? plant.name : (plant.detectedSpecies ?? ''));
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Text(l10n.editNameTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              labelText: l10n.plantNameLabel,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 2),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.cancelButton, style: TextStyle(color: Colors.grey.shade700)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                final newName = controller.text.trim();
                context.read<PlantListBloc>().add(
                  UpdatePlantName(
                    herbariumId: widget.herbarium.id,
                    plantId: plant.id,
                    newName: newName,
                  ),
                );
                Navigator.pop(ctx);
              },
              child: Text(l10n.saveButton),
            ),
          ],
        );
      },
    );
  }

  void _showEditDescriptionDialog(BuildContext context, Plant plant, AppLocalizations l10n) {
    if (plant.photos.isEmpty) return;
    final photo = plant.photos.first;
    final controller = TextEditingController(text: photo.description ?? '');
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Text(l10n.editDescriptionTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
          content: TextField(
            controller: controller,
            autofocus: true,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: l10n.addDescriptionLabel,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 2),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.cancelButton, style: TextStyle(color: Colors.grey.shade700)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                final newDescription = controller.text.trim();
                context.read<PlantListBloc>().add(
                  UpdatePhotoDescription(
                    herbariumId: widget.herbarium.id,
                    plantId: plant.id,
                    photoId: photo.id,
                    newDescription: newDescription,
                  ),
                );
                Navigator.pop(ctx);
              },
              child: Text(l10n.saveButton),
            ),
          ],
        );
      },
    );
  }

  void _showPlantOptions(BuildContext context, Plant plant, AppLocalizations l10n) {
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
                leading: const Icon(Icons.edit_rounded, color: Color(0xFF2E7D32)),
                title: Text(l10n.editNameTitle, style: const TextStyle(fontWeight: FontWeight.w600)),
                onTap: () {
                  Navigator.pop(ctx);
                  _showEditNameDialog(context, plant, l10n);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline_rounded, color: Colors.red),
                title: Text(l10n.deletePlant, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.red)),
                onTap: () {
                  Navigator.pop(ctx);
                  _showDeletePlantConfirmDialog(context, plant, l10n);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showDeletePlantConfirmDialog(BuildContext context, Plant plant, AppLocalizations l10n) {
    final plantName = (plant.name != null && plant.name!.isNotEmpty) ? plant.name! : (plant.detectedSpecies ?? l10n.unnamedPlant);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(l10n.deletePlantTitle, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
        content: Text(l10n.deletePlantContent(plantName)),
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
              context.read<PlantListBloc>().add(DeletePlant(
                herbariumId: widget.herbarium.id, 
                plantId: plant.id,
              ));
              Navigator.pop(ctx);
              
              if (Navigator.canPop(context)) {
                 Navigator.pop(context);
              }
            },
            child: Text(l10n.deleteAction),
          ),
        ],
      ),
    );
  }
}
