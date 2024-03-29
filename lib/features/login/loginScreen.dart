import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    loginBloc.add(LoginInitialEvent());
    super.initState();
  }

  final LoginBloc loginBloc = LoginBloc();
  final _auth = FirebaseAuth.instance;
  final _loginformkey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    final emailField = TextFormField(
      style: const TextStyle(color: Colors.black),
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Your Email.";
        }
        //reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter Valid Email");
        }
        //reg expression for validation of domain
        // if (!RegExp("\b*.com\$", caseSensitive: true).hasMatch(value)) {
        //   return ("Enter Valid Email");
        // }
        return null;
      },
      onSaved: (value) {
        _loginformkey.currentState!.validate();
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      cursorColor: Theme.of(context).colorScheme.primary,
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        prefixIcon:
            const Icon(CupertinoIcons.mail_solid, color: Color(0xFF023047)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        hintStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
    final passwordField = TextFormField(
      style: const TextStyle(color: Colors.black),
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{8,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter valid password.");
        }
        return null;
      },
      onSaved: (value) {
        _loginformkey.currentState!.validate();
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      cursorColor: Theme.of(context).colorScheme.primary,
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        prefixIcon:
            const Icon(CupertinoIcons.lock_fill, color: Color(0xFF023047)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Passoword",
        hintStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
    final loginButton = MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 10,
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      height: 60,
      minWidth: myWidth * 0.65,
      color: Theme.of(context).colorScheme.primary,
      splashColor: Theme.of(context).colorScheme.secondary,
      onPressed: () {
        logIn(emailController.text, passwordController.text);
      },
      child: Text(
        "Login",
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: loginBloc,
      listenWhen: (previous, current) => current is LoginActionState,
      buildWhen: (previous, current) => current is! LoginActionState,
      listener: (context, state) {
        if (state is LoginNavToSignupState) {
          Navigator.pushNamed(context, "/signup");
        } else if (state is LoginNavToMainState) {
          Navigator.pushReplacementNamed(context, "/main");
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case LoginInitial:
            return Scaffold(
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Lottie.asset(
                      "assets/night-mountains.json",
                      fit: BoxFit.cover,
                      backgroundLoading: true,
                      reverse: true,
                      height: myHeight,
                      width: myWidth,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: myWidth * 0.5,
                            bottom: myHeight * 0.2,
                            top: myHeight * 0.06,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  loginBloc.add(GetStartedClickedEvent());
                                },
                                child: Lottie.asset(
                                  "assets/get-started.json",
                                  fit: BoxFit.contain,
                                  height: myHeight * 0.05,
                                ),
                              )
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.white.withOpacity(0.3),
                            height: myHeight * 0.4,
                            width: myWidth * 0.85,
                            child: Padding(
                              padding: EdgeInsets.all(myWidth * 0.05),
                              child: Form(
                                key: _loginformkey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    emailField,
                                    SizedBox(height: myHeight * 0.02),
                                    passwordField,
                                    SizedBox(height: myHeight * 0.03),
                                    loginButton,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }

  void logIn(String email, String password) async {
    if (_loginformkey.currentState!.validate()) {
      print("object");
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                loginBloc.add(LoginButtonClickedEvent()),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
