import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertestapp/blocs/counter_cubit.dart';
import 'package:fluttertestapp/containers/photos/edit_photo_details.dart';
import 'package:fluttertestapp/models/photos_model.dart';
import 'package:fluttertestapp/widgets/image_viewer.dart';

class PhotoDetails extends StatelessWidget {
  const PhotoDetails({Key? key, required this.title, required this.data})
      : super(key: key);

  final String title;
  final PhotosModel data;
  static const String routeName = "PhotoDetails";

  Future<void> _onDeletePressed(BuildContext context) async {
    var response = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('Do you really want to delete?'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, "yes");
                },
                child: Row(
                  children: [Text('Yes'), Icon(Icons.check)],
                )),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, "no");
                },
                child: Row(
                  children: [Text('No'), Icon(Icons.unarchive)],
                ))
          ],
        );
      },
    );
    print('response from dialog: $response');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, EditPhotoDetails.routeName,
                    arguments: data);
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                _onDeletePressed(context);
              },
              icon: const Icon(Icons.delete)),
        ],
        title: Text(title),
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
              children: [
                ImageViewer(
                  url: data.thumbnailUrl,
                  parentContext: context,
                  width: 200,
                  height: 200,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 30)),
                Text(
                  'AlbumId: ${data.albumId}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                Text(
                  'Id: ${data.id}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                Text(
                  'Title: ${data.title}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                Text(
                  'Url: ${data.url}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
