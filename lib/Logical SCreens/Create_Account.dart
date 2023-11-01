import 'package:flutter/material.dart';
import 'package:food_service/Logical%20SCreens/Phone_No.dart';
import 'package:food_service/Search%20screens/Current_location.dart';
import 'package:food_service/StateManagement.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import '../user.dart';
import 'SignIn.dart';

class CreateAccount extends ConsumerStatefulWidget {
  const CreateAccount({super.key});

  @override
  ConsumerState<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends ConsumerState<CreateAccount> {
  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
  final nameFormKey = GlobalKey<FormState>();
  bool isPasswordHide = true;
  emailValidate(String value) {
    ref.read(logicalScreen.notifier).emailValidation(value);
  }

  passwordValidate(String value) {
    ref.read(logicalScreen.notifier).passwordValidation(value);
  }

  nameValidate(String value) {
    ref.read(logicalScreen.notifier).nameValidation(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignIn()));
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "Forgot Password",
          style: TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: ListView(
          children: [
            Text(
              "Create Account",
              style:
                  TextStyle(color: Color.fromRGBO(17, 30, 23, 1), fontSize: 35),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Enter your Name, Email and Password\n for sign up. Already have account?",
              style: TextStyle(
                  fontSize: 17, color: Color.fromRGBO(164, 164, 164, 1)),
            ),
            SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "FULL NAME",
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
              key: nameFormKey,
              child: TextFormField(
                controller: nameController,
                onChanged: (value) async {
                  setState(() {
                    nameValidate(value);
                  });
                },
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  suffixIcon: Icon(
                      Icons.check,
                      color: isNameValid ? Colors.orange : null,
                      size: 20,
                    ),
                  hintText: "Enter your Name",
                  hintStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.grey,
                  )),
                ),
              ),
            ),
            SizedBox(
              height: 15,
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
              key: emailFormKey,
              child: TextFormField(
                controller: emailController,
                onChanged: (value) async {
                  setState(() {
                    emailValidate(value);
                  });
                },
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.check,
                      color: isValidEmail ? Colors.orange : null,
                      size: 20,
                    ),
                    hintText: "Enter your Email",
                    hintStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey,
                    ))),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(
                        isPasswordHide
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordHide = !isPasswordHide;
                        });
                        passwordController.selection =
                            TextSelection.fromPosition(
                          TextPosition(offset: passwordController.text.length),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Form(
              key: passwordFormKey,
              child: TextFormField(
                obscureText: isPasswordHide,
                controller: passwordController,
                onChanged: (value) async {
                  setState(() {
                    passwordValidate(value);
                  });
                },
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                   suffixIcon: Icon(
                      Icons.check,
                      color: isPasswordValid ? Colors.orange : null,
                      size: 20,
                    ),
                  hintText: "Enter your Password",
                  hintStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.grey,
                  )),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Material(
                color: Color.fromRGBO(238, 167, 52, 1),
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                child: MaterialButton(
                  onPressed: () async {
                    await ref.read(logicalScreen.notifier).createUser();
                    await ref.read(logicalScreen.notifier).registerUser();
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PhoneNumber()));
                   
                  },
                  minWidth: 330.0,
                  height: 10.0,
                  child: Text('SIGN UP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                ),
              )
            ]),
            SizedBox(
              height: 11,
            ),
            Text(
              "By Singing upyou agree to our Terms\nConditions and Privacy Policy",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromRGBO(164, 164, 164, 1), fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              "Or",
              style: TextStyle(
                  fontSize: 18, color: Color.fromRGBO(164, 164, 164, 1)),
            )),
            SizedBox(
              height: 10,
            ),
            SocialLoginButton(
              borderRadius: 8,
              buttonType: SocialLoginButtonType.facebook,
              onPressed: () {},
            ),
            SizedBox(
              height: 15,
            ),
            SocialLoginButton(
              borderRadius: 8,
              backgroundColor: Colors.lightBlueAccent,
              textColor: Colors.white,
              buttonType: SocialLoginButtonType.google,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
