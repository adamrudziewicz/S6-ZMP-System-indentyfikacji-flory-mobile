import 'dart:io';
import '../entities/plant.dart';

abstract class PlantRepository {
  Future<Plant> addPlant(String herbariumId, File photoFile, {String? photoDescription});
  Future<Plant> confirmPlant(String herbariumId, String pendingPhotoId, String decisionType, {String? existingPlantId});
  Future<List<Plant>> getPlants(String herbariumId);
  Future<Plant> updatePlantName(String herbariumId, String plantId, String name);
  Future<Plant> updatePhotoDescription(String herbariumId, String plantId, String photoId, String description);
  Future<void> deletePlant(String herbariumId, String plantId);
}
