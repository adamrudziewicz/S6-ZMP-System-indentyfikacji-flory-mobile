import 'package:equatable/equatable.dart';
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
  final String message;

  const PlantListError(this.message);

  @override
  List<Object> get props => [message];
}
