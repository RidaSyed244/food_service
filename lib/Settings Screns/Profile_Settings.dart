import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_service/Settings%20Screns/Account_Settings.dart';
import 'package:food_service/StateManagement.dart';
import 'package:food_service/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../Home Screens/HomePage.dart';
import 'PasswordChange.dart';

final usersData = FirebaseFirestore.instance
    .collection('Users')
    .doc(FirebaseAuth.instance.currentUser?.uid)
    .snapshots()
    .map((event) => Users.fromMap(event.data()!));
final profileData = StreamProvider.autoDispose<Users>((ref) {
  return usersData;
});

class ProfileSettings extends ConsumerStatefulWidget {
  ProfileSettings({
    super.key,
  });

  @override
  ConsumerState<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends ConsumerState<ProfileSettings> {
  @override
  Widget build(BuildContext context) {
    final profiledata = ref.watch(profileData);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AccountSettings()));
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            "Profile Settings",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
          child: profiledata.when(
              data: (data) {
                return ListView(
                  children: [
                    Center(
                      child: Text(
                        "Update your Profile",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(17, 30, 23, 1),
                            fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "To update your email addres you have\nto login again",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 17),
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "Full NAME",
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
                      controller: nameController,
                      onFieldSubmitted: (value) async {},
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          hintText: "${data.UserName}",
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
                      height: 25,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "EMAIL ADDRESS",
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
                      controller: emailController,
                      onFieldSubmitted: (value) async {
                        // Update email in Firebase Authentication
                      },
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: "${data.UserEmail}",
                        hintStyle: TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(31, 87, 85, 85),
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "PHONE NUMBER",
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
                      controller: countryCode,
                      onChanged: (value) async {
                        phone = value;
                      },
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          hintText: "${data.UserPhoneNo}",
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
                      controller: passwordController,
                      obscureText: true,
                      onFieldSubmitted: (value) async {
                        await FirebaseFirestore.instance
                            .collection("Users")
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .update({"UserPassword": passwordController.text});
                        await FirebaseAuth.instance.currentUser
                            ?.updatePassword(passwordController.text);
                      },
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          suffixIcon: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChangePassword()));
                            },
                            child: Text("Change",
                                style: TextStyle(
                                    color: Color.fromRGBO(238, 167, 52, 1),
                                    fontSize: 15)),
                          ),
                          hintText: "${data.UserPassword}",
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
                      height: 40,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Material(
                        color: Color.fromRGBO(238, 167, 52, 1),
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        child: MaterialButton(
                          onPressed: () async {
                            await ref.read(logicalScreen.notifier).updateName();
                            await ref
                                .read(logicalScreen.notifier)
                                .updateEmail();
                            await ref
                                .read(logicalScreen.notifier)
                                .updatePassword();
                            // await ref
                            //     .read(logicalScreen.notifier)
                            //     .updatePhoneNo();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AccountSettings()));
                          },
                          minWidth: 230.0,
                          height: 10.0,
                          child: Text('CHANGE SETTINGS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              )),
                        ),
                      )
                    ]),
                  ],
                );
              },
              error: (e, s) {
                return Center(child: Text(e.toString()));
              },
              loading: () => Center(
                    child: CircularProgressIndicator(),
                  )),
        ));
  }
}
