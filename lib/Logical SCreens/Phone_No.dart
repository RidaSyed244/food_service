import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_service/Logical%20SCreens/Create_Account.dart';
import 'package:food_service/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../StateManagement.dart';
import 'VerifyPhoneNo.dart';
import 'package:country_picker/country_picker.dart';

class PhoneNumber extends ConsumerStatefulWidget {
  const PhoneNumber({super.key});
  static String verify = '';
  @override
  ConsumerState<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends ConsumerState<PhoneNumber> {
  
  @override
  void initState() {
   countryCode.text="+92";
    super.initState();
  }
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
                MaterialPageRoute(builder: (context) => CreateAccount()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Login to Tamang Food\nServices",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: ListView(
          children: [
            Center(
              child: Text(
                "Get started with Foodly",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Enter your phone number to use foodly and\nenjoy your food:)",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(164, 164, 164, 1),
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "PHONE NUMBER",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromRGBO(164, 164, 164, 1),
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 55,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: countryCode,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: countryCode.text,
                          prefixIcon: IconButton(
                            icon: Icon(Icons.arrow_drop_down),
                            onPressed: () {
                              // showCountryPicker(
                              //   context: context,
                              //   showPhoneCode: true,
                              //   onSelect: (Country country) {
                              //     setState(() {
                              //       countryCode.text = country.phoneCode;
                              //     });
                              //   },
                              // );
                            },
                          )),
                    ),
                  ),
                  Text(
                    "|",
                    style: TextStyle(fontSize: 33, color: Colors.grey),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextField(
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      phone = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Phone"),
                  ))
                ],
              ),
            ),

            // IntlPhoneField(
            //   controller: phoneNoController,
            //   decoration: InputDecoration(
            //     border: OutlineInputBorder(
            //       borderSide: BorderSide(
            //         color: Colors.grey,
            //       ),
            //     ),
            //   ),
            //   initialCountryCode: 'IN',
            //   onChanged: (phone) {},
            // ),
            SizedBox(
              height: 150,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Material(
                color: Color.fromRGBO(238, 167, 52, 1),
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                child: MaterialButton(
                  onPressed: () async {
                    // await FirebaseAuth.instance.setSettings();
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: "${countryCode.text + phone}",
                      verificationCompleted: (PhoneAuthCredential credential) {
                        print(credential);
                      },
                      verificationFailed: (FirebaseAuthException e) {
                        print(e.message);
                      },
                      codeSent: (String verificationId, int? resendToken) {
                        PhoneNumber.verify = verificationId;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyPhoneNo()));
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                    await ref.read(logicalScreen.notifier).addPhoneNo();
                  },
                  minWidth: 340.0,
                  child: Text('SIGN UP',
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
