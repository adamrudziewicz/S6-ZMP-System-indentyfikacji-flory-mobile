import 'package:equatable/equatable.dart';

abstract class HerbariaEvent extends Equatable {
  const HerbariaEvent();

  @override
  List<Object?> get props => [];
}

class LoadMyHerbaria extends HerbariaEvent {}

class CreateHerbarium extends HerbariaEvent {
  final String name;
  final String? description;
  final bool isPublic;

  const CreateHerbarium({
    required this.name,
    this.description,
    this.isPublic = false,
  });

  @override
  List<Object?> get props => [name, description, isPublic];
}

class UpdateHerbarium extends HerbariaEvent {
  final String id;
  final String name;
  final String? description;
  final bool isPublic;
  final bool isVisibilityChange;

  const UpdateHerbarium({
    required this.id,
    required this.name,
    this.description,
    required this.isPublic,
    this.isVisibilityChange = false,
  });

  @override
  List<Object?> get props => [id, name, description, isPublic, isVisibilityChange];
}

class DeleteHerbarium extends HerbariaEvent {
  final String id;

  const DeleteHerbarium(this.id);

  @override
  List<Object?> get props => [id];
}
