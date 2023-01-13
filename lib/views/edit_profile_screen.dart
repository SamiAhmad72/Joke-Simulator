import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_project/views/profile_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

import 'components/circular_avatar_pic.dart';
import 'constants/constants.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late String dropdownvalue;
  late TextEditingController _usernameController;
  late TextEditingController _bioController;
  late TextEditingController _numberController;

  UploadTask? tempTask;
  bool progressState = false;

  @override
  void initState() {
    _usernameController = TextEditingController(text: usernameAllTime);
    _bioController = TextEditingController(text: bioAllTime);
    _numberController = TextEditingController(text: numberAllTime);
    dropdownvalue = genderAllTime;
    link();
    super.initState();
  }

  link() async {
    final storageRef = FirebaseStorage.instance.ref();
    final imageUrl = await storageRef.child(emailAllTime).getDownloadURL();
    userImage = imageUrl;
  }

  var items = [
    'Male',
    'Female',
  ];

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Listener(
        onPointerDown: (PointerDownEvent event) => FocusManager
            .instance.primaryFocus
            ?.unfocus(), // Unfocuses Keyboard On tap
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                // Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ProfileScreen()),
                // );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()),
                );
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Stack(
              alignment: Alignment.center,
              children: [
                buildColumn(),
                Positioned(
                  top: screenHeight * 0.3 - 110,
                  child: Stack(
                    children: [
                      const CircleAvatar(
                          radius: 75,
                          backgroundColor: Colors.white,
                          child: AvatarPic(size: 70)),
                      InkWell(
                        onTap: () {
                          uploadImg();
                          setState(() {});
                          //allControl.loadingDialog(contex, "edit");
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black,
                          child: Icon(Icons.add_a_photo_rounded),
                        ),
                      ),
                    ],
                  ),
                ),
                if (progressState == true) buildProgress(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProgress() {
    return StreamBuilder<TaskSnapshot>(
      stream: tempTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;
          return Container(
            height: screenHeight,
            width: screenWidth,
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 35,
              width: screenWidth,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: Colors.green,
                  ),
                  Center(
                    child: Text('${(100 * progress).roundToDouble()}%',
                        style: const TextStyle(color: Colors.white)),
                  )
                ],
              ),
            ),
          );
        } else {
          //  progressState == true;
          //  setState(() {});
          return const SizedBox(
            height: 1,
          );
        }
      },
    );
  }

  Widget buildColumn() {
    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.3,
          width: double.infinity,
          child: Image.network(userImage,
              color: Colors.white.withOpacity(0.5),
              colorBlendMode: BlendMode.modulate,
              fit: BoxFit.cover),
          // decoration: BoxDecoration(
          //     //  image:  DecorationImage(image: NetworkImage(url)),
          //     //   color: Color.fromRGBO(255, 255, 255, 0.2),
          //     ),
        ),
        const SizedBox(
          height: 70,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: TextField(
            controller: _usernameController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              labelText: 'User Name',
              hintText: 'Enter Your Name',
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: TextField(
            controller: _bioController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.book_rounded),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              labelText: 'Bio (Optional)',
              hintText: 'Enter Your Bio',
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: TextField(
            controller: _numberController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.phone),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              labelText: 'Number',
              hintText: 'Enter Your Number',
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Row(
            children: [
              const Text(
                "G E N D E R",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              DropdownButton(
                elevation: 0,
                // Initial Value
                value: dropdownvalue,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        SizedBox(
          width: screenWidth * 0.6,
          height: screenHeight * 0.07,
          child: ElevatedButton(
              onPressed: () async {
                editUser(
                    user: _usernameController.text,
                    gender: dropdownvalue,
                    bio: _bioController.text,
                    number: _numberController.text);

                allControl.getData();
                contex = context;
                allControl.loadingDialog("edit");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 230, 0),
                elevation: 15,
              ),
              child: const Text(
                "E D I T  P R O F I L E",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )),
        ),
        const SizedBox(
          height: 40,
        )
        //  buildProgress();
      ],
    );
  }
  // late UploadTask waiting;
  // Widget buildProgress(){
  //   return StreamBuilder<TaskSnapshot>(
  //     stream: waiting?.snapshotEvents,
  //     builder: (context,snapshot){
  //       if(snapshot.hasData){
  //         final data = snapshot.data!;
  //         double progress = data.bytesTransferred / data.totalBytes;
  //       }
  //     }
  //     );
  // }

  Future editUser(
      {required user, required number, required bio, required gender}) async {
    // var storeDocId = await FirebaseAuth.instance.currentUser!.email!;
    final ref =
        FirebaseFirestore.instance.collection('users').doc(emailAllTime);
    // final temp = ref;
    ref.update(
        {"username": user, "number": number, "gender": gender, "bio": bio});

    // if (storeDocId != email) {
    //   final temp = FirebaseFirestore.instance.collection('users').doc(email);

    //   final json = {
    //     'email': email,
    //     'number': number,
    //     'password': passwordAllTime,
    //     'username': user,
    //     'gender': gender
    //   };

    //   await temp.set(json);
    //   var userX = await FirebaseAuth.instance.currentUser!;
    //   final cred = await EmailAuthProvider.credential(
    //       email: emailAllTime, password: passwordAllTime);
    //   await userX.reauthenticateWithCredential(cred).then((value) async {
    //     await userX
    //         .updateEmail(_bioController.text)
    //         .then((_) {})
    //         .catchError((e) {
    //       ScaffoldMessenger.of(context)
    //           .showSnackBar(SnackBar(content: Text(e.toString())));
    //     });
    //   }).catchError((er) {
    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(SnackBar(content: Text(er.toString())));
    //   });
    //   FirebaseFirestore.instance.collection('users').doc(emailAllTime).delete();
    //   FirebaseAuth.instance.signOut();
    //   Navigator.pop(context);
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => const SignIn()),
    //   );
    // }
  }

  void uploadImg() async {
    late PlatformFile platformFile;
    // Picking File
    final select = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );
    if (select == null) return;
    //     setState(() {
    setState(() {
      platformFile = select.files.first;
    });
    //     });

    // Uploading File to Firebase Storage
    final path = emailAllTime;
    //  h.File filex = h.File([platformFile], path);

    final ref = FirebaseStorage.instance.ref().child(path);

    setState(() {
      tempTask = ref.putFile(File(platformFile.path!));
    });

    await tempTask!.whenComplete(() {});

    final storageRef = FirebaseStorage.instance.ref();
    final imageUrl = await storageRef.child(path).getDownloadURL();
    userImage = imageUrl;
    img = NetworkImage(imageUrl);

    setState(() {
      tempTask = null;
      progressState = true;
    });

    debugPrint(imageUrl);
  }
}
