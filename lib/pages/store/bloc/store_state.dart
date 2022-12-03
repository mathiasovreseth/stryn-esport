import 'package:equatable/equatable.dart';
import 'package:stryn_esport/models/store_item.dart';

enum Status { initial, loading, success, failure }

class StoreState extends Equatable {
  const StoreState({
    this.items = const [],
    this.status = Status.initial,
  });

  final List<StoreItem> items;
  final Status status;

  @override
  List<Object?> get props => [items, status];

  StoreState copyWith({
    List<StoreItem>? items,
    Status? status,
  }) {
    return StoreState(
      items: items ?? this.items,
      status: status ?? this.status,
    );
  }
}
