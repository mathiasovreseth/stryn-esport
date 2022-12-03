import 'package:stryn_esport/models/store_item.dart';

abstract class StoreRepository {
  Stream<List<StoreItem>> getStoreItems();
}
