import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({super.key, required this.src, this.height = 50, this.width = 50});

  final String src;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "$src",
      height: height,
      width: width,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
