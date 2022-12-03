import 'package:stryn_esport/repositories/store_repository.dart';
import 'package:stryn_esport/services/firestore_service.dart';

import '../models/store_item.dart';
import '../services/api_path.dart';

/// Firestore repository that manages the store page
/// Implements the methods from StoreRepository
class FirebaseStoreRepository extends StoreRepository {
  final _service = FirestoreService.instance;

  @override
  Stream<List<StoreItem>> getStoreItems() => _service.collectionStream(
        path: APIPath.items(),
        builder: (data) => StoreItem.fromQueryDocumentSnapshot(data),
      );
}
