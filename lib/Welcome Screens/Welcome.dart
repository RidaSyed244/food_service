import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../Logical SCreens/SignIn.dart';
import '../StateManagement.dart';
import '../welcome_screen_content.dart';

final dots = StateNotifierProvider((ref) => Services());

class WelcomeScreen extends ConsumerStatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  PageController? _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 60, 0, 0),
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
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Text("Tamang\nFoodService",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: WelcomeContents.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Center(
                              child: Image.asset(
                                WelcomeContents[i].image,
                                height: 340,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              WelcomeContents[i].title,
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(17, 30, 22, 1)),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            WelcomeContents[i].discription,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(157, 157, 157, 1),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  WelcomeContents.length,
                  (index) => ref.read(dots.notifier).buildDot(index, context),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(238, 167, 52, 1),
                  padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                onPressed: () {
                  if (currentIndex == WelcomeContents.length - 1) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SignIn(),
                      ),
                    );
                  }
                  _controller?.nextPage(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.bounceIn,
                  );
                },
                child: Text(currentIndex == WelcomeContents.length - 1
                    ? "Get Started"
                    : "Get Started"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
