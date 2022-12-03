import 'package:equatable/equatable.dart';

class StoreItem extends Equatable {
  final String id;
  final String name;
  final String image;
  final String price;
  final String description;
  final bool active;

  const StoreItem({
    required this.id,
    required this.name,
    required this.image,
    required this.active,
    required this.price,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, active, price, description];

  StoreItem.fromQueryDocumentSnapshot(Map<String, dynamic> data)
      : id = data["id"],
        name = data["name"] ?? "",
        image = data["image"] ?? "",
        active = data["active"] ?? false,
        price = data["price"] ?? "",
        description = data["description"] ?? "";
}
