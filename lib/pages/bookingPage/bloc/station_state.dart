import 'package:equatable/equatable.dart';
import 'package:stryn_esport/models/station_model.dart';

enum Status { initial, loading, success, failure }

/// Contains the list of stations and it's status for the stations
///
class StationsState extends Equatable {
  const StationsState({
    this.stations = const [],
    this.status = Status.initial,
  });

  final List<Station> stations;
  final Status status;

  @override
  List<Object?> get props => [stations, status];

  StationsState copyWith({
    List<Station>? stations,
    Status? status,
  }) {
    return StationsState(
      stations: stations ?? this.stations,
      status: status ?? this.status,
    );
  }
}
