import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/error_handler.dart';
import '../../domain/use_cases/add_plant_use_case.dart';
import '../../domain/use_cases/confirm_plant_use_case.dart';
import 'plant_identification_event.dart';
import 'plant_identification_state.dart';

class PlantIdentificationBloc extends Bloc<PlantIdentificationEvent, PlantIdentificationState> {
  final AddPlantUseCase _addPlantUseCase;
  final ConfirmPlantUseCase _confirmPlantUseCase;

  PlantIdentificationBloc({
    required AddPlantUseCase addPlantUseCase,
    required ConfirmPlantUseCase confirmPlantUseCase,
  })  : _addPlantUseCase = addPlantUseCase,
        _confirmPlantUseCase = confirmPlantUseCase,
        super(PlantIdentificationInitial()) {
    on<IdentifyPlant>(_onIdentifyPlant);
    on<ConfirmPlant>(_onConfirmPlant);
    on<ResetPlantIdentification>(_onReset);
  }

  void _onReset(ResetPlantIdentification event, Emitter<PlantIdentificationState> emit) {
    emit(PlantIdentificationInitial());
  }

  Future<void> _onIdentifyPlant(IdentifyPlant event, Emitter<PlantIdentificationState> emit) async {
    emit(PlantIdentificationLoading());
    try {
      final plant = await _addPlantUseCase(
        herbariumId: event.herbariumId,
        photoFile: event.photoFile,
        photoDescription: event.description,
      );
      emit(PlantIdentificationSuccess(plant));
    } catch (e) {
      emit(PlantIdentificationError(ErrorHandler.mapError(e)));
    }
  }

  Future<void> _onConfirmPlant(ConfirmPlant event, Emitter<PlantIdentificationState> emit) async {
    emit(PlantIdentificationLoading());
    try {
      final plant = await _confirmPlantUseCase(
        herbariumId: event.herbariumId,
        pendingPhotoId: event.pendingPhotoId,
        decisionType: event.decisionType,
        existingPlantId: event.existingPlantId,
      );
      emit(PlantIdentificationSuccess(plant));
    } catch (e) {
      emit(PlantIdentificationError(ErrorHandler.mapError(e)));
    }
  }
}
