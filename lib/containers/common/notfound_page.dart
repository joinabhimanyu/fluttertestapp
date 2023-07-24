import 'package:flutter/material.dart';
import 'package:fluttertestapp/containers/posts/posts_page.dart';

class NotfoundPage extends StatelessWidget {
  const NotfoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        decoration: BoxDecoration(color: Colors.grey.shade50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Oops! Page Not Found',
                strutStyle: StrutStyle.disabled,
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 30,
                    textBaseline: TextBaseline.alphabetic),
              ),
              const Padding(padding: EdgeInsets.only(top: 30)),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, PostsPage.routeName);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Color.fromARGB(255, 67, 176, 220))),
                child: const Text('Home Page'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
