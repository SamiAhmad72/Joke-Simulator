import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../service/api/get_data_from_api.dart';
import '../service/models/user_info_model.dart';
import '../views/constants/constants.dart';
import '../views/joke_result_page.dart';

class GetController {
  getJoke(String url, String mode) async {
    await GetDataFromApi().getResponse(url, mode);
    loadingDialog("joke");
  }

  void getData() async {
    final emailX = FirebaseAuth.instance.currentUser!.email!;
    final docRef = FirebaseFirestore.instance.collection('users').doc(emailX);

    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        final userInfo = UserInfoModel.fromJson(data);
        emailAllTime = userInfo.email!;
        usernameAllTime = userInfo.username!;
        numberAllTime = userInfo.phoneNumber!;
        genderAllTime = userInfo.gender!;
        passwordAllTime = userInfo.password!;
        bioAllTime = userInfo.bio!;
      },
    );
    final storageRef = FirebaseStorage.instance.ref();
    final imageUrl = await storageRef.child(emailAllTime).getDownloadURL();
    userImage = imageUrl;
  }

  void getUserImageLink() async {
    final storageRef = FirebaseStorage.instance.ref();
    final imageUrl = await storageRef.child(emailAllTime).getDownloadURL();
    userImage = imageUrl;
  }

  void loadingDialog(String normalMode) {
    // Loading Dialog
    showDialog(
        //barrierDismissible: false,
        context: contex,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
//                   SpinKitRotatingCircle(
//                     color: Color.fromARGB(255, 7, 106, 255),
// //  size: 50.0,
//                   ),
                  SpinKitWave(
                    color: Color.fromARGB(255, 7, 106, 255),
                    size: 40,
                    type: SpinKitWaveType.center,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text('Loading...Please Wait')
                ],
              ),
            ),
          );
        });
    Timer(const Duration(seconds: 3), () {
      Navigator.pop(contex);
      if (normalMode == "joke") {
        Navigator.push(
            contex,
            MaterialPageRoute(
                builder: (context) => JokeResultPage(
                      mode: modeAllTime,
                    )));
      }
    });
  }

  Future createUser(
      {required user,
      required password,
      required number,
      required email,
      required gender}) async {
    // ignore: unrelated_type_equality_checks

    // final temp = FirebaseFirestore.instance.collection('users').doc(email);

    // final json = {
    //   'email': email,
    //   'number': number,
    //   'password': password,
    //   'username': user,
    //   'gender': gender,
    //   'bio': ""
    // };

    // await temp.set(json);

    // Sending To Firebase Auth
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      )
          .then((value) async {
        var userStatus = value.additionalUserInfo?.isNewUser;
        if (userStatus == true) {
          final temp =
              FirebaseFirestore.instance.collection('users').doc(email);

          final json = {
            'email': email,
            'number': number,
            'password': password,
            'username': user,
            'gender': gender,
            'bio': ""
          };
          await temp.set(json);

          // ignore: use_build_context_synchronously
          Navigator.pop(contex);
        }
      });
    } catch (ex) {
      ScaffoldMessenger.of(contex).showSnackBar(
        //  String
        SnackBar(content: Text(ex.toString())),
      );
    }
  }
}
