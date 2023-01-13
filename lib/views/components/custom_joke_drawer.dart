import 'package:demo_project/views/constants/constants.dart';
import 'package:demo_project/views/components/circular_avatar_pic.dart';
import 'package:demo_project/views/profile_screen.dart';
import 'package:demo_project/views/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomJokeDrawer extends StatelessWidget {
  const CustomJokeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero, //removes padding from ListView
        children: [
          UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                  // image: DecorationImage(
                  //     fit: BoxFit.fill,
                  //     image: NetworkImage(
                  //       'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bWFuJTIwcG9ydHJhaXR8ZW58MHx8MHx8&w=1000&q=80',
                  //     ))
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.yellow,
                  Colors.blue,
                ],
              )),
              accountName: Text(usernameAllTime),
              accountEmail: Text(emailAllTime),
              currentAccountPicture: const AvatarPic(
                size: 50,
              )),
          ListTile(
            title: const Text("Profile"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          // ListTile(
          //   title: const Text("Edit Profile"),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => const EditProfileScreen()),
          //     );
          //   },
          // ),
          ListTile(
            title: const Text("Log Out"),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignIn()),
              );
            },
          ),
          const AboutListTile(
            icon: Icon(
              Icons.info,
            ),
            applicationIcon:
                Icon(Icons.add_reaction, color: Color(0xff218150), size: 50),
            applicationName: 'Joke Simulator',
            applicationVersion: '1.0.0',
            applicationLegalese: 'Copyright © 2023',
            child: Text("About Joke Simulator"),
          ),
        ],
      ),
    );
  }
}
