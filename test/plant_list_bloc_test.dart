import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:system_identyfikacji_flory/core/network/app_exception.dart';
import 'package:system_identyfikacji_flory/features/plants/presentation/bloc/list/plant_list_bloc.dart';
import 'package:system_identyfikacji_flory/features/plants/presentation/bloc/list/plant_list_event.dart';
import 'package:system_identyfikacji_flory/features/plants/presentation/bloc/list/plant_list_state.dart';
import 'package:system_identyfikacji_flory/features/plants/domain/entities/plant.dart';
import 'package:system_identyfikacji_flory/features/plants/domain/use_cases/get_plants_use_case.dart';
import 'package:system_identyfikacji_flory/features/plants/domain/use_cases/update_plant_name_use_case.dart';
import 'package:system_identyfikacji_flory/features/plants/domain/use_cases/update_photo_description_use_case.dart';
import 'package:system_identyfikacji_flory/features/plants/domain/use_cases/delete_plant_use_case.dart';
import 'package:system_identyfikacji_flory/features/plants/domain/repositories/plant_repository.dart';

class MockPlantRepository implements PlantRepository {
  Future<List<Plant>> Function(String)? getPlantsStub;
  Future<Plant> Function(String, String, String)? updatePlantNameStub;
  Future<void> Function(String, String, String, String)? updatePhotoDescriptionStub;
  Future<void> Function(String, String)? deletePlantStub;

  @override
  Future<List<Plant>> getPlants(String herbariumId) async {
    if (getPlantsStub != null) return getPlantsStub!(herbariumId);
    return [];
  }

  @override
  Future<Plant> updatePlantName(String herbariumId, String plantId, String name) async {
    if (updatePlantNameStub != null) return updatePlantNameStub!(herbariumId, plantId, name);
    throw UnimplementedError();
  }

  @override
  Future<void> updatePhotoDescription(String herbariumId, String plantId, String photoId, String description) async {
    if (updatePhotoDescriptionStub != null) return updatePhotoDescriptionStub!(herbariumId, plantId, photoId, description);
  }

  @override
  Future<void> deletePlant(String herbariumId, String plantId) async {
    if (deletePlantStub != null) return deletePlantStub!(herbariumId, plantId);
  }

  @override
  Future<Plant> addPlant(String herbariumId, File photoFile, {String? photoDescription}) {
    throw UnimplementedError();
  }

  @override
  Future<Plant> confirmPlant(String herbariumId, String pendingPhotoId, String decisionType, {String? existingPlantId}) {
    throw UnimplementedError();
  }
}

void main() {
  late MockPlantRepository mockRepo;
  late PlantListBloc bloc;

  setUp(() {
    mockRepo = MockPlantRepository();
    bloc = PlantListBloc(
      getPlantsUseCase: GetPlantsUseCase(mockRepo),
      updatePlantNameUseCase: UpdatePlantNameUseCase(mockRepo),
      updatePhotoDescriptionUseCase: UpdatePhotoDescriptionUseCase(mockRepo),
      deletePlantUseCase: DeletePlantUseCase(mockRepo),
    );
  });

  tearDown(() {
    bloc.close();
  });

  final dummyPlant = Plant(
    id: '1',
    herbariumId: 'h1',
    name: 'Test Plant',
    recognized: true,
  );

  group('PlantListBloc - LoadPlants', () {
    test('emits [PlantListLoading, PlantListLoaded] on success', () async {
      mockRepo.getPlantsStub = (hId) async => [dummyPlant];

      final expectedStates = [
        isA<PlantListLoading>(),
        isA<PlantListLoaded>().having((s) => s.plants, 'plants', [dummyPlant]),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(LoadPlants('h1'));
    });

    test('emits [PlantListLoading, PlantListError] on network failure', () async {
      mockRepo.getPlantsStub = (hId) async {
        throw DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(requestOptions: RequestOptions(path: ''), statusCode: 404),
        );
      };

      final expectedStates = [
        isA<PlantListLoading>(),
        isA<PlantListError>().having((s) => s.exception, 'exception', isA<NotFoundException>()),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(LoadPlants('h1'));
    });
  });

  group('PlantListBloc - Edge Cases and State Restores', () {
    test('UpdatePlantName failure restores previous state list', () async {
      mockRepo.getPlantsStub = (hId) async => [dummyPlant];
      bloc.add(LoadPlants('h1'));
      
      await Future.delayed(Duration.zero);

      mockRepo.updatePlantNameStub = (hId, pId, name) async {
        throw DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(requestOptions: RequestOptions(path: ''), statusCode: 401),
        );
      };

      final expectedStates = [
        isA<PlantListError>().having((s) => s.exception, 'exception', isA<SessionExpiredException>()),
        isA<PlantListLoaded>().having((s) => s.plants.first.name, 'name', 'Test Plant'),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(UpdatePlantName(herbariumId: 'h1', plantId: '1', newName: 'Fail'));
    });

    test('UpdatePhotoDescription (CQRS) re-fetches plants on success', () async {
      mockRepo.getPlantsStub = (hId) async => [dummyPlant];
      bloc.add(LoadPlants('h1'));
      
      await Future.delayed(Duration.zero);

      final updatedPlant = Plant(
        id: '1',
        herbariumId: 'h1',
        name: 'Test Plant CQRS',
        recognized: true,
      );

      mockRepo.updatePhotoDescriptionStub = (hId, pId, phId, desc) async {};
      
      mockRepo.getPlantsStub = (hId) async => [updatedPlant];

      final expectedStates = [
        isA<PlantListLoaded>().having((s) => s.plants.first.name, 'name', 'Test Plant CQRS'),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(UpdatePhotoDescription(herbariumId: 'h1', plantId: '1', photoId: 'p1', newDescription: 'CQRS Desc'));
    });
    
    test('DeletePlant removes plant and emits new list', () async {
      final p1 = Plant(id: '1', herbariumId: 'h1', name: 'P1', recognized: true);
      final p2 = Plant(id: '2', herbariumId: 'h1', name: 'P2', recognized: true);
      
      mockRepo.getPlantsStub = (hId) async => [p1, p2];
      bloc.add(LoadPlants('h1'));
      await Future.delayed(Duration.zero);

      mockRepo.deletePlantStub = (hId, pId) async {};

      final expectedStates = [
        isA<PlantListLoaded>().having((s) => s.plants.length, 'length', 1)
                              .having((s) => s.plants.first.id, 'id', '2'),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(DeletePlant(herbariumId: 'h1', plantId: '1'));
    });
  });
}
