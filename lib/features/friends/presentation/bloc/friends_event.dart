import 'package:equatable/equatable.dart';

abstract class FriendsEvent extends Equatable {
  const FriendsEvent();

  @override
  List<Object?> get props => [];
}

class LoadFriends extends FriendsEvent {}

class SendFriendRequest extends FriendsEvent {
  final String username;

  const SendFriendRequest(this.username);

  @override
  List<Object?> get props => [username];
}

class AcceptFriendRequest extends FriendsEvent {
  final String friendshipId;

  const AcceptFriendRequest(this.friendshipId);

  @override
  List<Object?> get props => [friendshipId];
}

class RemoveFriendship extends FriendsEvent {
  final String friendshipId;

  const RemoveFriendship(this.friendshipId);

  @override
  List<Object?> get props => [friendshipId];
}
