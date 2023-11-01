// ignore_for_file: unused_local_variable

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_service/Logical%20SCreens/Create_Account.dart';
import 'package:food_service/Logical%20SCreens/Forgot_Password.dart';
import 'package:food_service/Search%20screens/Current_location.dart';
import 'package:food_service/Welcome%20Screens/Welcome.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import '../StateManagement.dart';
import '../user.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;
String? token;

class SignIn extends ConsumerStatefulWidget {
  @override
  ConsumerState<SignIn> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  final formKey = GlobalKey<FormState>();
  bool _isPasswordHidden = true;
  emailValidationn(String value) {
    ref.read(logicalScreen.notifier).validateEmail(value);
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void generateAndSaveToken() async {
    // Request permission for notifications
    await messaging.requestPermission();

    // Get the FCM token
    token = await messaging.getToken();
    print('FCM Token: $token');
  }

  void initState() {
    super.initState();
    generateAndSaveToken();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Sign In",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(children: [
            Container(
              child: Text("Welcome to Tamang\nFood Services",
                  style: TextStyle(
                    color: Color.fromRGBO(17, 30, 23, 1),
                    fontSize: 35.0,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Enter your Phone number or Email\naddress for sign in , Enjoy your food:)",
              style: TextStyle(
                  fontSize: 17, color: Color.fromRGBO(164, 164, 164, 1)),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "EMAIL ADDRESS",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromRGBO(73, 73, 73, 1),
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Form(
              key: formKey,
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) async {
                  setState(() {
                    emailValidationn(value);
                  });
                },
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.check,
                      color: isEmailValid ? Colors.orange : null,
                      size: 20,
                    ),
                    hintText: "Enter your Email",
                    hintStyle: TextStyle(color: Color.fromRGBO(73, 73, 73, 1)),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(31, 87, 85, 85), width: 2.0),
                    )),
              ),
            ),
            SizedBox(height: 10.0),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "PASSWORD",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromRGBO(73, 73, 73, 1),
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: passwordController,
              obscureText: _isPasswordHidden,
              onChanged: (value) async {},
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordHidden = !_isPasswordHidden;
                      });
                      passwordController.selection = TextSelection.fromPosition(
                        TextPosition(offset: passwordController.text.length),
                      );
                    },
                  ),
                  hintText: "Enter your Password",
                  hintStyle: TextStyle(color: Color.fromRGBO(73, 73, 73, 1)),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(31, 87, 85, 85), width: 2.0),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    child: Text('Forgot Password?',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Color.fromRGBO(73, 73, 73, 1),
                        )),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()));
                    }),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Material(
                color: Color.fromRGBO(238, 167, 52, 1),
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                child: MaterialButton(
                  onPressed: () async {
                    try {
                      final logIn =
                          await ref.read(logicalScreen.notifier).logInUser();
                      if (logIn != false) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setString(
                            "UserEmail", emailController.text);
                      }
                      await ref.read(logicalScreen.notifier).getToken();

                       Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CurrentLocation()));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 5),
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        content: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(238, 167, 52, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              Text('Oh Snap!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text('Please Register first!!! ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                        behavior: SnackBarBehavior.floating,
                      ));
                    }
                  },
                  minWidth: 330.0,
                  height: 10.0,
                  child: Text('SIGN IN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                ),
              )
            ]),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Don't have account?",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromRGBO(73, 73, 73, 1),
                      ),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateAccount()));
                    },
                    child: Text(
                      "Create new account",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.orange,
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Center(
                child: Text(
              "Or",
              style: TextStyle(fontSize: 15, color: Colors.black),
            )),
            SizedBox(
              height: 15,
            ),
            SocialLoginButton(
              borderRadius: 8,
              buttonType: SocialLoginButtonType.facebook,
              onPressed: () {
                ref.read(logicalScreen.notifier).facebookLogin();
              },
            ),
            SizedBox(
              height: 15,
            ),
            SocialLoginButton(
              borderRadius: 8,
              backgroundColor: Colors.lightBlueAccent,
              textColor: Colors.white,
              buttonType: SocialLoginButtonType.google,
              onPressed: () {
                _googleSignIn.signIn().then((value) {
                  String userName = value!.displayName!;
                  String profilePicture = value.photoUrl!;
                });
              },
            ),
          ]),
        ),
      ),
    );
  }
}
