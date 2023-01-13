// ignore_for_file: unrelated_type_equality_checks

import 'package:demo_project/views/connection_error.dart';
import 'package:demo_project/views/home.dart';
import 'package:demo_project/views/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // print(snapshot.hasData);
              return const Home();
            } else if (snapshot.connectionState == ConnectionState) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const ConnectionError();
            } else {
              return const SignIn();
            }
          }),
    );
  }
}
