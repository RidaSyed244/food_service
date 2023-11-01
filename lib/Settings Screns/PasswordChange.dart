import 'package:flutter/material.dart';
import 'package:food_service/Settings%20Screns/Profile_Settings.dart';
import 'package:food_service/user.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

TextEditingController newPasswordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();

class ChangePassword extends ConsumerStatefulWidget {
  const ChangePassword({super.key});

  @override
  ConsumerState<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    final newPassword = ref.watch(profileData);
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
                  MaterialPageRoute(builder: (context) => ProfileSettings()));
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            "Profile Settings",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w500),
          ),
        ),
        body: Container(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: newPassword.when(
              data: (data) {
                return ListView(children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        "PASSWORD",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    obscureText: true,
                    obscuringCharacter: "*",
                    onChanged: (value) async {},
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        hintText: data.UserPassword,
                        hintStyle: TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(31, 87, 85, 85),
                              width: 2.0),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        "NEW PASSWORD",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: newPasswordController,
                    onChanged: (value) async {},
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        hintText: "",
                        hintStyle: TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(31, 87, 85, 85),
                              width: 2.0),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        "CONFIRM PASSWORD",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: confirmPasswordController,
                    onChanged: (value) async {},
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        hintText: "",
                        hintStyle: TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(31, 87, 85, 85),
                              width: 2.0),
                        )),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Material(
                      color: Color.fromRGBO(238, 167, 52, 1),
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      child: MaterialButton(
                        onPressed: () async {
                          if (newPasswordController.text ==
                              confirmPasswordController.text) {
                            ref.read(logicalScreen.notifier).updatePassword();
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileSettings()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 5),
                              content: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(238, 167, 52, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                child: Column(
                                  children: [
                                    Text('Oh Snap!',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text('Password does not match',
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
                        child: Text('CHANGE PASSWORD',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            )),
                      ),
                    )
                  ]),
                ]);
              },
              error: (error, stack) {
                return Center(
                  child: Text(error.toString()),
                );
              },
              loading: () => Center(
                child: CircularProgressIndicator(),
              ),
            )));
  }
}
