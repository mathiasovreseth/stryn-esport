import 'package:stryn_esport/models/station_model.dart';

abstract class StationRepository {
  Stream<List<Station>> stationsStream();
}