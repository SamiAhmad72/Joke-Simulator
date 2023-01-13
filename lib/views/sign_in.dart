import 'package:demo_project/views/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'constants/constants.dart';
import 'sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool passwordEye = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool homePassing = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Listener(
      onPointerDown: (PointerDownEvent event) => FocusManager
          .instance.primaryFocus
          ?.unfocus(), // Unfocuses Keyboard On Screen Tap
      child: Scaffold(
          body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Stack(
          children: [
            SizedBox(
                width: double.infinity,
                height: screenHeight * 0.55,
                child: Image.asset('assets/images/sign_in_bg.png',
                    fit: BoxFit.cover)),
            Container(
              margin: EdgeInsets.only(top: screenHeight * 0.5),
              padding: const EdgeInsets.all(25),
              height: screenHeight * 0.55,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Column(
                children: [
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Sign In",
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 26),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 156, 156, 156)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 64, 109, 255)),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter Your Email',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: passwordController,
                      obscureText: passwordEye,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        //  focusColor: Colors.white,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 156, 156, 156)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 64, 109, 255)),
                        ),
                        border: const OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter Password',
                        suffixIcon: IconButton(
                          icon: Icon(passwordEye
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(
                              () {
                                passwordEye = !passwordEye;
                              },
                            );
                          },
                        ),
                        alignLabelWithHint: false,
                        // filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      // style: ElevatedButton.styleFrom(
                      //     backgroundColor: Color.fromARGB(255, 247, 168, 65)),
                      onPressed: () {
                        signInOperation();

                        if (homePassing) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                          );
                        }
                      },
                      child: const Text(
                        "S I G N  I N",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: screenWidth,
                    height: 50,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50,
                          child: Text("Don't have an account? ",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()),
                            );
                          },
                          child: const SizedBox(
                            height: 50,
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  Future signInOperation() async {
    // ignore: unrelated_type_equality_checks
    if (usernameController.text == "" || passwordController.text == "") {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(signInErrorSnackBar("E M P T Y  F I E L D"));
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("E M P T Y   F I E L D")));
    } else {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController.text.trim(),
          password: passwordController.text.trim(),
        );
        final storageRef = FirebaseStorage.instance.ref();
        final imageUrl = await storageRef.child(emailAllTime).getDownloadURL();
        img = NetworkImage(imageUrl);
        homePassing = true;
      } on FirebaseAuthException catch (e) {
        late String str;
        if (e.toString().contains('password')) {
          str = "I N V A L I D    P A S S W O R D";
        } else {
          str = "I N V A L I D    E M A I L";
        }
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(str)));
        // ScaffoldMessenger.of(context).showSnackBar(signInErrorSnackBar(str));
      }
    }
  }
}
