import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/error_handler.dart';
import '../../domain/use_cases/create_herbarium_use_case.dart';
import '../../domain/use_cases/get_my_herbaria_use_case.dart';
import '../../domain/use_cases/update_herbarium_use_case.dart';
import '../../domain/use_cases/delete_herbarium_use_case.dart';
import 'herbaria_event.dart';
import 'herbaria_state.dart';

class HerbariaBloc extends Bloc<HerbariaEvent, HerbariaState> {
  final GetMyHerbariaUseCase _getMyHerbaria;
  final CreateHerbariumUseCase _createHerbarium;
  final UpdateHerbariumUseCase _updateHerbarium;
  final DeleteHerbariumUseCase _deleteHerbarium;

  HerbariaBloc({
    required GetMyHerbariaUseCase getMyHerbaria,
    required CreateHerbariumUseCase createHerbarium,
    required UpdateHerbariumUseCase updateHerbarium,
    required DeleteHerbariumUseCase deleteHerbarium,
  })  : _getMyHerbaria = getMyHerbaria,
        _createHerbarium = createHerbarium,
        _updateHerbarium = updateHerbarium,
        _deleteHerbarium = deleteHerbarium,
        super(HerbariaInitial()) {
    on<LoadMyHerbaria>(_onLoadMyHerbaria);
    on<CreateHerbarium>(_onCreateHerbarium);
    on<UpdateHerbarium>(_onUpdateHerbarium);
    on<DeleteHerbarium>(_onDeleteHerbarium);
  }

  Future<void> _onLoadMyHerbaria(LoadMyHerbaria event, Emitter<HerbariaState> emit) async {
    emit(HerbariaLoading());
    try {
      final herbaria = await _getMyHerbaria();
      emit(HerbariaLoaded(herbaria));
    } catch (e) {
      emit(HerbariaError(ErrorHandler.mapError(e)));
    }
  }

  Future<void> _onCreateHerbarium(CreateHerbarium event, Emitter<HerbariaState> emit) async {
    final currentState = state;
    emit(HerbariaLoading());
    try {
      await _createHerbarium(
        name: event.name,
        description: event.description,
        isPublic: event.isPublic,
      );
      emit(const HerbariumActionSuccess('Herbarium utworzone pomyślnie'));
      if (currentState is HerbariaLoaded) {
        add(LoadMyHerbaria());
      }
    } catch (e) {
      emit(HerbariaError(ErrorHandler.mapError(e)));
    }
  }

  Future<void> _onUpdateHerbarium(UpdateHerbarium event, Emitter<HerbariaState> emit) async {
    final currentState = state;
    emit(HerbariaLoading());
    try {
      await _updateHerbarium(
        id: event.id,
        name: event.name,
        description: event.description,
        isPublic: event.isPublic,
      );
      emit(HerbariumActionSuccess(event.isPublic ? 'Herbarium jest teraz publiczne' : 'Herbarium jest teraz prywatne'));
      if (currentState is HerbariaLoaded) {
        add(LoadMyHerbaria());
      }
    } catch (e) {
      emit(HerbariaError(ErrorHandler.mapError(e)));
    }
  }

  Future<void> _onDeleteHerbarium(DeleteHerbarium event, Emitter<HerbariaState> emit) async {
    final currentState = state;
    emit(HerbariaLoading());
    try {
      await _deleteHerbarium(event.id);
      emit(const HerbariumActionSuccess('Zielnik został usunięty'));
      if (currentState is HerbariaLoaded) {
        add(LoadMyHerbaria());
      }
    } catch (e) {
      emit(HerbariaError(ErrorHandler.mapError(e)));
    }
  }
}
