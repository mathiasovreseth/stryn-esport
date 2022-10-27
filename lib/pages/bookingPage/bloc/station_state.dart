import 'package:equatable/equatable.dart';

enum Status { initial, loading, success, failure }

class StationsState extends Equatable {
  const StationsState({
    this.stations = const [],
    this.status = Status.initial,
  });

  final List<String> stations;
  final Status status;

  @override
  List<Object?> get props => [stations, status];

  StationsState copyWith({
    List<String>? stations,
    Status? status,
  }) {
    return StationsState(
      stations: stations ?? this.stations,
      status: status ?? this.status,
    );
  }
}
