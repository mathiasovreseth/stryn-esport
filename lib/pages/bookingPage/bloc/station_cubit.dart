import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stryn_esport/pages/bookingPage/bloc/station_state.dart';
import 'package:stryn_esport/repositories/station_repository.dart';

class StationCubit extends Cubit<StationsState> {
  StationCubit(this._database) : super(const StationsState()) {
    getStations();
  }

  final StationRepository _database;

  void getStations() {
    _database.stationsStream().listen((event) {
      emit(state.copyWith(
        stations: event,
        status: Status.success,
      ));
    });
  }
}
