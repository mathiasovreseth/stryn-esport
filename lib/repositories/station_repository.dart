import 'package:stryn_esport/models/station_model.dart';


/// Repository that manages the stations
abstract class StationRepository {
  Stream<List<Station>> stationsStream();
}
