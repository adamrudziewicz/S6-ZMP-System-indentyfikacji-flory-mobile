import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:system_identyfikacji_flory/core/network/app_exception.dart';
import 'package:system_identyfikacji_flory/features/plants/domain/entities/plant.dart';
import 'package:system_identyfikacji_flory/features/plants/presentation/bloc/plant_identification_bloc.dart';
import 'package:system_identyfikacji_flory/features/plants/presentation/bloc/plant_identification_event.dart';
import 'package:system_identyfikacji_flory/features/plants/presentation/bloc/plant_identification_state.dart';
import 'package:system_identyfikacji_flory/features/plants/domain/use_cases/add_plant_use_case.dart';
import 'package:system_identyfikacji_flory/features/plants/domain/use_cases/confirm_plant_use_case.dart';
import 'package:system_identyfikacji_flory/features/plants/domain/repositories/plant_repository.dart';

class MockPlantRepository implements PlantRepository {
  @override Future<Plant> addPlant(String herbariumId, File photoFile, {String? photoDescription}) { throw UnimplementedError(); }
  @override Future<Plant> confirmPlant(String herbariumId, String pendingPhotoId, String decisionType, {String? existingPlantId}) { throw UnimplementedError(); }
  @override Future<void> deletePlant(String herbariumId, String plantId) { throw UnimplementedError(); }
  @override Future<List<Plant>> getPlants(String herbariumId) { throw UnimplementedError(); }
  @override Future<void> updatePhotoDescription(String herbariumId, String plantId, String photoId, String description) { throw UnimplementedError(); }
  @override Future<Plant> updatePlantName(String herbariumId, String plantId, String name) { throw UnimplementedError(); }
}

class MockAddPlantUseCase implements AddPlantUseCase {
  @override
  final PlantRepository repository = MockPlantRepository();
  
  Future<Plant> Function({required String herbariumId, required File photoFile, String? photoDescription})? stub;

  @override
  Future<Plant> call({required String herbariumId, required File photoFile, String? photoDescription}) async {
    return stub!(herbariumId: herbariumId, photoFile: photoFile, photoDescription: photoDescription);
  }
}

class MockConfirmPlantUseCase implements ConfirmPlantUseCase {
  @override
  final PlantRepository repository = MockPlantRepository();
  
  Future<Plant> Function({required String herbariumId, required String pendingPhotoId, required String decisionType, String? existingPlantId})? stub;

  @override
  Future<Plant> call({required String herbariumId, required String pendingPhotoId, required String decisionType, String? existingPlantId}) async {
    return stub!(herbariumId: herbariumId, pendingPhotoId: pendingPhotoId, decisionType: decisionType, existingPlantId: existingPlantId);
  }
}

void main() {
  late MockAddPlantUseCase mockAdd;
  late MockConfirmPlantUseCase mockConfirm;
  late PlantIdentificationBloc bloc;

  setUp(() {
    mockAdd = MockAddPlantUseCase();
    mockConfirm = MockConfirmPlantUseCase();
    bloc = PlantIdentificationBloc(
      addPlantUseCase: mockAdd,
      confirmPlantUseCase: mockConfirm,
    );
  });

  tearDown(() {
    bloc.close();
  });

  final dummyPlant = Plant(id: '1', herbariumId: 'h1', name: 'AI Plant', recognized: false);
  final dummyFile = File('dummy.jpg');

  group('PlantIdentificationBloc - IdentifyPlant', () {
    test('emits [PlantIdentificationLoading, PlantIdentificationSuccess] on success', () {
      mockAdd.stub = ({required herbariumId, required photoFile, photoDescription}) async => dummyPlant;

      final expectedStates = [
        isA<PlantIdentificationLoading>(),
        isA<PlantIdentificationSuccess>().having((s) => s.plant.name, 'name', 'AI Plant'),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(IdentifyPlant(herbariumId: 'h1', photoFile: dummyFile));
    });

    test('emits [PlantIdentificationLoading, PlantIdentificationError] on network failure', () {
      mockAdd.stub = ({required herbariumId, required photoFile, photoDescription}) async {
        throw DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(requestOptions: RequestOptions(path: ''), statusCode: 403),
        );
      };

      final expectedStates = [
        isA<PlantIdentificationLoading>(),
        isA<PlantIdentificationError>().having((s) => s.exception, 'exception', isA<ForbiddenException>()),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(IdentifyPlant(herbariumId: 'h1', photoFile: dummyFile));
    });
  });

  group('PlantIdentificationBloc - ConfirmPlant', () {
    test('emits [PlantIdentificationLoading, PlantIdentificationSuccess] on confirm success', () {
      mockConfirm.stub = ({required herbariumId, required pendingPhotoId, required decisionType, existingPlantId}) async => dummyPlant;

      final expectedStates = [
        isA<PlantIdentificationLoading>(),
        isA<PlantIdentificationSuccess>().having((s) => s.plant.name, 'name', 'AI Plant'),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(const ConfirmPlant(herbariumId: 'h1', pendingPhotoId: 'p1', decisionType: 'NEW'));
    });
    
    test('emits [PlantIdentificationInitial] on reset', () {
      final expectedStates = [
        isA<PlantIdentificationInitial>(),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(ResetPlantIdentification());
    });
  });
}
