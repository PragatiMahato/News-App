// ignore_for_file: file_names
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_app/screens/login.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 10), () {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>  const LoginScreen(),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 246, 234),
      body: Center(
        child: Image.asset(
          "asset/images/World.png",
          height: 270,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
