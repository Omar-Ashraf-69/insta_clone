import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Welcome back",
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.w500,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}
