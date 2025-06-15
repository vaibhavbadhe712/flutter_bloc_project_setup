import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUsersEvent extends UserEvent {
  const GetUsersEvent();
}

class GetUserByIdEvent extends UserEvent {
  final int userId;

  const GetUserByIdEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class RefreshUsersEvent extends UserEvent {
  const RefreshUsersEvent();
}
