import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/network/error_handler.dart';
import '../../../domain/use_cases/get_plants_use_case.dart';
import '../../../domain/use_cases/update_plant_name_use_case.dart';
import '../../../domain/use_cases/update_photo_description_use_case.dart';
import '../../../domain/use_cases/delete_plant_use_case.dart';
import '../../../domain/entities/plant.dart';
import 'plant_list_event.dart';
import 'plant_list_state.dart';

class PlantListBloc extends Bloc<PlantListEvent, PlantListState> {
  final GetPlantsUseCase _getPlantsUseCase;
  final UpdatePlantNameUseCase _updatePlantNameUseCase;
  final UpdatePhotoDescriptionUseCase _updatePhotoDescriptionUseCase;
  final DeletePlantUseCase _deletePlantUseCase;

  PlantListBloc({
    required GetPlantsUseCase getPlantsUseCase,
    required UpdatePlantNameUseCase updatePlantNameUseCase,
    required UpdatePhotoDescriptionUseCase updatePhotoDescriptionUseCase,
    required DeletePlantUseCase deletePlantUseCase,
  })  : _getPlantsUseCase = getPlantsUseCase,
        _updatePlantNameUseCase = updatePlantNameUseCase,
        _updatePhotoDescriptionUseCase = updatePhotoDescriptionUseCase,
        _deletePlantUseCase = deletePlantUseCase,
        super(PlantListInitial()) {
    on<LoadPlants>(_onLoadPlants);
    on<UpdatePlantName>(_onUpdatePlantName);
    on<UpdatePhotoDescription>(_onUpdatePhotoDescription);
    on<DeletePlant>(_onDeletePlant);
  }

  Future<void> _onLoadPlants(LoadPlants event, Emitter<PlantListState> emit) async {
    final currentState = state;
    if (currentState is! PlantListLoaded) {
      emit(PlantListLoading());
    }
    try {
      final plants = await _getPlantsUseCase(event.herbariumId);
      emit(PlantListLoaded(plants));
    } catch (e) {
      emit(PlantListError(ErrorHandler.mapError(e)));
      if (currentState is PlantListLoaded) {
        emit(currentState);
      }
    }
  }

  Future<void> _onUpdatePlantName(UpdatePlantName event, Emitter<PlantListState> emit) async {
    final currentState = state;
    List<Plant> currentPlants = [];
    if (currentState is PlantListLoaded) {
      currentPlants = List.from(currentState.plants);
    }
    
    try {
      final updatedPlant = await _updatePlantNameUseCase(
        event.herbariumId,
        event.plantId,
        event.newName,
      );
      
      final updatedList = currentPlants.map((plant) {
        return plant.id == event.plantId ? updatedPlant : plant;
      }).toList();
      
      emit(PlantListLoaded(updatedList));
    } catch (e) {
      emit(PlantListError(ErrorHandler.mapError(e)));
      if (currentPlants.isNotEmpty) {
        emit(PlantListLoaded(currentPlants));
      }
    }
  }

  Future<void> _onUpdatePhotoDescription(UpdatePhotoDescription event, Emitter<PlantListState> emit) async {
    final currentState = state;
    List<Plant> currentPlants = [];
    if (currentState is PlantListLoaded) {
      currentPlants = List.from(currentState.plants);
    }
    
    try {
      await _updatePhotoDescriptionUseCase(
        event.herbariumId,
        event.plantId,
        event.photoId,
        event.newDescription,
      );
      
      final updatedList = await _getPlantsUseCase(event.herbariumId);
      
      emit(PlantListLoaded(updatedList));
    } catch (e) {
      emit(PlantListError(ErrorHandler.mapError(e)));
      if (currentPlants.isNotEmpty) {
        emit(PlantListLoaded(currentPlants));
      }
    }
  }

  Future<void> _onDeletePlant(DeletePlant event, Emitter<PlantListState> emit) async {
    final currentState = state;
    List<Plant> currentPlants = [];
    if (currentState is PlantListLoaded) {
      currentPlants = List.from(currentState.plants);
    }
    
    try {
      await _deletePlantUseCase(herbariumId: event.herbariumId, plantId: event.plantId);
      
      final updatedList = currentPlants.where((plant) => plant.id != event.plantId).toList();
      
      emit(PlantListLoaded(updatedList));
    } catch (e) {
      emit(PlantListError(ErrorHandler.mapError(e)));
      if (currentPlants.isNotEmpty) {
        emit(PlantListLoaded(currentPlants));
      }
    }
  }
}

