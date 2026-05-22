import '../../../../core/api/api_service.dart';
import '../models/herbarium_request.dart';
import '../models/herbarium_response.dart';

abstract class HerbariumRemoteDataSource {
  Future<List<HerbariumResponse>> getMyHerbaria();
  Future<List<HerbariumResponse>> getPublicHerbaria();
  Future<HerbariumResponse> getHerbarium(String herbariumId);
  Future<HerbariumResponse> createHerbarium(HerbariumRequest request);
  Future<HerbariumResponse> updateHerbarium(String herbariumId, HerbariumRequest request);
  Future<void> deleteHerbarium(String herbariumId);
}

class HerbariumRemoteDataSourceImpl implements HerbariumRemoteDataSource {
  final ApiService _apiService;

  HerbariumRemoteDataSourceImpl(this._apiService);

  @override
  Future<List<HerbariumResponse>> getMyHerbaria() async {
    final response = await _apiService.client.get('/herbaria/me');
    return (response.data as List).map((e) => HerbariumResponse.fromJson(e)).toList();
  }

  @override
  Future<List<HerbariumResponse>> getPublicHerbaria() async {
    final response = await _apiService.client.get('/herbaria/public');
    return (response.data as List).map((e) => HerbariumResponse.fromJson(e)).toList();
  }

  @override
  Future<HerbariumResponse> getHerbarium(String herbariumId) async {
    final response = await _apiService.client.get('/herbaria/$herbariumId');
    return HerbariumResponse.fromJson(response.data);
  }

  @override
  Future<HerbariumResponse> createHerbarium(HerbariumRequest request) async {
    final response = await _apiService.client.post(
      '/herbaria',
      data: request.toJson(),
    );
    return HerbariumResponse.fromJson(response.data);
  }

  @override
  Future<HerbariumResponse> updateHerbarium(String herbariumId, HerbariumRequest request) async {
    final response = await _apiService.client.patch(
      '/herbaria/$herbariumId',
      data: request.toJson(),
    );
    return HerbariumResponse.fromJson(response.data);
  }

  @override
  Future<void> deleteHerbarium(String herbariumId) async {
    await _apiService.client.delete('/herbaria/$herbariumId');
  }
}
