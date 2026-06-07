import 'package:equatable/equatable.dart';
import '../../../../core/network/app_exception.dart';
import '../../domain/entities/friend.dart';

abstract class FriendsState extends Equatable {
  const FriendsState();

  @override
  List<Object?> get props => [];
}

class FriendsInitial extends FriendsState {}

class FriendsLoading extends FriendsState {}

class FriendsLoaded extends FriendsState {
  final List<Friend> friends;
  final List<Friend> incomingRequests;
  final List<Friend> sentRequests;

  const FriendsLoaded({
    required this.friends,
    required this.incomingRequests,
    required this.sentRequests,
  });

  @override
  List<Object?> get props => [friends, incomingRequests, sentRequests];
}

class FriendsError extends FriendsState {
  final AppException exception;

  const FriendsError(this.exception);

  @override
  List<Object?> get props => [exception];
}

class FriendActionSuccess extends FriendsState {
  final String message;

  const FriendActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
