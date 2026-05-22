import 'dart:io';
import '../../domain/entities/plant.dart';
import '../../domain/entities/plant_photo.dart';
import '../../domain/repositories/plant_repository.dart';
import '../data_sources/plant_remote_data_source.dart';
import '../models/plant_confirm_request.dart';
import '../models/plant_response.dart';
import '../models/plant_update_request.dart';

class PlantRepositoryImpl implements PlantRepository {
  final PlantRemoteDataSource _remoteDataSource;

  PlantRepositoryImpl(this._remoteDataSource);

  Plant _mapDtoToEntity(PlantResponse dto) {
    final hasPhotos = dto.photos.isNotEmpty;
    final firstPhotoConfidence = hasPhotos ? dto.photos.first.confidence : null;
    final recognized = dto.detectedSpecies != null && dto.detectedSpecies!.isNotEmpty;

    return Plant(
      id: dto.id,
      herbariumId: dto.herbariumId,
      name: dto.name,
      recognized: recognized,
      detectedSpecies: dto.detectedSpecies,
      speciesId: dto.speciesId,
      family: dto.family,
      genus: dto.genus,
      commonNames: dto.commonNames,
      confidence: firstPhotoConfidence,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      photos: dto.photos.map((photoDto) => PlantPhoto(
        id: photoDto.id,
        plantId: photoDto.plantId,
        url: photoDto.url,
        description: photoDto.description,
        confidence: photoDto.confidence,
        createdAt: photoDto.createdAt,
      )).toList(),
    );
  }

  @override
  Future<Plant> addPlant(String herbariumId, File photoFile, {String? photoDescription}) async {
    final response = await _remoteDataSource.addPlant(
      herbariumId, 
      photoFile, 
      photoDescription: photoDescription,
    );
    if (response.resolved && response.plant != null) {
      return _mapDtoToEntity(response.plant!);
    } else {
      return Plant(
        id: response.pendingPhotoId ?? '',
        herbariumId: herbariumId,
        recognized: false,
        detectedSpecies: response.identification?.detectedSpecies,
        speciesId: response.identification?.speciesId,
        family: response.identification?.family,
        genus: response.identification?.genus,
        commonNames: response.identification?.commonNames,
        confidence: response.identification?.confidence,
        photos: [],
        recommendedPlants: response.recommendedPlants.map(_mapDtoToEntity).toList(),
      );
    }
  }

  @override
  Future<Plant> confirmPlant(String herbariumId, String pendingPhotoId, String decisionType, {String? existingPlantId}) async {
    final response = await _remoteDataSource.confirmPlant(
      herbariumId,
      PlantConfirmRequest(
        pendingPhotoId: pendingPhotoId,
        decisionType: decisionType,
        existingPlantId: existingPlantId,
      ),
    );
    return _mapDtoToEntity(response);
  }

  @override
  Future<List<Plant>> getPlants(String herbariumId) async {
    final responseList = await _remoteDataSource.getPlants(herbariumId);
    return responseList.map(_mapDtoToEntity).toList();
  }

  @override
  Future<Plant> updatePlantName(String herbariumId, String plantId, String name) async {
    final response = await _remoteDataSource.updatePlant(
      herbariumId, 
      plantId, 
      PlantUpdateRequest(name: name),
    );
    return _mapDtoToEntity(response);
  }

  @override
  Future<Plant> updatePhotoDescription(String herbariumId, String plantId, String photoId, String description) async {
    await _remoteDataSource.updatePhotoDescription(herbariumId, plantId, photoId, description);
    final response = await _remoteDataSource.getPlant(herbariumId, plantId);
    return _mapDtoToEntity(response);
  }

  @override
  Future<void> deletePlant(String herbariumId, String plantId) async {
    await _remoteDataSource.deletePlant(herbariumId, plantId);
  }
}
