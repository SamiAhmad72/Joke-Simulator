import 'package:flutter/material.dart';

class ConnectionError extends StatelessWidget {
  const ConnectionError({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
        Text(
          "Connection Error",
          style: TextStyle(color: Colors.red, fontSize: 40),
        )
      ]),
    );
  }
}
