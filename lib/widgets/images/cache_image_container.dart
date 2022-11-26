

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetworkImageContainer extends StatelessWidget {
  const CachedNetworkImageContainer({Key? key, required this.imageUrl}) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fadeInCurve: Curves.easeIn,
      fit: BoxFit.fill,
      fadeInDuration: const Duration(seconds: 1),
      imageUrl: imageUrl,
      placeholder: (context, url) => Container(
        color: Colors.grey,
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
