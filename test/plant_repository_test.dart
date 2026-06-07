import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:system_identyfikacji_flory/features/plants/data/repositories/plant_repository_impl.dart';
import 'package:system_identyfikacji_flory/features/plants/data/data_sources/plant_remote_data_source.dart';
import 'package:system_identyfikacji_flory/features/plants/data/data_sources/plant_local_data_source.dart';
import 'package:system_identyfikacji_flory/features/plants/data/models/plant_response.dart';
import 'package:system_identyfikacji_flory/features/plants/domain/entities/plant.dart';
import 'package:system_identyfikacji_flory/core/network/network_info.dart';
import 'dart:io';
import 'package:system_identyfikacji_flory/features/plants/data/models/plant_confirm_request.dart';
import 'package:system_identyfikacji_flory/features/plants/data/models/plant_update_request.dart';
import 'package:system_identyfikacji_flory/features/plants/data/models/plant_identification_choice.dart';

class MockRemoteDataSource implements PlantRemoteDataSource {
  Future<List<PlantResponse>> Function(String)? getPlantsStub;

  @override
  Future<List<PlantResponse>> getPlants(String herbariumId) async {
    if (getPlantsStub != null) return getPlantsStub!(herbariumId);
    return [];
  }

  @override
  Future<PlantIdentificationChoice> addPlant(String herbariumId, File photoFile, {String? photoDescription}) { throw UnimplementedError(); }
  @override
  Future<PlantResponse> confirmPlant(String herbariumId, PlantConfirmRequest request) { throw UnimplementedError(); }
  @override
  Future<void> deletePlant(String herbariumId, String plantId) { throw UnimplementedError(); }
  @override
  Future<PlantResponse> getPlant(String herbariumId, String plantId) { throw UnimplementedError(); }
  @override
  Future<void> updatePhotoDescription(String herbariumId, String plantId, String photoId, String description) { throw UnimplementedError(); }
  @override
  Future<PlantResponse> updatePlant(String herbariumId, String plantId, PlantUpdateRequest request) { throw UnimplementedError(); }
}

class MockLocalDataSource implements PlantLocalDataSource {
  Future<List<PlantResponse>> Function(String)? getCachedPlantsStub;
  Future<void> Function(String, List<PlantResponse>)? cachePlantsStub;
  bool cacheCalled = false;

  @override
  Future<void> cachePlants(String herbariumId, List<PlantResponse> plants) async {
    cacheCalled = true;
    if (cachePlantsStub != null) return cachePlantsStub!(herbariumId, plants);
  }

  @override
  Future<List<PlantResponse>> getCachedPlants(String herbariumId) async {
    if (getCachedPlantsStub != null) return getCachedPlantsStub!(herbariumId);
    return [];
  }

  @override
  Future<void> clearCache() { throw UnimplementedError(); }
}

class MockNetworkInfo implements NetworkInfo {
  bool isConnectedStub = true;
  @override
  Future<bool> get isConnected async => isConnectedStub;
}

void main() {
  late MockRemoteDataSource mockRemote;
  late MockLocalDataSource mockLocal;
  late MockNetworkInfo mockNetwork;
  late PlantRepositoryImpl repository;

  setUp(() {
    mockRemote = MockRemoteDataSource();
    mockLocal = MockLocalDataSource();
    mockNetwork = MockNetworkInfo();
    repository = PlantRepositoryImpl(mockRemote, mockLocal, mockNetwork);
  });

  final dummyResponse = PlantResponse(
    id: '1',
    herbariumId: 'h1',
    name: 'Remote Plant',
    photos: [],
  );

  final cachedResponse = PlantResponse(
    id: '2',
    herbariumId: 'h1',
    name: 'Cached Plant',
    photos: [],
  );

  group('PlantRepositoryImpl - Edge Cases', () {
    test('getPlants returns remote data and caches it when online', () async {
      mockNetwork.isConnectedStub = true;
      mockRemote.getPlantsStub = (hId) async => [dummyResponse];

      final result = await repository.getPlants('h1');
      
      expect(result.length, 1);
      expect(result.first.name, 'Remote Plant');
      expect(mockLocal.cacheCalled, isTrue);
    });

    test('getPlants returns cached data when offline', () async {
      mockNetwork.isConnectedStub = false;
      mockLocal.getCachedPlantsStub = (hId) async => [cachedResponse];

      final result = await repository.getPlants('h1');
      
      expect(result.length, 1);
      expect(result.first.name, 'Cached Plant');
      expect(mockLocal.cacheCalled, isFalse);
    });

    test('getPlants returns empty list when offline and no cache', () async {
      mockNetwork.isConnectedStub = false;
      mockLocal.getCachedPlantsStub = (hId) async => [];

      final result = await repository.getPlants('h1');
      
      expect(result, isEmpty);
    });

    test('getPlants falls back to cached data when online but remote throws DioException', () async {
      mockNetwork.isConnectedStub = true;
      mockRemote.getPlantsStub = (hId) async {
        throw DioException(requestOptions: RequestOptions(path: ''));
      };
      mockLocal.getCachedPlantsStub = (hId) async => [cachedResponse];

      final result = await repository.getPlants('h1');
      
      expect(result.length, 1);
      expect(result.first.name, 'Cached Plant');
    });

    test('getPlants rethrows DioException when online but remote throws and cache is empty', () async {
      mockNetwork.isConnectedStub = true;
      mockRemote.getPlantsStub = (hId) async {
        throw DioException(requestOptions: RequestOptions(path: ''));
      };
      mockLocal.getCachedPlantsStub = (hId) async => [];

      expect(() => repository.getPlants('h1'), throwsA(isA<DioException>()));
    });
    
    test('getPlants rethrows general Exceptions immediately, bypassing cache fallback', () async {
      mockNetwork.isConnectedStub = true;
      mockRemote.getPlantsStub = (hId) async {
        throw FormatException('Malformed JSON');
      };
      mockLocal.getCachedPlantsStub = (hId) async => [cachedResponse];

      expect(() => repository.getPlants('h1'), throwsA(isA<FormatException>()));
    });
  });
}
