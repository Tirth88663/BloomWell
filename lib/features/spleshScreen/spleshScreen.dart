import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late StreamSubscription<User?> user;
  @override
  void initState() {
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        splashBloc.add(SplashLogOutEvent());
      } else {
        splashBloc.add(SplashLogInEvent());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  final SplashBloc splashBloc = SplashBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      bloc: splashBloc,
      listenWhen: (previous, current) => current is SplashActionState,
      buildWhen: (previous, current) => current is! SplashActionState,
      listener: (context, state) {
        if (state is SplashNavToLoginScreenState) {
          Navigator.pushReplacementNamed(context, "/login");
        } else if (state is SplashNavToMainScreenState) {
          Navigator.pushReplacementNamed(context, "/main");
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case SplashWaitingActionState:
            return Scaffold(
              // backgroundColor: const Color(0xffbcf6f7),
              body: Center(
                child: Image.asset("assets/Bloom-well-nobg-logo.png"),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
