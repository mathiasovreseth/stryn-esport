import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:stryn_esport/models/user_model.dart';
import 'package:stryn_esport/pages/app/bloc/app_event.dart';
import 'package:stryn_esport/pages/app/bloc/app_state.dart';
import 'package:stryn_esport/repositories/auth_repository.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authenticationRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    on<AppUserChanged>(_onUserChanged);
    on<LoadUserInfo>(_userSubscriptionRequested);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AppUserChanged(user)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<MyUser> _userSubscription;

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated(),
    );
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  Future<void> _userSubscriptionRequested(
    LoadUserInfo event,
    Emitter<AppState> emit,
  ) async {
    await emit.forEach<MyUser>(
      _authenticationRepository.getUser(state.user.id),
      onData: (user) {
        return state.copyWith(
          user: user,
        );
      },
      onError: (_, __) => state.copyWith(),
    );
  }
}
