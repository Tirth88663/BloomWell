import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../models/user_model.dart';
import 'bloc/signup_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  void initState() {
    signupBloc.add(SignupInitialEvent());
    super.initState();
  }

  final SignupBloc signupBloc = SignupBloc();
  final _auth = FirebaseAuth.instance;
  final _signupformKey = GlobalKey<FormState>();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    final emailField = TextFormField(
      style: const TextStyle(color: Colors.black),
      autofocus: false,
      controller: emailEditingController,
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
        _signupformKey.currentState!.validate();
        emailEditingController.text = value!;
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
      controller: passwordEditingController,
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
        _signupformKey.currentState!.validate();
        passwordEditingController.text = value!;
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
    final signupButton = MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 10,
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      height: 60,
      minWidth: myWidth * 0.65,
      color: Theme.of(context).colorScheme.primary,
      splashColor: Theme.of(context).colorScheme.secondary,
      onPressed: () {
        signUp(emailEditingController.text, passwordEditingController.text);
      },
      child: Text(
        "SignUp",
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

    return BlocConsumer<SignupBloc, SignupState>(
      bloc: signupBloc,
      listener: (context, state) {
        if (state is SignupNavToMainState) {
          Navigator.pushReplacementNamed(context, "/main");
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case SignupInitial:
            return Scaffold(
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  foregroundColor: Theme.of(context).colorScheme.primary,
                ),
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Lottie.asset(
                        "assets/boat-bg.json",
                        fit: BoxFit.cover,
                        backgroundLoading: true,
                        reverse: true,
                        height: myHeight,
                        width: myWidth,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Colors.white.withOpacity(0.4),
                          height: myHeight * 0.4,
                          width: myWidth * 0.85,
                          child: Padding(
                            padding: EdgeInsets.all(myWidth * 0.05),
                            child: Form(
                              key: _signupformKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  emailField,
                                  SizedBox(height: myHeight * 0.02),
                                  passwordField,
                                  SizedBox(height: myHeight * 0.03),
                                  signupButton,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          default:
            return const SizedBox();
        }
      },
    );
  }

  void signUp(String email, String password) async {
    _signupformKey.currentState!.validate();
    if (_signupformKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :)");

    signupBloc.add(SignupButtonClickedEvent());
  }
}
