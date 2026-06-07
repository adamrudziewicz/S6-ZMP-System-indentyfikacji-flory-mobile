import 'package:equatable/equatable.dart';
import '../../../../core/network/app_exception.dart';
import '../../domain/entities/herbarium.dart';

abstract class HerbariaState extends Equatable {
  const HerbariaState();

  @override
  List<Object?> get props => [];
}

class HerbariaInitial extends HerbariaState {}

class HerbariaLoading extends HerbariaState {}

class HerbariaLoaded extends HerbariaState {
  final List<Herbarium> herbaria;

  const HerbariaLoaded(this.herbaria);

  @override
  List<Object?> get props => [herbaria];
}

class HerbariaError extends HerbariaState {
  final AppException exception;

  const HerbariaError(this.exception);

  @override
  List<Object?> get props => [exception];
}

enum HerbariumActionType {
  created,
  updated,
  deleted,
  madePublic,
  madePrivate,
}

class HerbariumActionSuccess extends HerbariaState {
  final HerbariumActionType action;

  const HerbariumActionSuccess(this.action);

  @override
  List<Object?> get props => [action];
}
