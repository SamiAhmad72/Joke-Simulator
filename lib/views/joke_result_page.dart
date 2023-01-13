import 'package:demo_project/views/constants/constants.dart';
import 'package:flutter/material.dart';

class JokeResultPage extends StatelessWidget {
  final String mode;
  const JokeResultPage({super.key, required this.mode});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
      //backgroundColor: Color.fromARGB(255, 73, 71, 71),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Generated Joke"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.red,
              ],
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  //color: Colors.yellow,
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.2, right: screenWidth * 0.2),
                  child: Text(
                    mode == "single" ? joke : twopart,
                    style: TextStyle(
                        fontSize: screenWidth < screenHeight
                            ? screenWidth * 0.05
                            : screenWidth * 0.023,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: screenWidth < screenHeight
                      ? screenHeight * 0.1
                      : screenHeight * 0.05,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
