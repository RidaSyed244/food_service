import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NotificationTest extends StatefulWidget {
  const NotificationTest({super.key});

  @override
  State<NotificationTest> createState() => _NotificationTestState();
}

class _NotificationTestState extends State<NotificationTest> {
  sendNotifications() async {
    try {
      var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
      final body = {
        "to":
            "cUtgXuomQHOLAh2PClWLDZ:APA91bEsN-hU5e2Cksk5fmDWePkGMAKChlpZrCqa1ZMbWkmYkrxok-knxLOBl2nLSDJhFn43YGNvY2hC9XjRcXz-9VHEHlDCthhuHsHgJBD--85_uA7j5AXN0rc-6jxiv1HBh6OA8LZN",
        "notification": {
          "title": "New Order",
          "body": "You have a new order",
        },
      };
      var response = await post(url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                "key=AAAAbXwSTlU:APA91bEvCpFMnWOvco-UbHMGzWOsK8yTRqL1PxHwRBCjIKcRlsYKMb1mH-P9to-VkDcIsQUOhQPq0s1XoMdEZzbpFhrGGDfV1TRqQiWreVnUPPTnGfiK8Nrw4yX-bfxYTZuYrceTZ5SH"
          },
          body: jsonEncode(body));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print("Sendiing Notification ");
      print("Send Notification successfully");

    } catch (e) {
      print("Notification-Error: ${e}");
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(onPressed: () {
          sendNotifications();
        }, child: Text("Notification Send")),
      ),
    );
  }
}
