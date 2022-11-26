
import 'package:flutter/material.dart';
import 'package:stryn_esport/models/store_item.dart';
import 'package:stryn_esport/widgets/appBars/arrow_back_app_bar.dart';
import 'package:stryn_esport/widgets/images/cache_image_container.dart';
import 'package:stryn_esport/widgets/spacer.dart';


class StoreItemPaymentInfo extends StatelessWidget {
  const StoreItemPaymentInfo({Key? key, required this.storeItem}) : super(key: key);
  final StoreItem storeItem;
  static Route route({required StoreItem storeItem}) {
    return MaterialPageRoute<void>(
      builder: (_) => StoreItemPaymentInfo(storeItem: storeItem),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ArrowBackAppBar(
        headerText: "Buy ${storeItem.name}",
        onBackClick: () => Navigator.of(context).pop(),
      ),
      body: ListView(
        children: [
          const VerticalSpacer(height: 12),
          _buildContent(storeItem, context),
          const VerticalSpacer(height: 16),
        ],
      ),
    );
  }
}
Widget _buildContent(StoreItem item, BuildContext context) {
  return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 300,
            child: CachedNetworkImageContainer(imageUrl: item.image),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
            child: Text("We don't currently have a payment option in the app. Please vipps xxx and include your name, the item and the size. Then pick up the item in our location",
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          )

        ],
      ));
}
