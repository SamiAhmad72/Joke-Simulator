import 'package:flutter/material.dart';

class ConnectionError extends StatefulWidget {
  const ConnectionError({super.key});

  @override
  State<ConnectionError> createState() => _ConnectionErrorState();
}

class _ConnectionErrorState extends State<ConnectionError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "Connection Error",
          style: TextStyle(color: Colors.red, fontSize: 40),
        )
      ]),
    );
  }
}
