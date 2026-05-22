import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class PlantIdentificationEvent extends Equatable {
  const PlantIdentificationEvent();

  @override
  List<Object?> get props => [];
}

class IdentifyPlant extends PlantIdentificationEvent {
  final String herbariumId;
  final File photoFile;
  final String? description;

  const IdentifyPlant({
    required this.herbariumId,
    required this.photoFile,
    this.description,
  });

  @override
  List<Object?> get props => [herbariumId, photoFile, description];
}

class ConfirmPlant extends PlantIdentificationEvent {
  final String herbariumId;
  final String pendingPhotoId;
  final String decisionType;
  final String? existingPlantId;

  const ConfirmPlant({
    required this.herbariumId,
    required this.pendingPhotoId,
    required this.decisionType,
    this.existingPlantId,
  });

  @override
  List<Object?> get props => [herbariumId, pendingPhotoId, decisionType, existingPlantId];
}

class ResetPlantIdentification extends PlantIdentificationEvent {}
