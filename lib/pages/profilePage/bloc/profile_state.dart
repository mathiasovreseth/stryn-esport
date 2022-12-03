import 'package:equatable/equatable.dart';
import 'package:stryn_esport/models/booking_models.dart';

enum ProfileStatus {
  initial,
  loading,
  success,
  failure,
}

class ProfileState extends Equatable {
  const ProfileState(
      {this.myEvents = const [], this.status = ProfileStatus.initial});

  final List<Booking> myEvents;
  final ProfileStatus status;

  @override
  List<Object> get props => [myEvents, status];

  ProfileState copyWith({
    List<Booking>? myEvents,
    ProfileStatus? status,
  }) {
    return ProfileState(
      myEvents: myEvents ?? this.myEvents,
      status: status ?? this.status,
    );
  }
}
