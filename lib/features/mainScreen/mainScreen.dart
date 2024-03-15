import 'package:bloomwell/features/mainScreen/bloc/main_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    mainBloc.add(MainInitialEvent());
    super.initState();
  }

  final MainBloc mainBloc = MainBloc();

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<MainBloc, MainState>(
      bloc: mainBloc,
      listenWhen: (previous, current) => current is MainActionState,
      buildWhen: (previous, current) => current is! MainActionState,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          endDrawerEnableOpenDragGesture: true,
          drawerScrimColor: Colors.black87,
          extendBodyBehindAppBar: true,
          endDrawer: Drawer(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                    left: myWidth * 0.09,
                    right: myWidth * 0.04,
                    bottom: myWidth * 0.75),
                child: ListTile(
                  leading: Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Logout",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () => logout(context),
                ),
              ),
            ),
          ),
          appBar: AppBar(automaticallyImplyLeading: false),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Lottie.asset(
                  "assets/space-bg.json",
                  fit: BoxFit.cover,
                  backgroundLoading: true,
                  reverse: true,
                  height: myHeight,
                  width: myWidth,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacementNamed(context, "/login");
  }
}
