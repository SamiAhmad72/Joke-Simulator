import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/constants.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  bool passwordEye = true;
  bool success = true;
  String dropdownvalue = 'Male';
  var items = [
    'Male',
    'Female',
  ];

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Listener(
      onPointerDown: (PointerDownEvent event) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            padding: const EdgeInsets.only(top: 20),
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Stack(
          children: [
            SizedBox(
              width: screenWidth,
              child: Image.asset('assets/images/sign_up_bg.png',
                  fit: BoxFit.cover),
            ),
            // IconButton(
            //   padding: EdgeInsets.only(top: 20),
            //   icon: Icon(
            //     Icons.arrow_back,
            //     size: 30,
            //     color: Colors.white,
            //   ),
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            // ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.9,
                margin: EdgeInsets.only(top: screenHeight * 0.27),
                padding: const EdgeInsets.all(25),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 26),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
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
                        labelText: 'User Name',
                        hintText: 'Enter Your User Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          success == false;
                          return 'User Name cannot be Empty';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: passwordEye,
                      enableSuggestions: false,
                      autocorrect: false,
                      validator: (value) {
                        RegExp regex = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');

                        if (value == null || value.isEmpty) {
                          success == false;
                          return 'Password can not be empty';
                        }
                        if (!regex.hasMatch(value)) {
                          success == false;
                          return 'Password must contain 6 characters (Special characters,\nUppercase and Lowercase letter and Number';
                        }
                        return null;
                      },
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
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailController,
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
                      validator: (value) {
                        RegExp regex = RegExp(r"^[a-z0-9+_.-]+@[a-z.-]+.[a-z]");
                        if (value == null || value.isEmpty) {
                          success == false;
                          return 'Please enter an Email address';
                        }
                        if (!regex.hasMatch(value)) {
                          success == false;
                          return 'Please a valid Email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      child: TextField(
                        controller: numberController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
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
                          labelText: 'Number',
                          hintText: 'Enter Your Number',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
                      height: 30,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        // style: ElevatedButton.styleFrom(
                        //     backgroundColor: Color.fromARGB(255, 68, 78, 177)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                            contex = context;
                            final un = usernameController.text;
                            final pw = passwordController.text;
                            final nm = numberController.text;
                            final em = emailController.text;
                            final gn = dropdownvalue;

                            allControl.createUser(
                                user: un,
                                password: pw,
                                number: nm,
                                email: em,
                                gender: gn);
                          }
                        },
                        child: const Text(
                          "S I G N  U P",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                        "By creating an account, you agree with our Terms & Conditions and Privacy Policy",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins', color: Colors.grey)),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
