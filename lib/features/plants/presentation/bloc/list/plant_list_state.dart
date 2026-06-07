import 'package:equatable/equatable.dart';
import '../../../../../core/network/app_exception.dart';
import '../../../domain/entities/plant.dart';

abstract class PlantListState extends Equatable {
  const PlantListState();

  @override
  List<Object> get props => [];
}

class PlantListInitial extends PlantListState {}

class PlantListLoading extends PlantListState {}

class PlantListLoaded extends PlantListState {
  final List<Plant> plants;

  const PlantListLoaded(this.plants);

  @override
  List<Object> get props => [plants];
}

class PlantListError extends PlantListState {
  final AppException exception;

  const PlantListError(this.exception);

  @override
  List<Object> get props => [exception];
}
