import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertestapp/blocs/counter_cubit.dart';
import 'package:fluttertestapp/containers/photos/photos_page.dart';
import 'package:fluttertestapp/containers/posts/posts_page.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue,
      child: ListView(
        padding: const EdgeInsets.only(top: 0),
        children: <Widget>[
          SizedBox(
            height: 200,
            child: DrawerHeader(
                decoration: const BoxDecoration(
                    // backgroundBlendMode: BlendMode.colorDodge,
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/commons/8/85/Logo-Test.png"))),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: const Text(''),
                )),
          ),
          ListTile(
            title: const Text(
              'Gallery',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, PhotosPage.routeName);
            },
          ),
          ListTile(
            title: const Text(
              'Posts',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, PostsPage.routeName);
            },
          ),
          ElevatedButton(
              onPressed: () {
                context.read<CounterCubit>().reset();
              },
              child: const Text("Logout"))
        ],
      ),
    );
  }
}
