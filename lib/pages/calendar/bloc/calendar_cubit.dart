import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stryn_esport/models/booking_models.dart';
import 'package:stryn_esport/models/user_model.dart';
import 'package:stryn_esport/pages/calendar/bloc/calendar_state.dart';
import 'package:stryn_esport/repositories/calendar_repository.dart';

import '../../../models/station_model.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit(this._calendarRepository, this._user, this.stationId)
      : super(const CalendarState()) {
    getEvents(stationId);
  }

  final CalendarRepository _calendarRepository;
  final MyUser _user;
  final String stationId;


  /// Fetch all events for a station's calendar
  void getEvents(String stationId) {
    _calendarRepository.getEvents(stationId).listen((event) {
      emit(state.copyWith(
        events: event,
        status: CalendarStatus.success,
      ));
    });
  }
  /// Adds event to a station's calendar
  Future<bool> addEvent(Station station, DateTime from) async {
    DateTime to = from.add(const Duration(hours: 2));
    try {
      await _calendarRepository.addEvent(station, from, to, _user.id, _user.firstName!);
      return true;
    } on FirebaseException catch(e) {
      return false;
    }
  }

  /// Removes an event from a station's calendar
  Future<bool> removeEvent(Station station, Booking booking) async {
    try {
      await _calendarRepository.removeEvent(station, booking, _user.id);
      return true;
    } on FirebaseException catch(e) {
      return false;
    }
  }
  /// Used to check the number of bookings the user has in a particular day
  /// We allow 2 bookings per day
  Future<bool> checkNrOfEventsInADay(Station station, DateTime date) async {
    List<Booking> bookings = await _calendarRepository.getMyEventsByDay(_user.id, stationId, date);
    if(bookings.length >= 2) {
      return false;
    } else {
      return true;
    }
  }


}
