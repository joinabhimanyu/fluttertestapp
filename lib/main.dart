import 'package:flutter/material.dart';
import 'package:fluttertestapp/containers/posts/posts_page.dart';
import 'package:fluttertestapp/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Routes _routes = Routes();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: PostsPage.routeName,
      onGenerateRoute: _routes.onGenerateRoute,
    );
  }
}
