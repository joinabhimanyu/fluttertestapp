import 'package:flutter/material.dart';
import 'package:fluttertestapp/models/posts_model.dart';
import 'package:fluttertestapp/containers/posts/post_details.dart';
import 'package:fluttertestapp/services/posts_service.dart';
import 'package:fluttertestapp/widgets/blogs_layout.dart';
import 'package:fluttertestapp/widgets/drawer_widget.dart';

enum MenuItemType {
  addPost,
  addPhoto,
  addLocation,
  addEvent,
  shareFacebook,
  reportAbuse,
  shareGmail,
  none
}

class MenuItem {
  final String title;
  final IconData icon;
  final MenuItemType type;

  const MenuItem({required this.title, required this.icon, required this.type});
}

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key, required this.title}) : super(key: key);

  static const routeName = "PostsPage";
  final String title;

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late Future<List<PostsModel>> _posts;
  List<MenuItem> _menus = [];

  @override
  void initState() {
    super.initState();
    _posts = getPosts("");
    var list = List.generate(7, (index) {
      if (index == 0) {
        return MenuItem(
            title: 'Add Post',
            icon: Icons.post_add,
            type: MenuItemType.addPost);
      } else if (index == 1) {
        return MenuItem(
            title: 'Add Photo', icon: Icons.photo, type: MenuItemType.addPhoto);
      } else if (index == 2) {
        return MenuItem(
            title: 'Add Location',
            icon: Icons.gps_fixed,
            type: MenuItemType.addLocation);
      } else if (index == 3) {
        return MenuItem(
            title: 'Add Event', icon: Icons.event, type: MenuItemType.addEvent);
      } else if (index == 4) {
        return MenuItem(
            title: 'Post on Facebook',
            icon: Icons.facebook,
            type: MenuItemType.shareFacebook);
      } else if (index == 5) {
        return MenuItem(
            title: 'Send Email',
            icon: Icons.email,
            type: MenuItemType.shareGmail);
      } else if (index == 6) {
        return MenuItem(
            title: 'Report Abuse',
            icon: Icons.report,
            type: MenuItemType.reportAbuse);
      }
      return MenuItem(
          title: '', icon: Icons.hourglass_empty, type: MenuItemType.none);
    });
    setState(() {
      _menus = list.toList();
    });
  }

  Future<void> _onRefresh(String? searchparam) {
    return Future.delayed(
      Duration.zero,
      () => {
        setState(() {
          _posts = getPosts(searchparam ?? "");
        })
      },
    );
  }

  Widget renderLeading(dynamic record) {
    return SizedBox(
      width: 40,
      child: Checkbox(
        value: false,
        onChanged: (value) => true,
      ),
    );
  }

  void onTapRecord(dynamic record) {
    Navigator.pushNamed(context, PostDetails.routeName, arguments: record);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              constraints: BoxConstraints(
                  maxHeight: 400,
                  maxWidth: MediaQuery.of(context).size.width * 0.97),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.all(5),
                  child: ListView.builder(
                    itemCount: _menus.length,
                    itemBuilder: (context, index) {
                      var item = _menus[index];
                      return ListTile(
                        leading: Icon(item.icon),
                        title: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(item.title),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
          child: Icon(Icons.add),
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.green),
              elevation: MaterialStatePropertyAll(50),
              fixedSize: MaterialStatePropertyAll(Size(50, 60)),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)))))),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      body: Container(
          padding: const EdgeInsets.all(5),
          child: BlogsLayout<PostsModel>(
            future: _posts,
            onRefresh: () => _onRefresh(""),
            imageFieldName: 'title',
            bodyFieldName: 'body',
            wantCustomSearch: true,
            wantCommentsField: true,
            onCommentsIconClick: (value) => false,
            onSearchIconClick: (value) => _onRefresh(value),
          )),
    );
  }
}
