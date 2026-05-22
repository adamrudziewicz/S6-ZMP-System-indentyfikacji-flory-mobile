import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/plant_identification_bloc.dart';
import '../bloc/plant_identification_event.dart';
import '../bloc/plant_identification_state.dart';

class PlantEditorPage extends StatefulWidget {
  final String photoPath;
  final String herbariumId;

  const PlantEditorPage({super.key, required this.photoPath, required this.herbariumId});

  @override
  State<PlantEditorPage> createState() => _PlantEditorPageState();
}

class _PlantEditorPageState extends State<PlantEditorPage> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PlantIdentificationBloc>().add(ResetPlantIdentification());
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _identifyPlant() {
    context.read<PlantIdentificationBloc>().add(
      IdentifyPlant(
        herbariumId: widget.herbariumId,
        photoFile: File(widget.photoPath),
        description: _descriptionController.text.isNotEmpty ? _descriptionController.text.trim() : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white, shadows: [Shadow(color: Colors.black54, blurRadius: 10)]),
      ),
      body: BlocConsumer<PlantIdentificationBloc, PlantIdentificationState>(
        listener: (context, state) {
          if (state is PlantIdentificationSuccess) {
            if (state.plant.recognized) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.plantSavedSuccess),
                  backgroundColor: Colors.green.shade700,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              Future.delayed(const Duration(seconds: 2), () {
                if (mounted) Navigator.pop(context, true);
              });
            }
          } else if (state is PlantIdentificationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${l10n.identificationError}${state.message}'),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Hero(
                      tag: 'plant_photo',
                      child: Container(
                        height: 350,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 15,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.file(
                              File(widget.photoPath),
                              fit: BoxFit.cover,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.transparent, const Color(0xFFF9FBF9).withOpacity(1)],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            l10n.plantDetailsTitle,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1B5E20),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l10n.plantDetailsSubtitle,
                            style: const TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(height: 24),
                          
                          TextField(
                            controller: _descriptionController,
                            maxLines: 4,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              labelText: l10n.notesOptionalLabel,
                              labelStyle: TextStyle(color: Colors.grey.shade600),
                              alignLabelWithHint: true,
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),

                          if (state is PlantIdentificationSuccess) ...[
                            if (state.plant.recognized) ...[
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: Colors.green.shade200,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.check_circle_rounded,
                                      color: Colors.green.shade700,
                                      size: 40,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      l10n.plantRecognized,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green.shade800,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      state.plant.detectedSpecies ?? l10n.unknownSpecies,
                                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${l10n.confidenceLabel}${((state.plant.confidence ?? 0) * 100).toStringAsFixed(1)}%',
                                      style: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 32),
                            ] else ...[
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade50,
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: Colors.orange.shade200,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.help_outline_rounded,
                                      color: Colors.orange.shade700,
                                      size: 40,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      l10n.plantNotRecognized,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange.shade800,
                                      ),
                                    ),
                                    if (state.plant.detectedSpecies != null && state.plant.detectedSpecies!.isNotEmpty) ...[
                                      const SizedBox(height: 16),
                                      Text(
                                        l10n.aiSuggestion,
                                        style: TextStyle(fontSize: 13, color: Colors.orange.shade900, fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        state.plant.detectedSpecies!,
                                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                                        textAlign: TextAlign.center,
                                      ),
                                      if (state.plant.confidence != null) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          '${l10n.confidenceLabel}${((state.plant.confidence ?? 0) * 100).toStringAsFixed(1)}%',
                                          style: TextStyle(color: Colors.orange.shade800, fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ],
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                l10n.chooseAction,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.green.shade900),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF2E7D32).withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2E7D32),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    elevation: 0,
                                  ),
                                  icon: const Icon(Icons.add_box_rounded),
                                  label: Text(
                                    l10n.addNewPlant(state.plant.detectedSpecies ?? l10n.unknownPlant),
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    context.read<PlantIdentificationBloc>().add(
                                      ConfirmPlant(
                                        herbariumId: widget.herbariumId,
                                        pendingPhotoId: state.plant.id,
                                        decisionType: "new",
                                      ),
                                    );
                                  },
                                ),
                              ),
                              if (state.plant.recommendedPlants.isNotEmpty) ...[
                                const SizedBox(height: 24),
                                Text(
                                  l10n.addToExisting,
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey.shade800),
                                ),
                                const SizedBox(height: 8),
                                ...state.plant.recommendedPlants.map((recPlant) {
                                  return Card(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      side: BorderSide(color: Colors.green.shade100, width: 1),
                                    ),
                                    elevation: 0,
                                    color: Colors.white,
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.green.shade50,
                                        child: const Icon(Icons.local_florist_rounded, color: Color(0xFF2E7D32)),
                                      ),
                                      title: Text(
                                        recPlant.name ?? recPlant.detectedSpecies ?? l10n.unnamedPlant,
                                        style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
                                      ),
                                      subtitle: Text(
                                        l10n.photoCount(recPlant.photos.length),
                                        style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                                      ),
                                      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Color(0xFF2E7D32)),
                                      onTap: () {
                                        context.read<PlantIdentificationBloc>().add(
                                          ConfirmPlant(
                                            herbariumId: widget.herbariumId,
                                            pendingPhotoId: state.plant.id,
                                            decisionType: "existing",
                                            existingPlantId: recPlant.id,
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }).toList(),
                              ],
                              const SizedBox(height: 32),
                            ],
                          ] else if (state is! PlantIdentificationLoading) ...[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF2E7D32).withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2E7D32),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 18),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  elevation: 0,
                                ),
                                icon: const Icon(Icons.auto_awesome_rounded),
                                label: Text(l10n.identifyWithAiButton, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                                onPressed: _identifyPlant,
                              ),
                            ),
                          ],
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              if (state is PlantIdentificationLoading)
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      color: Colors.white.withOpacity(0.5),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 30,
                                offset: const Offset(0, 10),
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const CircularProgressIndicator(color: Color(0xFF2E7D32), strokeWidth: 4),
                              const SizedBox(height: 24),
                              Text(
                                l10n.aiAnalyzing,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1B5E20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
