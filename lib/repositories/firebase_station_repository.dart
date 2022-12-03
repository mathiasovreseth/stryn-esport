import 'package:stryn_esport/models/station_model.dart';
import 'package:stryn_esport/repositories/station_repository.dart';
import 'package:stryn_esport/services/api_path.dart';
import 'package:stryn_esport/services/firestore_service.dart';

class FirebaseStationRepository extends StationRepository {
  final _service = FirestoreService.instance;

  @override
  Stream<List<Station>> stationsStream() => _service.collectionStream(
    path: APIPath.stations(),
    builder: (data) => Station.fromQueryDocumentSnapshot(data),
  );
}