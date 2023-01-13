import 'package:demo_project/views/constants/constants.dart';
import 'package:demo_project/views/components/custom_joke_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'components/all_snackbars.dart';
import 'sign_in.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool xp = true;
  @override
  void initState() {
    allControl.getData();
    link();
    super.initState();
    loading();
  }

  loading() {
    Future.delayed(const Duration(seconds: 3), () {
      xp = false;
      img = NetworkImage(userImage);
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(successSnackBar());
    });
  }

  link() async {
    final storageRef = FirebaseStorage.instance.ref();
    final imageUrl = await storageRef.child(emailAllTime).getDownloadURL();
    userImage = imageUrl;
    img = NetworkImage(userImage);
    setState(() {});
  }

  bool loadingState = false;
  String x = "Any";

  //Firebase Info Fetch
//  String? email = FirebaseAuth.instance.currentUser!.email!;

  String initialCategoryValue = 'Any';
  String initialCategoryCustomValue = "Programming";
  var categoryItems = ['Any', 'Custom'];
  var categoryCustomItems = [
    'Programming',
    'Misc',
    'Dark',
    'Pun',
  ];

  String initialLanguageValue = 'en - English';
  var languageItems = [
    'en - English',
    'cs - Czech',
    'es - Spanish',
    'de - German',
  ];

  String initialJokeValue = 'single';
  var jokeItems = ['single', 'twopart'];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return xp == true
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            //backgroundColor: Color.fromARGB(255, 73, 71, 71),
            extendBodyBehindAppBar: true,
            drawer: const CustomJokeDrawer(),
            appBar: AppBar(
              title: const Text("Joke Simulator"),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignIn()),
                      );
                    },
                    icon: const Icon(Icons.logout))
              ],
            ),
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
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
                        width: screenWidth * 0.8,
                        height: screenHeight * 0.5,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(51, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20)),
                        child: SingleChildScrollView(
                            child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "S E L E C T  C A T E G O R Y",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // ignore: unnecessary_new

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                DropdownButton(
                                  value: initialCategoryValue,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                  ),
                                  items: categoryItems.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(
                                        items,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    if (newValue == "Custom") {
                                      loadingState = true;
                                    }
                                    if (newValue == "Any") {
                                      loadingState = false;
                                      x = newValue!;
                                    }
                                    initialCategoryValue = newValue!;

                                    setState(() {});
                                  },
                                ),
                                DropdownButton(
                                  value: initialCategoryCustomValue,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                  ),
                                  onChanged: loadingState == true
                                      ? (newValue) {
                                          setState(() {
                                            initialCategoryCustomValue =
                                                newValue.toString();
                                            x = initialCategoryCustomValue;
                                          });
                                        }
                                      : null,
                                  items:
                                      categoryCustomItems.map((String items1) {
                                    return DropdownMenuItem(
                                      value: items1,
                                      child: Text(
                                        items1,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "S E L E C T  L A N G U A G E",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // ignore: unnecessary_new
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                DropdownButton(
                                  value: initialLanguageValue,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                  ),
                                  items: languageItems.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(
                                        items,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    initialLanguageValue = newValue!;
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "S E L E C T  J O K E  T Y P E",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // ignore: unnecessary_new
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                DropdownButton(
                                  value: initialJokeValue,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                  ),
                                  items: jokeItems.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(
                                        items,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    initialJokeValue = newValue!;
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 20,
                                    minimumSize: const Size(64, 45),
                                    maximumSize: Size.infinite,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                onPressed: () {
                                  String url =
                                      "https://v2.jokeapi.dev/joke/$x?lang=${initialLanguageValue.substring(0, 2)}&type=$initialJokeValue";
                                  allControl.getJoke(url, initialJokeValue);
                                  contex = context;
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => JokeResultPage(
                                  //             mode: initialJokeValue,
                                  //           )),
                                  // );
                                },
                                child: const Text("Generate Joke")),
                          ]),
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
