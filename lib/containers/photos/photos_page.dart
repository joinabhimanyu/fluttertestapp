import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertestapp/containers/photos/photo_details.dart';
import 'package:fluttertestapp/models/photos_model.dart';
import 'package:fluttertestapp/services/photos_service.dart';
import 'package:fluttertestapp/widgets/blogs_layout.dart';
import 'package:fluttertestapp/widgets/custom_listview.dart';
import 'package:fluttertestapp/widgets/drawer_widget.dart';
import 'package:fluttertestapp/widgets/image_viewer.dart';
import 'package:fluttertestapp/widgets/share_icons.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({Key? key, required this.title}) : super(key: key);

  final String title;
  static const String routeName = "PhotosPage";

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

enum States { layers, grid, list }

class _PhotosPageState extends State<PhotosPage> {
  late Future<List<PhotosModel>> _photos;
  States state = States.layers;

  @override
  void initState() {
    super.initState();
    _photos = getPhotos();
  }

  Future<void> _onRefresh() {
    return Future.delayed(
      Duration.zero,
      () => {
        setState(() {
          _photos = getPhotos();
        })
      },
    );
  }

  void onTapRecord(dynamic record) {
    Navigator.pushNamed(context, PhotoDetails.routeName, arguments: record);
  }

  void _onChangeIcon() {
    switch (state) {
      case States.layers:
        setState(() {
          state = States.grid;
        });
        break;
      case States.grid:
        setState(() {
          state = States.list;
        });
        break;
      case States.list:
        setState(() {
          state = States.layers;
        });
        break;
      default:
    }
  }

  Icon? _renderIcon() {
    if (state == States.layers) {
      return const Icon(Icons.grid_view);
    } else if (state == States.grid) {
      return const Icon(Icons.list);
    } else if (state == States.list) {
      return const Icon(Icons.layers);
    }
    return null;
  }

  Widget _renderGridCard(int rand) {
    return Column(
      children: [
        GestureDetector(
          child: ImageViewer(
            height: 100,
            width: 100,
            parentContext: context,
            url: "https://source.unsplash.com/random/200x200?sig=${rand}",
          ),
          onTap: () {
            //_showModalBottomSheetMenu(context, 'image name: $rand');
          },
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Text(
          'image name: $rand',
          style: TextStyle(
              fontWeight: FontWeight.w400, color: Colors.grey.shade800),
        )
      ],
    );
  }

  Widget _renderGridRow() {
    var random = Random();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _renderGridCard(random.nextInt(100)),
        _renderGridCard(random.nextInt(100)),
        _renderGridCard(random.nextInt(100)),
      ],
    );
  }

  Widget _renderLeading(dynamic record) {
    return ImageViewer(
      height: 100,
      width: 90,
      url: record.thumbnailUrl,
      parentContext: context,
    );
  }

  Widget _renderTitle(dynamic record) {
    return Container(
        //padding: const EdgeInsets.only(right: 2),
        child: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(children: [
        SizedBox(
          width: 250,
          child: Text(
            record.title.toString(),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        ShareIcons(
            wantLikeIcon: false,
            wantshareIcon: false,
            parentContext: context,
            title: (record as PhotosModel).title)
      ]),
    ));
  }

  Widget? _renderContent() {
    if (state == States.layers) {
      return BlogsLayout<PhotosModel>(
        future: _photos,
        onRefresh: _onRefresh,
        imageFieldName: 'thumbnailUrl',
        bodyFieldName: 'title',
        onCommentsIconClick: (value) => false,
        onSearchIconClick: (value) => false,
      );
    } else if (state == States.grid) {
      return SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: ListView(
            children: [
              const Padding(padding: EdgeInsets.only(top: 20)),
              _renderGridRow(),
              const Padding(padding: EdgeInsets.only(top: 20)),
              _renderGridRow(),
              const Padding(padding: EdgeInsets.only(top: 20)),
              _renderGridRow(),
              const Padding(padding: EdgeInsets.only(top: 20)),
              _renderGridRow(),
              const Padding(padding: EdgeInsets.only(top: 20)),
              _renderGridRow(),
              const Padding(padding: EdgeInsets.only(top: 20)),
              _renderGridRow(),
              const Padding(padding: EdgeInsets.only(top: 20)),
              _renderGridRow(),
              const Padding(padding: EdgeInsets.only(top: 20)),
              _renderGridRow(),
              const Padding(padding: EdgeInsets.only(top: 20)),
              _renderGridRow(),
              const Padding(padding: EdgeInsets.only(top: 20)),
              _renderGridRow()
            ],
          ));
    } else if (state == States.list) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: CustomListview<PhotosModel>(
          future: _photos,
          onRefresh: _onRefresh,
          renderLeading: _renderLeading,
          renderTitle: _renderTitle,
          onTapRecord: (record) => false,
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: _onChangeIcon,
              icon: _renderIcon() ?? const Icon(Icons.hourglass_empty))
        ],
      ),
      body:
          Container(padding: const EdgeInsets.all(5), child: _renderContent()),
    );
  }
}
