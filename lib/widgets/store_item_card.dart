import 'package:flutter/material.dart';
import 'package:stryn_esport/models/store_item.dart';

class StoreItemCard extends StatelessWidget {
  const StoreItemCard({Key? key, required this.item}) : super(key: key);

  final StoreItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
          child: Image.network(
            item.image,
            fit: BoxFit.fill,
          ),
    );
  }
}