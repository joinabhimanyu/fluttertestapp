import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertestapp/blocs/counter_cubit.dart';
import 'package:fluttertestapp/containers/posts/edit_post_details.dart';
import 'package:fluttertestapp/models/posts_model.dart';

class PostDetails extends StatelessWidget {
  const PostDetails({Key? key, required this.title, required this.data})
      : super(key: key);

  final String title;
  final PostsModel data;
  static const String routeName = "PostDetails";

  void onPressed(context) {
    Navigator.pushNamed(context, EditPostDetails.routeName, arguments: data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => {onPressed(context)},
              icon: const Icon(Icons.edit)),
          IconButton(onPressed: () => false, icon: const Icon(Icons.delete)),
        ],
        title: Text(title),
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: Center(
            child: Card(
              child: Column(
                children: [
                  // Image.network(
                  //     "https://th.bing.com/th/id/OIP.sldsThi-4O7viMDMp527cgHaE8?pid=ImgDet&rs=1"),
                  const Padding(padding: EdgeInsets.only(left: 25, top: 25)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Title',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10.00)),
                      Text(
                        data.title,
                        softWrap: true,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 30.00)),
                      const Text(
                        'Body',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10.00)),
                      Text(
                        data.body,
                        softWrap: true,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
