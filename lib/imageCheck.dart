import 'package:flutter/material.dart';

Widget loadImage(String imageUrl) {
  if (imageUrl.isNotEmpty) {
    return Image.network(
      imageUrl,
      width: 200.0,
      height: 200.0,
      fit: BoxFit.cover,
      errorBuilder: (context, exception, stackTrace) {
        return Image.asset(
          'assets/image_not_available.jpg',
          width: 200.0,
          height: 200.0,
          fit: BoxFit.cover,
        );
      },
    );
  } else {

    return Image.asset(
      'assets/image_not_available.jpg',
      width: 200.0,
      height: 200.0,
      fit: BoxFit.cover,
    );
  }
}
