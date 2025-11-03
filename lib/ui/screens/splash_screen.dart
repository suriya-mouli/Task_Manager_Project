import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager_project/ui/controllers/auth_controller.dart';
import 'package:task_manager_project/ui/screens/login_screen.dart';
import 'package:task_manager_project/ui/screens/main_nav_bar_holder_screen.dart';
import 'package:task_manager_project/ui/widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    final bool isLoggedIn = await AuthController.isUserAlreadyLoggedIn();
    if (isLoggedIn) {
      await AuthController.getUserData();
      Navigator.pushReplacementNamed(context, MainNavBarHolderScreen.name);
    }
    else{
       Navigator.pushReplacementNamed(context, LoginScreen.name);

    }
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: SvgPicture.asset('assets/images/logo.svg', height: 400),
        ),
      ),
    );
  }
}
