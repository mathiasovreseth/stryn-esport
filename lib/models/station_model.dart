import 'package:equatable/equatable.dart';

class Station extends Equatable {
  final String id;
  final String name;
  final String image;
  final bool active;

  const Station({
    required this.id,
    required this.name,
    required this.image,
    required this.active,
  });

  @override
  List<Object?> get props => [id, name, active];

  Station.fromQueryDocumentSnapshot(Map<String, dynamic> data)
      : id = data["id"],
        name = data["name"] ?? "",
        image = data["image"] ?? "",
        active = data["active"] ?? false;
}
