import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertestapp/blocs/counter_cubit.dart';
import 'package:fluttertestapp/widgets/custom_search_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final TextEditingController _usernameController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<CustomSearchFieldState> usernamefield = GlobalKey();
  final GlobalKey<CustomSearchFieldState> passwordfield = GlobalKey();

  bool isLoading = false;

  Widget _renderPage() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Card(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // https://cdn.dribbble.com/users/18123/screenshots/16724837/media/d7362f61dce3240e9dcaffa4ac02191b.png?compress=1&resize=400x300&vertical=center
                Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/8/85/Logo-Test.png"),
                const Padding(padding: EdgeInsets.only(top: 10)),
                CustomSearchField(
                  key: usernamefield,
                  hinText: "Username",
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                CustomSearchField(
                  key: passwordfield,
                  hinText: "Password",
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.green),
                        minimumSize: MaterialStatePropertyAll(Size(100, 50)),
                        textStyle: MaterialStatePropertyAll(TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))))),
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      Timer(const Duration(seconds: 2), () {
                        setState(() {
                          isLoading = false;
                        });
                        // ${usernamefield.currentState!.controller.text}
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Login successfull! Welcome")));
                        context.read<CounterCubit>().increment();
                      });
                    },
                    child: const Text('Login'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: _renderPage(),
    );
  }
}
