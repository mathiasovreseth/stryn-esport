import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stryn_esport/models/user_model.dart';
import 'package:stryn_esport/pages/profilePage/bloc/profile_state.dart';
import 'package:stryn_esport/repositories/calendar_repository.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._calendarRepository, this._user)
      : super(const ProfileState()) {
    getMyEvents();
  }

  final CalendarRepository _calendarRepository;
  final MyUser _user;

  /// Fetch all events for a station's calendar
  void getMyEvents() {
    _calendarRepository.getMyEvents(_user.id).listen((event) {
      emit(state.copyWith(
        myEvents: event,
        status: ProfileStatus.success,
      ));
    });
  }
}
