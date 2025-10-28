import 'dart:async';
import 'package:flutter/material.dart';
import 'package:water_intake_calculator/calculate.dart';

void main() {
  runApp(MaterialApp(home: Splashscreen()));
}

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {

    //timer to delay before navigating to second page
    Timer(Duration(seconds: 3), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => MainApp()));
    });

  //splashscreen with app name
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                'Ur WaterIntake!',
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 50),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircularProgressIndicator(strokeWidth: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
