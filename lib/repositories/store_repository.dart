import 'package:stryn_esport/models/store_item.dart';


/// Repository that manages the store page
abstract class StoreRepository {
  Stream<List<StoreItem>> getStoreItems();
}
