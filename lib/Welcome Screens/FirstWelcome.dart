// ignore_for_file: override_on_non_overriding_member

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:food_service/Welcome%20Screens/Welcome.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FirstWelcome extends ConsumerStatefulWidget {
  const FirstWelcome({super.key, this.deeplink});
  final String? deeplink;
  @override
  ConsumerState<FirstWelcome> createState() => _FirstWelcomeState();
}

class _FirstWelcomeState extends ConsumerState<FirstWelcome> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            "assets/images/Circle Background.png",
          ),
          fit: BoxFit.contain,
          alignment: Alignment.bottomRight,
        )),
        child: Column(children: [
          Row(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 40, 0, 0),
              child: Container(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/g12.png",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Text("   Tamang\nFoodService",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold)),
            ),
          ]),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      "assets/images/illustration.png",
                      height: 310,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: 35,
                      color: Color.fromRGBO(58, 58, 58, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "It’s a pleasure to meet you. We are\nexcited that you’re here so let’s get\nstarted!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(131, 129, 125, 1),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(238, 167, 52, 1),
                padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                );
              },
              child: Text("GET STARTED"),
            ),
          ),
        ]),
      ),
    );
  }
}
