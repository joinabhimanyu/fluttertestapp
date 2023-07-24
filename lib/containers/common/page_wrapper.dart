import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertestapp/blocs/counter_cubit.dart';
import 'package:fluttertestapp/containers/common/login_page.dart';

class PageWrapper extends StatelessWidget {
  const PageWrapper({Key? key, required this.child, required this.cubit})
      : super(key: key);

  final Widget child;
  final CounterCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: LoginChecker(child: child),
    );
  }
}

class LoginChecker extends StatelessWidget {
  const LoginChecker({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterCubit, int>(
      builder: (context, state) {
        if (state == 0) {
          return const LoginPage(title: "Login Page");
        }
        return child;
      },
    );
  }
}
