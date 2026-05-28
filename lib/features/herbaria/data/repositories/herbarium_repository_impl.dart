import '../../../../core/network/network_info.dart';
import '../../domain/entities/herbarium.dart';
import '../../domain/repositories/herbarium_repository.dart';
import '../data_sources/herbarium_local_data_source.dart';
import '../data_sources/herbarium_remote_data_source.dart';
import '../models/herbarium_request.dart';
import '../models/herbarium_response.dart';

class HerbariumRepositoryImpl implements HerbariumRepository {
  final HerbariumRemoteDataSource _remoteDataSource;
  final HerbariumLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  HerbariumRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
  );

  Herbarium _mapDtoToEntity(HerbariumResponse dto) {
    return Herbarium(
      id: dto.id,
      userId: dto.userId,
      name: dto.name,
      description: dto.description,
      isPublic: dto.isPublic,
      plantCount: dto.plantCount,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }

  Future<void> _syncQueue() async {
    final hasConnection = await _networkInfo.isConnected;
    if (!hasConnection) return;

    final queue = await _localDataSource.getSyncQueue();
    if (queue.isEmpty) return;

    for (var requestJson in queue) {
      try {
        final request = HerbariumRequest.fromJson(requestJson);
        await _remoteDataSource.createHerbarium(request);
      } catch (_) {
      }
    }
    await _localDataSource.clearSyncQueue();
  }

  @override
  Future<List<Herbarium>> getMyHerbaria() async {
    final isConnected = await _networkInfo.isConnected;

    if (isConnected) {
      try {
        await _syncQueue();
        final response = await _remoteDataSource.getMyHerbaria();
        await _localDataSource.cacheHerbaria(response);
        return response.map(_mapDtoToEntity).toList();
      } catch (e) {
        final localData = await _localDataSource.getCachedHerbaria();
        return localData.map(_mapDtoToEntity).toList();
      }
    } else {
      final localData = await _localDataSource.getCachedHerbaria();
      return localData.map(_mapDtoToEntity).toList();
    }
  }

  @override
  Future<List<Herbarium>> getPublicHerbaria() async {
    final response = await _remoteDataSource.getPublicHerbaria();
    return response.map(_mapDtoToEntity).toList();
  }

  @override
  Future<Herbarium> getHerbarium(String herbariumId) async {
    final response = await _remoteDataSource.getHerbarium(herbariumId);
    return _mapDtoToEntity(response);
  }

  @override
  Future<Herbarium> createHerbarium({
    required String name,
    String? description,
    bool isPublic = false,
  }) async {
    final isConnected = await _networkInfo.isConnected;
    final request = HerbariumRequest(
      name: name,
      description: description,
      isPublic: isPublic,
    );

    if (isConnected) {
      final response = await _remoteDataSource.createHerbarium(request);
      await _localDataSource.cacheHerbarium(response);
      return _mapDtoToEntity(response);
    } else {
      await _localDataSource.addHerbariumToSyncQueue(request.toJson());
      
      final fakeResponse = HerbariumResponse(
        id: 'local_${DateTime.now().millisecondsSinceEpoch}',
        userId: 'current_user',
        name: name,
        description: description,
        isPublic: isPublic,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await _localDataSource.cacheHerbarium(fakeResponse);
      return _mapDtoToEntity(fakeResponse);
    }
  }

  @override
  Future<Herbarium> updateHerbarium(
    String herbariumId, {
    required String name,
    String? description,
    bool isPublic = false,
  }) async {
    final response = await _remoteDataSource.updateHerbarium(
      herbariumId,
      HerbariumRequest(
        name: name,
        description: description,
        isPublic: isPublic,
      ),
    );
    return _mapDtoToEntity(response);
  }

  @override
  Future<void> deleteHerbarium(String herbariumId) async {
    await _remoteDataSource.deleteHerbarium(herbariumId);
  }
}
