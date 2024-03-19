import 'package:flutter/material.dart';
import 'package:social_app/services/auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Welcome back",
            style: TextStyle(
              fontSize: 29,
              fontWeight: FontWeight.w500,
              color: Colors.blueAccent,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Authentication().signOut(context);
            },
            child: const Text("Sing out"),
          ),
        ],
      ),
    );
  }
}
