import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../core/utils/logger.dart';
import '../../../domain/usecases/get_user_by_id_usecase.dart';
import '../../../domain/usecases/get_users_usecase.dart';
import 'user_event.dart';
import 'user_state.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsersUseCase getUsersUseCase;
  final GetUserByIdUseCase getUserByIdUseCase;

  UserBloc({
    required this.getUsersUseCase,
    required this.getUserByIdUseCase,
  }) : super(const UserInitial()) {
    on<GetUsersEvent>(_onGetUsers);
    on<GetUserByIdEvent>(_onGetUserById);
    on<RefreshUsersEvent>(_onRefreshUsers);
  }

  Future<void> _onGetUsers(
    GetUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());
    
    final result = await getUsersUseCase();
    
    result.fold(
      (failure) {
        AppLogger.e('Failed to get users: ${failure.message}');
        emit(UserError(failure.message));
      },
      (users) {
        AppLogger.i('Successfully loaded ${users.length} users');
        emit(UsersLoaded(users));
      },
    );
  }

  Future<void> _onGetUserById(
    GetUserByIdEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());
    
    final result = await getUserByIdUseCase(event.userId);
    
    result.fold(
      (failure) {
        AppLogger.e('Failed to get user by id: ${failure.message}');
        emit(UserError(failure.message));
      },
      (user) {
        AppLogger.i('Successfully loaded user: ${user.name}');
        emit(UserLoaded(user));
      },
    );
  }

  Future<void> _onRefreshUsers(
    RefreshUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    // Show refreshing state with current data if available
    if (state is UsersLoaded) {
      emit(UserRefreshing((state as UsersLoaded).users));
    } else {
      emit(const UserLoading());
    }
    
    final result = await getUsersUseCase();
    
    result.fold(
      (failure) {
        AppLogger.e('Failed to refresh users: ${failure.message}');
        emit(UserError(failure.message));
      },
      (users) {
        AppLogger.i('Successfully refreshed ${users.length} users');
        emit(UsersLoaded(users));
      },
    );
  }
}