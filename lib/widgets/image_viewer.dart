import 'dart:io';

import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer(
      {Key? key,
      this.url,
      this.image,
      this.parentContext,
      this.width,
      this.height,
      this.radius})
      : super(key: key);

  final String? url;
  final File? image;
  final BuildContext? parentContext;
  final double? width;
  final double? height;
  final double? radius;

  Widget _buildImage() {
    var imagefile;
    if (url != null && url != "") {
      imagefile = Image.network(
        url!,
        fit: BoxFit.cover,
        width: width ?? MediaQuery.of(parentContext!).size.width,
        height: height ?? 300,
      );
    } else if (image != null) {
      imagefile = Image.file(
        //to show image, you type like this.
        image!,
        fit: BoxFit.cover,
        width: width ?? MediaQuery.of(parentContext!).size.width,
        height: height ?? 300,
      );
    }
    return ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 8), child: imagefile);
  }

  @override
  Widget build(BuildContext context) {
    return _buildImage();
  }
}
