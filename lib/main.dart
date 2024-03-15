import 'package:bloomwell/features/login/loginScreen.dart';
import 'package:bloomwell/features/mainScreen/mainScreen.dart';
import 'package:bloomwell/features/signup/signupScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'features/spleshScreen/spleshScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCU9YYBsI60BXy3AtL1IT9VizIxTJDdolk", // Your apiKey
      appId: "1:259991962536:android:9a459f0a5ac857b411d39d", // Your appId
      messagingSenderId: "XXX", // Your messagingSenderId
      projectId: "bloomwell-c4d36", // Your projectId
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BloomWell',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff60316E),
          primary: const Color(0xff231c5f),
          brightness: Brightness.dark,
          secondary: const Color(0xff343c80),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/main': (context) => const MainScreen(),
      },
    );
  }
}
