import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'core/api/api_service.dart';
import 'core/storage/storage_service.dart';
import 'core/network/network_info.dart';
import 'core/biometry/biometry_service.dart';
import 'core/security/security_service.dart';
import 'core/notifications/push_notification_service.dart';

import 'features/auth/data/data_sources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/use_cases/login_use_case.dart';
import 'features/auth/domain/use_cases/register_use_case.dart';
import 'features/auth/domain/use_cases/logout_use_case.dart';
import 'features/auth/domain/use_cases/forgot_password_use_case.dart';
import 'features/auth/domain/use_cases/get_me_use_case.dart';
import 'features/auth/domain/use_cases/resend_verification_email_use_case.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

import 'features/herbaria/data/data_sources/herbarium_local_data_source.dart';
import 'features/herbaria/data/data_sources/herbarium_remote_data_source.dart';
import 'features/herbaria/data/repositories/herbarium_repository_impl.dart';
import 'features/herbaria/domain/repositories/herbarium_repository.dart';
import 'features/herbaria/domain/use_cases/create_herbarium_use_case.dart';
import 'features/herbaria/domain/use_cases/get_my_herbaria_use_case.dart';
import 'features/herbaria/domain/use_cases/update_herbarium_use_case.dart';
import 'features/herbaria/domain/use_cases/delete_herbarium_use_case.dart';
import 'features/herbaria/presentation/bloc/herbaria_bloc.dart';

import 'features/plants/data/data_sources/plant_remote_data_source.dart';
import 'features/plants/data/data_sources/plant_local_data_source.dart';
import 'features/plants/data/repositories/plant_repository_impl.dart';
import 'features/plants/domain/repositories/plant_repository.dart';
import 'features/plants/domain/use_cases/add_plant_use_case.dart';
import 'features/plants/domain/use_cases/confirm_plant_use_case.dart';
import 'features/plants/presentation/bloc/plant_identification_bloc.dart';
import 'features/plants/presentation/bloc/list/plant_list_bloc.dart';
import 'features/plants/domain/use_cases/get_plants_use_case.dart';
import 'features/plants/domain/use_cases/update_plant_name_use_case.dart';
import 'features/plants/domain/use_cases/update_photo_description_use_case.dart';
import 'features/plants/domain/use_cases/delete_plant_use_case.dart';
import 'features/notifications/data/data_sources/notification_remote_data_source.dart';
import 'features/notifications/data/data_sources/notification_local_data_source.dart';
import 'features/notifications/data/repositories/notification_repository_impl.dart';
import 'features/notifications/domain/repositories/notification_repository.dart';
import 'features/notifications/domain/use_cases/get_notifications_use_case.dart';
import 'features/notifications/domain/use_cases/get_unread_notifications_use_case.dart';
import 'features/notifications/domain/use_cases/mark_all_notifications_as_read_use_case.dart';
import 'features/notifications/domain/use_cases/mark_notification_as_read_use_case.dart';
import 'features/notifications/presentation/bloc/notification_bloc.dart';

import 'features/friends/data/data_sources/friend_remote_data_source.dart';
import 'features/friends/data/data_sources/friend_local_data_source.dart';
import 'features/friends/data/repositories/friend_repository_impl.dart';
import 'features/friends/domain/repositories/friend_repository.dart';
import 'features/friends/domain/use_cases/get_friends_use_case.dart';
import 'features/friends/domain/use_cases/send_friend_request_use_case.dart';
import 'features/friends/domain/use_cases/accept_friend_request_use_case.dart';
import 'features/friends/domain/use_cases/get_incoming_friend_requests_use_case.dart';
import 'features/friends/domain/use_cases/get_sent_friend_requests_use_case.dart';
import 'features/friends/domain/use_cases/delete_friendship_use_case.dart';
import 'features/friends/presentation/bloc/friends_bloc.dart';

class DependencyProvider extends StatefulWidget {
  final Widget child;

  const DependencyProvider({Key? key, required this.child}) : super(key: key);

  @override
  State<DependencyProvider> createState() => _DependencyProviderState();
}

class _DependencyProviderState extends State<DependencyProvider> {
  late final StorageService storageService;
  late final ApiService apiService;
  late final NetworkInfoImpl networkInfo;
  late final SecurityService securityService;
  late final BiometryService biometryService;
  late final PushNotificationService pushNotificationService;

  late final AuthRemoteDataSource authRemoteDataSource;
  late final HerbariumRemoteDataSourceImpl herbariumRemoteDataSource;
  late final HerbariumLocalDataSourceImpl herbariumLocalDataSource;
  late final PlantRemoteDataSourceImpl plantRemoteDataSource;
  late final PlantLocalDataSourceImpl plantLocalDataSource;
  late final NotificationRemoteDataSourceImpl notificationRemoteDataSource;
  late final NotificationLocalDataSourceImpl notificationLocalDataSource;
  late final FriendRemoteDataSourceImpl friendRemoteDataSource;
  late final FriendLocalDataSourceImpl friendLocalDataSource;

  @override
  void initState() {
    super.initState();
    storageService = StorageService();
    apiService = ApiService(storageService);
    networkInfo = NetworkInfoImpl(Connectivity());
    securityService = SecurityService();
    biometryService = BiometryService();
    pushNotificationService = PushNotificationService();

    authRemoteDataSource = AuthRemoteDataSource(apiService.client);
    herbariumRemoteDataSource = HerbariumRemoteDataSourceImpl(apiService);
    herbariumLocalDataSource = HerbariumLocalDataSourceImpl();
    plantRemoteDataSource = PlantRemoteDataSourceImpl(apiService);
    plantLocalDataSource = PlantLocalDataSourceImpl();
    notificationRemoteDataSource = NotificationRemoteDataSourceImpl(apiService);
    notificationLocalDataSource = NotificationLocalDataSourceImpl();
    friendRemoteDataSource = FriendRemoteDataSourceImpl(apiService);
    friendLocalDataSource = FriendLocalDataSourceImpl();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<StorageService>(
          create: (context) => storageService,
        ),
        RepositoryProvider<SecurityService>(
          create: (context) => securityService,
        ),
        RepositoryProvider<BiometryService>(
          create: (context) => biometryService,
        ),
        RepositoryProvider<PushNotificationService>(
          create: (context) => pushNotificationService,
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(authRemoteDataSource, storageService),
        ),
        RepositoryProvider<HerbariumRepository>(
          create: (context) => HerbariumRepositoryImpl(
            herbariumRemoteDataSource,
            herbariumLocalDataSource,
            networkInfo,
          ),
        ),
        RepositoryProvider<PlantRepository>(
          create: (context) => PlantRepositoryImpl(plantRemoteDataSource, plantLocalDataSource, networkInfo),
        ),
        RepositoryProvider<NotificationRepository>(
          create: (context) => NotificationRepositoryImpl(
            notificationRemoteDataSource,
            notificationLocalDataSource,
            networkInfo,
          ),
        ),
        RepositoryProvider<FriendRepository>(
          create: (context) => FriendRepositoryImpl(
            friendRemoteDataSource,
            friendLocalDataSource,
            networkInfo,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              storageService: storageService,
              biometryService: biometryService,
              pushNotificationService: pushNotificationService,
              authRepository: context.read<AuthRepository>(),
              loginUseCase: LoginUseCase(context.read<AuthRepository>()),
              registerUseCase: RegisterUseCase(context.read<AuthRepository>()),
              logoutUseCase: LogoutUseCase(context.read<AuthRepository>()),
              forgotPasswordUseCase: ForgotPasswordUseCase(context.read<AuthRepository>()),
              getMeUseCase: GetMeUseCase(context.read<AuthRepository>()),
              resendVerificationEmailUseCase: ResendVerificationEmailUseCase(context.read<AuthRepository>()),
            ),
          ),
          BlocProvider<HerbariaBloc>(
            create: (context) => HerbariaBloc(
              getMyHerbaria: GetMyHerbariaUseCase(context.read<HerbariumRepository>()),
              createHerbarium: CreateHerbariumUseCase(context.read<HerbariumRepository>()),
              updateHerbarium: UpdateHerbariumUseCase(context.read<HerbariumRepository>()),
              deleteHerbarium: DeleteHerbariumUseCase(context.read<HerbariumRepository>()),
            ),
          ),
          BlocProvider<PlantIdentificationBloc>(
            create: (context) => PlantIdentificationBloc(
              addPlantUseCase: AddPlantUseCase(context.read<PlantRepository>()),
              confirmPlantUseCase: ConfirmPlantUseCase(context.read<PlantRepository>()),
            ),
          ),
          BlocProvider<PlantListBloc>(
            create: (context) => PlantListBloc(
              getPlantsUseCase: GetPlantsUseCase(context.read<PlantRepository>()),
              updatePlantNameUseCase: UpdatePlantNameUseCase(context.read<PlantRepository>()),
              updatePhotoDescriptionUseCase: UpdatePhotoDescriptionUseCase(context.read<PlantRepository>()),
              deletePlantUseCase: DeletePlantUseCase(context.read<PlantRepository>()),
            ),
          ),
          BlocProvider<NotificationBloc>(
            create: (context) => NotificationBloc(
              pushNotificationService: pushNotificationService,
              getNotifications: GetNotificationsUseCase(context.read<NotificationRepository>()),
              getUnreadNotifications: GetUnreadNotificationsUseCase(context.read<NotificationRepository>()),
              markAsRead: MarkNotificationAsReadUseCase(context.read<NotificationRepository>()),
              markAllAsRead: MarkAllNotificationsAsReadUseCase(context.read<NotificationRepository>()),
            ),
          ),
          BlocProvider<FriendsBloc>(
            create: (context) => FriendsBloc(
              getFriends: GetFriendsUseCase(context.read<FriendRepository>()),
              sendFriendRequest: SendFriendRequestUseCase(context.read<FriendRepository>()),
              acceptFriendRequest: AcceptFriendRequestUseCase(context.read<FriendRepository>()),
              getIncomingRequests: GetIncomingFriendRequestsUseCase(context.read<FriendRepository>()),
              getSentRequests: GetSentFriendRequestsUseCase(context.read<FriendRepository>()),
              deleteFriendship: DeleteFriendshipUseCase(context.read<FriendRepository>()),
            ),
          ),
        ],
        child: widget.child,
      ),
    );
  }
}
