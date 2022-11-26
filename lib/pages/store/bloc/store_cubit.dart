import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stryn_esport/pages/store/bloc/store_state.dart';
import 'package:stryn_esport/services/database.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit(this._database) : super(const StoreState()) {
    getStoreItems();
  }

  final FirestoreDatabase _database;

  void getStoreItems() {
    _database.storeItemsStream().listen((event) {
      emit(state.copyWith(
        items: event,
        status: Status.success,
      ));
    });
  }
}