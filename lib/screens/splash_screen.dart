import 'package:flutter/material.dart';
import 'package:mobigic_assignment/screens/numbers_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    /// Start New Screen
    Future.delayed(
      const Duration(seconds: 3),
    ).then(
      (value) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const NumbersScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "SPLASH SCREEN",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
