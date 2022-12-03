import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetworkImageContainer extends StatelessWidget {
  const CachedNetworkImageContainer(
      {Key? key, required this.imageUrl, this.borderRadius = 10})
      : super(key: key);
  final String imageUrl;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.contain,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        color: Colors.grey,
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
