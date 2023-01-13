import 'package:flutter/material.dart';

successSnackBar() {
  return SnackBar(
    content: Container(
        padding: const EdgeInsets.all(16),
        height: 90,
        decoration: BoxDecoration(
          //border: Border.all(color: Colors.black, width: 3),
          // gradient: LinearGradient(
          //   colors: [Color(0xffffe465), Colors.amberAccent],
          //   begin: Alignment.bottomLeft,
          //   end: Alignment.topRight,
          //   stops: [0.4, 0.7],
          //   tileMode: TileMode.repeated,
          // ),
          //color: const Color(0xffffe06b),
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.download_done_rounded,
              color: Colors.green,
              size: 30,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Success",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 5,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Welcome to Joke Simulator",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        )),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}

signInErrorSnackBar(String message) {
  // print(message);
  return SnackBar(
    content: Container(
        padding: const EdgeInsets.all(16),
        height: 90,
        decoration: BoxDecoration(
          //border: Border.all(color: Colors.black, width: 3),
          // gradient: LinearGradient(
          //   colors: [Color(0xffffe465), Colors.amberAccent],
          //   begin: Alignment.bottomLeft,
          //   end: Alignment.topRight,
          //   stops: [0.4, 0.7],
          //   tileMode: TileMode.repeated,
          // ),
          //color: const Color(0xffffe06b),
          color: const Color.fromARGB(255, 221, 74, 74),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.error_rounded,
              color: Color.fromARGB(255, 255, 255, 255),
              size: 30,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 5,
                          color: Color.fromARGB(255, 255, 174, 174),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "Please Try Again",
                    style: TextStyle(
                        color: Color.fromARGB(255, 235, 231, 231),
                        fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        )),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
