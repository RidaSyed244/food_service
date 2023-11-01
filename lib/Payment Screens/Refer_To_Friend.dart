// ignore_for_file: override_on_non_overriding_member

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:food_service/StateManagement.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../Welcome Screens/FirstWelcome.dart';

final share = StateNotifierProvider((ref) => Services());

class ReferToFriend extends ConsumerStatefulWidget {
  const ReferToFriend({super.key});

  @override
  ConsumerState<ReferToFriend> createState() => _ReferToFriendState();
}

class _ReferToFriendState extends ConsumerState<ReferToFriend> {
  late FirebaseDynamicLinks dynamicLinks;

  @override
  void initDynamicLinks() async {
    dynamicLinks.onLink.listen(
      (dynamicLink) async {
        final Uri? deepLink = dynamicLink.link;

        if (deepLink != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FirstWelcome()));
          // Navigator.pushReplacementNamed(
          //   context,
          //   '/firstWelcome',
          //   arguments: deepLink.queryParameters['title'],
          // );
          print(deepLink.queryParameters["title"].toString());
        } else {
          print("not initialized");
        }
      },
      onError: (e) async {
        print('onLinkError');
        print(e.message);
      },
    );

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FirstWelcome()));
      print("done");
    }
  }

  @override
  void initState() {
    dynamicLinks = FirebaseDynamicLinks.instance;
    initDynamicLinks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Refer to Friends",
          style: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(30, 35, 60, 0),
              child: Container(
                height: 170,
                child: Image.asset(
                  "assets/images/Icon-Credit card.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Refer a Friend, Get \$10",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Get \$10 in credits when someone sign up\nusing your refer link",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: SizedBox(
                height: 50,
                width: 70,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(248, 248, 248, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    side: const BorderSide(
                        width: 2, color: Color.fromRGBO(248, 248, 249, 1)),
                  ),
                  onPressed: () {
                    ref.read(share.notifier).share();
                  },
                  icon: Icon(
                    Icons.share,
                    color: Colors.black,
                    size: 20.0,
                  ),
                  label: Text(
                    'https://foodservice66.page.link/u9DC',
                    style: TextStyle(color: Colors.black, fontSize: 13),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
