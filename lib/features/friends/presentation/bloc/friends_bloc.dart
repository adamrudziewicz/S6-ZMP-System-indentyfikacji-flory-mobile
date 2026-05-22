import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/error_handler.dart';
import '../../domain/use_cases/get_friends_use_case.dart';
import '../../domain/use_cases/send_friend_request_use_case.dart';
import '../../domain/use_cases/accept_friend_request_use_case.dart';
import '../../domain/use_cases/get_incoming_friend_requests_use_case.dart';
import '../../domain/use_cases/get_sent_friend_requests_use_case.dart';
import '../../domain/use_cases/delete_friendship_use_case.dart';
import 'friends_event.dart';
import 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  final GetFriendsUseCase _getFriends;
  final SendFriendRequestUseCase _sendFriendRequest;
  final AcceptFriendRequestUseCase _acceptFriendRequest;
  final GetIncomingFriendRequestsUseCase _getIncomingRequests;
  final GetSentFriendRequestsUseCase _getSentRequests;
  final DeleteFriendshipUseCase _deleteFriendship;

  FriendsBloc({
    required GetFriendsUseCase getFriends,
    required SendFriendRequestUseCase sendFriendRequest,
    required AcceptFriendRequestUseCase acceptFriendRequest,
    required GetIncomingFriendRequestsUseCase getIncomingRequests,
    required GetSentFriendRequestsUseCase getSentRequests,
    required DeleteFriendshipUseCase deleteFriendship,
  })  : _getFriends = getFriends,
        _sendFriendRequest = sendFriendRequest,
        _acceptFriendRequest = acceptFriendRequest,
        _getIncomingRequests = getIncomingRequests,
        _getSentRequests = getSentRequests,
        _deleteFriendship = deleteFriendship,
        super(FriendsInitial()) {
    on<LoadFriends>(_onLoadFriends);
    on<SendFriendRequest>(_onSendFriendRequest);
    on<AcceptFriendRequest>(_onAcceptFriendRequest);
    on<RemoveFriendship>(_onRemoveFriendship);
  }

  Future<void> _onLoadFriends(LoadFriends event, Emitter<FriendsState> emit) async {
    emit(FriendsLoading());
    try {
      final friendsList = await _getFriends();
      final incomingList = await _getIncomingRequests();
      final sentList = await _getSentRequests();
      
      emit(FriendsLoaded(
        friends: friendsList,
        incomingRequests: incomingList,
        sentRequests: sentList,
      ));
    } catch (e) {
      emit(FriendsError(ErrorHandler.mapError(e)));
    }
  }

  Future<void> _onSendFriendRequest(SendFriendRequest event, Emitter<FriendsState> emit) async {
    emit(FriendsLoading());
    try {
      await _sendFriendRequest(event.username);
      emit(const FriendActionSuccess('Zaproszenie wysłane pomyślnie'));
      add(LoadFriends());
    } catch (e) {
      emit(FriendsError(ErrorHandler.mapError(e)));
    }
  }

  Future<void> _onAcceptFriendRequest(AcceptFriendRequest event, Emitter<FriendsState> emit) async {
    emit(FriendsLoading());
    try {
      await _acceptFriendRequest(event.friendshipId);
      emit(const FriendActionSuccess('Zaproszenie zostało zaakceptowane'));
      add(LoadFriends());
    } catch (e) {
      emit(FriendsError(ErrorHandler.mapError(e)));
    }
  }

  Future<void> _onRemoveFriendship(RemoveFriendship event, Emitter<FriendsState> emit) async {
    emit(FriendsLoading());
    try {
      await _deleteFriendship(event.friendshipId);
      emit(const FriendActionSuccess('Znajomość została usunięta'));
      add(LoadFriends());
    } catch (e) {
      emit(FriendsError(ErrorHandler.mapError(e)));
    }
  }
}
