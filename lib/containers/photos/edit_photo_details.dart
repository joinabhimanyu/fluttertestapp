import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertestapp/models/photos_model.dart';
import 'package:fluttertestapp/widgets/custom_uploader.dart';
import 'package:fluttertestapp/widgets/image_viewer.dart';

class EditPhotoDetails extends StatefulWidget {
  const EditPhotoDetails({Key? key, required this.title, required this.data})
      : super(key: key);

  final String title;
  static const String routeName = "EditPhoto";
  final PhotosModel data;

  @override
  State<EditPhotoDetails> createState() => _EditPhotoDetailsState();
}

class _EditPhotoDetailsState extends State<EditPhotoDetails> {
  late PhotosModel photo;
  late GlobalKey<CustomUploaderState> _globalKey;
  // Widget Function(BuildContext? context)? renderImage;
  // BuildContext? uploaderContext;

  final TextEditingController _titleController =
      TextEditingController(text: '');
  final TextEditingController _urlController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    _globalKey = GlobalKey();

    setState(() {
      photo = widget.data;
    });
    _titleController.text = widget.data.title;
    _urlController.text = widget.data.url;
  }

  Widget fallbackRender() {
    return ImageViewer(
      url: photo.thumbnailUrl,
      parentContext: context,
      width: 200,
      height: 200,
    );
  }

  Widget renderImageSection(CustomUploaderState state) {
    if (state.image != null) {
      return const Center(
        child: Icon(Icons.check),
      );
    }
    return const Text('');
  }

  void onSubmit() {
    if (_globalKey.currentState != null &&
        _globalKey.currentState!.image != null) {
      Map<String, String> submitdata = {};
      submitdata['title'] = _titleController.text;
      submitdata['url'] = _urlController.text;
      print('image: ${_globalKey.currentState!.image!.path}');
      print('data: $submitdata');
    } else {
      print('no image uploaded');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: onSubmit, icon: const Icon(Icons.save))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(bottom: 30)),
                Text(
                  'AlbumId: ${photo.albumId}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                Text(
                  'Id: ${photo.id}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                const Text(
                  'Title:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: _titleController,
                  onChanged: (value) => false,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                const Text(
                  'Url:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: _urlController,
                  onChanged: (value) => false,
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                CustomUploader(
                  key: _globalKey,
                  fallbackRender: fallbackRender,
                  builder: (state, context, renderImage) {
                    return Column(
                      children: [
                        renderImageSection(state),
                        renderImage.call(context)
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
