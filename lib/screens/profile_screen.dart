import 'package:flutter/material.dart';
import 'package:social_app/colors/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: const Center(
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
