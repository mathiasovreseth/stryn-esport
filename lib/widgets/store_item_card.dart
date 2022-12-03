import 'package:flutter/material.dart';
import 'package:stryn_esport/models/store_item.dart';
import 'package:stryn_esport/pages/store/store_item_page.dart';
import 'package:stryn_esport/widgets/images/cache_image_container.dart';

class StoreItemCard extends StatelessWidget {
  const StoreItemCard({Key? key, required this.item}) : super(key: key);

  final StoreItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).push(StoreItemPage.route(storeItem: item)),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: CachedNetworkImageContainer(imageUrl: item.image),
      ),
    );
  }
}
