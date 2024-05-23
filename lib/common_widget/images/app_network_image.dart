import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({super.key, required this.src});

  final String src;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "$src",
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
