import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:social_app/screens/login_screen.dart';
import 'package:social_app/services/auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        "Welcome back",
      ),
    );
  }
}
