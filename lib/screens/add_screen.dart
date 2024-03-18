import 'package:flutter/material.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
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
