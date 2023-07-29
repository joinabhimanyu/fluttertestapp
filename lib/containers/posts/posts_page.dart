import 'package:flutter/material.dart';
import 'package:fluttertestapp/models/posts_model.dart';
import 'package:fluttertestapp/containers/posts/post_details.dart';
import 'package:fluttertestapp/services/posts_service.dart';
import 'package:fluttertestapp/widgets/blogs_layout.dart';
import 'package:fluttertestapp/widgets/drawer_widget.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key, required this.title}) : super(key: key);

  static const routeName = "PostsPage";
  final String title;

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late Future<List<PostsModel>> _posts;

  @override
  void initState() {
    super.initState();
    _posts = getPosts("");
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
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: Text(widget.title),
      ),
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
