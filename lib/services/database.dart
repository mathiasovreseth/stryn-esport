import 'package:stryn_esport/models/station_model.dart';
import 'package:stryn_esport/services/api_path.dart';
import 'package:stryn_esport/services/firestore_service.dart';

import '../models/store_item.dart';

abstract class Database {
  Stream<List<Station>> stationsStream();
}

class FirestoreDatabase implements Database {
  FirestoreDatabase();

  final _service = FirestoreService.instance;


  Stream<List<Station>> stationsStream() => _service.collectionStream(
    path: APIPath.stations(),
    builder: (data) => Station.fromQueryDocumentSnapshot(data),
  );

  Stream<List<StoreItem>> storeItemsStream() => _service.collectionStream(
      path: APIPath.items(),
      builder: (data) => StoreItem.fromQueryDocumentSnapshot(data),
  );

}
