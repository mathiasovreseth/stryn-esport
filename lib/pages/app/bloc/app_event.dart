import 'package:equatable/equatable.dart';
import 'package:stryn_esport/models/user_model.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

// log out requested
class AppLogoutRequested extends AppEvent {}

// Auth state change
class AppUserChanged extends AppEvent {
  const AppUserChanged(this.user);

  final MyUser user;

  @override
  List<Object> get props => [user];
}

// initial user query
class LoadUserInfo extends AppEvent {
  const LoadUserInfo();
}
