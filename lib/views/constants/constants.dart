import 'package:flutter/cupertino.dart';
import '../../controllers/get_controller.dart';

String joke = "";
String twopart = "";
String modeAllTime = "single";

late BuildContext contex;
String usernameAllTime = " ";
String emailAllTime = " ";
String numberAllTime = " ";
String genderAllTime = " ";
String passwordAllTime = " ";
String bioAllTime = " ";
String userImage =
    'https://w7.pngwing.com/pngs/340/956/png-transparent-profile-user-icon-computer-icons-user-profile-head-ico-miscellaneous-black-desktop-wallpaper.png';

GetController allControl = GetController();

NetworkImage img = const NetworkImage(
    'https://w7.pngwing.com/pngs/340/956/png-transparent-profile-user-icon-computer-icons-user-profile-head-ico-miscellaneous-black-desktop-wallpaper.png');
