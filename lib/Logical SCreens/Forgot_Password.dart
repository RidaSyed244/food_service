import 'package:flutter/material.dart';
import 'package:food_service/Logical%20SCreens/Reset_Email.dart';
import 'package:food_service/Logical%20SCreens/SignIn.dart';
import 'package:food_service/StateManagement.dart';
import 'package:food_service/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Forgot Password",
          style: TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: ListView(
          children: [
            Text('Forgot Password',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color.fromRGBO(17, 30, 23, 1),
                  fontSize: 33.0,
                )),
            SizedBox(
              height: 15,
            ),
            Text(
                'Enter your Email address and we will\nsend you a reset instructions. ',
                style: TextStyle(
                    fontSize: 17.0, color: Color.fromRGBO(164, 164, 164, 1))),
            SizedBox(
              height: 30,
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
            TextFormField(
              controller: emailController,
              onChanged: (value) async {},
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                  hintText: "Enter your Email",
                  hintStyle: TextStyle(color: Color.fromRGBO(73, 73, 73, 1)),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(31, 87, 85, 85), width: 2.0),
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Material(
                color: Color.fromRGBO(238, 167, 52, 1),
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                child: MaterialButton(
                  onPressed: () async {
                    await ref.read(logicalScreen.notifier).forgotPassword();
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ResetEmail(
                          email: emailController.text,
                        )));
                  },
                  minWidth: 330.0,
                  height: 13.0,
                  child: Text('RESET PASSWORD',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      )),
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
