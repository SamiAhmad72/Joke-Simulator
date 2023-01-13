import 'dart:async';

import 'package:demo_project/views/main_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AssetImage splash = const AssetImage('assets/images/splash_screen.gif');

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffffffff),
        body: Center(
          child: Image.asset('assets/images/splash_screen.gif'),
        ));
  }
}
// ImagePixels.container(
//         imageProvider: splash,
//         child: Container(
//           alignment: Alignment.center,
//           child: SizedBox(child: Image(image: splash)),
//         ),
//       ),


