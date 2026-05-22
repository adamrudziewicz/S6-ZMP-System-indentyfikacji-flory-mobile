import 'package:equatable/equatable.dart';

abstract class PlantListEvent extends Equatable {
  const PlantListEvent();

  @override
  List<Object> get props => [];
}

class LoadPlants extends PlantListEvent {
  final String herbariumId;

  const LoadPlants(this.herbariumId);

  @override
  List<Object> get props => [herbariumId];
}

class UpdatePlantName extends PlantListEvent {
  final String herbariumId;
  final String plantId;
  final String newName;

  const UpdatePlantName({
    required this.herbariumId,
    required this.plantId,
    required this.newName,
  });

  @override
  List<Object> get props => [herbariumId, plantId, newName];
}

class UpdatePhotoDescription extends PlantListEvent {
  final String herbariumId;
  final String plantId;
  final String photoId;
  final String newDescription;

  const UpdatePhotoDescription({
    required this.herbariumId,
    required this.plantId,
    required this.photoId,
    required this.newDescription,
  });

  @override
  List<Object> get props => [herbariumId, plantId, photoId, newDescription];
}

class DeletePlant extends PlantListEvent {
  final String herbariumId;
  final String plantId;

  const DeletePlant({
    required this.herbariumId,
    required this.plantId,
  });

  @override
  List<Object> get props => [herbariumId, plantId];
}

