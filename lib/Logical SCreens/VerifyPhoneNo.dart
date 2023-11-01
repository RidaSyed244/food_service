// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:food_service/Logical%20SCreens/Phone_No.dart';
import 'package:food_service/Logical%20SCreens/SignIn.dart';
import 'package:food_service/Search%20screens/Current_location.dart';
 var code = '';
class VerifyPhoneNo extends StatefulWidget {
  const VerifyPhoneNo({super.key});

  @override
  State<VerifyPhoneNo> createState() => _VerifyPhoneNoState();
}

class _VerifyPhoneNoState extends State<VerifyPhoneNo> {
  bool _onEditing = true;
 
  FirebaseAuth auth = FirebaseAuth.instance;
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PhoneNumber()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Login to Foodly",
          style: TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: ListView(
          children: [
            Text(
              "Verify phone number",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Enter the 4-digit code sent to you",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            VerificationCode(
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.grey),
              keyboardType: TextInputType.number,
              underlineColor: Colors
                  .grey, // If this is null it will use primaryColor: Colors.red from Theme
              length: 6,

              cursorColor: Colors
                  .black, // If this is null it will default to the ambient

              margin: const EdgeInsets.all(2),
              onCompleted: (String value) {
                setState(() {
                  code = value;
                });
              },
              onEditing: (bool value) {
                setState(() {
                  _onEditing = value;
                });
                if (!_onEditing) FocusScope.of(context).unfocus();
              },
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
                    try {
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: PhoneNumber.verify,
                              smsCode: code);
                      await auth.signInWithCredential(credential)
                      .then(
                          (value) =>
                           Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn())));
                    } catch (e) {
                      print("Wrong OTP");
                    }
                  },
                  minWidth: 330.0,
                  child: Text('CONTINUE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      )),
                ),
              )
            ]),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Don't receive code?",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromRGBO(164, 164, 164, 1),
                      ),
                    )),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Resend Again",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.orange,
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "By Singing up you agree to our Terms\nConditions and Privacy Policy",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromRGBO(164, 164, 164, 1), fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
