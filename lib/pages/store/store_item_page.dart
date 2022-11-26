import 'package:flutter/material.dart';
import 'package:stryn_esport/models/store_item.dart';
import 'package:stryn_esport/pages/store/store_page_payment_info.dart';
import 'package:stryn_esport/widgets/appBars/arrow_back_app_bar.dart';
import 'package:stryn_esport/widgets/images/cache_image_container.dart';
import 'package:stryn_esport/widgets/spacer.dart';

class StoreItemPage extends StatelessWidget {
  const StoreItemPage({Key? key, required this.storeItem}) : super(key: key);
  final StoreItem storeItem;

  static Route route({required StoreItem storeItem}) {
    return MaterialPageRoute<void>(
      builder: (_) => StoreItemPage(storeItem: storeItem),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ArrowBackAppBar(
        headerText: storeItem.name,
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
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildImageAndPrice(item,context),
          _buildDescriptionAndButton(item, context),
        ],
      ));
}

Widget _buildImageAndPrice(StoreItem item, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        height: 300,
        child: CachedNetworkImageContainer(imageUrl: item.image),
      ),
      const VerticalSpacer(
        height: 16,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.name,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.85)),
            ),
            Text(
              "${item.price}.-",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildDescriptionAndButton(StoreItem item, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: [
      const VerticalSpacer(height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(item.description,
            style: TextStyle(
                fontSize: 16, color: Colors.black.withOpacity(0.85))),
      ),
      const VerticalSpacer(height: 32),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
              onPressed: () => Navigator.of(context)
                  .push(StoreItemPaymentInfo.route(storeItem: item)),
              child: const Text("Buy item"))),
      const VerticalSpacer(height: 22),
    ],
  );
}


