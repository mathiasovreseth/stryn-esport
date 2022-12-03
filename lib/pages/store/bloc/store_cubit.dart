import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stryn_esport/pages/store/bloc/store_state.dart';
import 'package:stryn_esport/repositories/store_repository.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit(this._storeRepository) : super(const StoreState()) {
    getStoreItems();
  }

  final StoreRepository _storeRepository;

  void getStoreItems() {
    _storeRepository.getStoreItems().listen((event) {
      emit(state.copyWith(
        items: event,
        status: Status.success,
      ));
    });
  }
}
