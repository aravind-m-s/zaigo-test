import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zaigo_test/view/screen_home/screen_home.dart';
import 'package:zaigo_test/view/screen_login/screen_login.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({super.key});

  changePage(BuildContext context) async {
    Future.delayed(const Duration(seconds: 2)).then((value) async {
      await SharedPreferences.getInstance().then((prefs) {
        if (prefs.getString('token') == null ||
            prefs.getString('token')!.isEmpty) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const ScreenLogin(),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const ScreenHome(),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    changePage(context);
    return const Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 100,
        ),
      ),
    );
  }
}
