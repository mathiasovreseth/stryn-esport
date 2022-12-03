import 'package:equatable/equatable.dart';
import 'package:stryn_esport/models/booking_models.dart';

enum CalendarStatus {
  initial,
  loading,
  failiure,
  success,
}

class CalendarState extends Equatable {
  const CalendarState(
      {this.events = const [], this.status = CalendarStatus.initial});

  final List<Booking> events;
  final CalendarStatus status;

  @override
  List<Object> get props => [events, status];

  CalendarState copyWith({
    List<Booking>? events,
    CalendarStatus? status,
  }) {
    return CalendarState(
      events: events ?? this.events,
      status: status ?? this.status,
    );
  }
}
