
import 'package:equatable/equatable.dart';
import 'package:stryn_esport/models/user_model.dart';


enum AppStatus {
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = MyUser.empty,
  });

  const AppState.authenticated(MyUser user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final MyUser user;

  @override
  List<Object> get props => [status, user];
}