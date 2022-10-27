import 'package:stryn_esport/models/station_model.dart';
import 'package:stryn_esport/services/api_path.dart';
import 'package:stryn_esport/services/firestore_service.dart';

abstract class Database {
  Stream<List<Station>> stationsStream();
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.id});
  final String id;

  final _service = FirestoreService.instance;


  Stream<List<Station>> stationsStream() => _service.collectionStream(
    path: APIPath.stations(),
    builder: (data) => Station.fromQueryDocumentSnapshot(data),
  );

}
