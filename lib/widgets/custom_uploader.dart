import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertestapp/widgets/image_viewer.dart';
import 'package:image_picker/image_picker.dart';

class CustomUploader extends StatefulWidget {
  const CustomUploader(
      {Key? key, required this.fallbackRender, required this.builder})
      : super(key: key);
  final Widget Function() fallbackRender;
  final Widget Function(
      CustomUploaderState state, BuildContext context, dynamic args) builder;

  @override
  State<CustomUploader> createState() => CustomUploaderState();
}

class CustomUploaderState extends State<CustomUploader> {
  XFile? image;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  Future<void> getImage(ImageSource source) async {
    var img = await picker.pickImage(source: source);
    setState(() {
      image = img;
    });
  }

  Future<void> _showDialong(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('Upload Image from here'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  getImage(ImageSource.gallery);
                },
                child: Row(
                  children: const <Widget>[
                    Text('From Gallery'),
                    Icon(Icons.browse_gallery)
                  ],
                )),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  getImage(ImageSource.camera);
                },
                child: Row(
                  children: const <Widget>[
                    Text('From Camera'),
                    Icon(Icons.camera)
                  ],
                ))
          ],
        );
      },
    );
    return Future.delayed(const Duration(milliseconds: 10), () => false);
  }

  Widget renderImage(BuildContext? context) {
    var imagefile;
    if (image != null && context != null) {
      imagefile = ImageViewer(
        image: File(image!.path),
        parentContext: context,
        width: 200,
        height: 200,
      );
    } else {
      imagefile = widget.fallbackRender.call();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: imagefile,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () => _showDialong(context),
            child: Row(
              children: const <Widget>[
                Text("Upload"),
                Icon(
                  Icons.upload,
                )
              ],
            )),
        widget.builder.call(this, context, renderImage)
      ],
    );
  }
}
