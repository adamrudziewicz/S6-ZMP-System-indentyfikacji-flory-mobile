import 'package:dio/dio.dart';
import 'dart:io';
import '../../../../core/api/api_service.dart';
import '../models/plant_confirm_request.dart';
import '../models/plant_identification_choice.dart';
import '../models/plant_response.dart';
import '../models/plant_update_request.dart';

abstract class PlantRemoteDataSource {
  Future<PlantIdentificationChoice> addPlant(String herbariumId, File photoFile, {String? photoDescription});
  Future<PlantResponse> confirmPlant(String herbariumId, PlantConfirmRequest request);
  Future<List<PlantResponse>> getPlants(String herbariumId);
  Future<PlantResponse> getPlant(String herbariumId, String plantId);
  Future<PlantResponse> updatePlant(String herbariumId, String plantId, PlantUpdateRequest request);
  Future<void> updatePhotoDescription(String herbariumId, String plantId, String photoId, String description);
  Future<void> deletePlant(String herbariumId, String plantId);
}

class PlantRemoteDataSourceImpl implements PlantRemoteDataSource {
  final ApiService _apiService;

  PlantRemoteDataSourceImpl(this._apiService);

  @override
  Future<PlantIdentificationChoice> addPlant(String herbariumId, File photoFile, {String? photoDescription}) async {
    final fileName = photoFile.path.split('/').last;
    final formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(photoFile.path, filename: fileName),
    });

    final response = await _apiService.client.post(
      '/herbaria/$herbariumId/plants/add',
      data: formData,
      queryParameters: {
        if (photoDescription != null) 'photoDescription': photoDescription,
      },
    );
    return PlantIdentificationChoice.fromJson(response.data);
  }

  @override
  Future<PlantResponse> confirmPlant(String herbariumId, PlantConfirmRequest request) async {
    final response = await _apiService.client.post(
      '/herbaria/$herbariumId/plants/confirm',
      data: request.toJson(),
    );
    return PlantResponse.fromJson(response.data);
  }

  @override
  Future<List<PlantResponse>> getPlants(String herbariumId) async {
    final response = await _apiService.client.get('/herbaria/$herbariumId/plants');
    return (response.data as List).map((e) => PlantResponse.fromJson(e)).toList();
  }

  @override
  Future<PlantResponse> getPlant(String herbariumId, String plantId) async {
    final response = await _apiService.client.get('/herbaria/$herbariumId/plants/$plantId');
    return PlantResponse.fromJson(response.data);
  }

  @override
  Future<PlantResponse> updatePlant(String herbariumId, String plantId, PlantUpdateRequest request) async {
    final response = await _apiService.client.patch(
      '/herbaria/$herbariumId/plants/$plantId',
      data: request.toJson(),
    );
    return PlantResponse.fromJson(response.data);
  }

  @override
  Future<void> updatePhotoDescription(String herbariumId, String plantId, String photoId, String description) async {
    await _apiService.client.patch(
      '/herbaria/$herbariumId/plants/$plantId/photos/$photoId',
      data: {'description': description},
    );
  }

  @override
  Future<void> deletePlant(String herbariumId, String plantId) async {
    await _apiService.client.delete('/herbaria/$herbariumId/plants/$plantId');
  }
}
