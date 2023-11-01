import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_service/Drawer_Screens/add_Ratings.dart';
import 'package:food_service/Home%20Screens/HomePage.dart';
import 'package:food_service/Map%20Screens/Ratings_Reviews.dart';
import 'package:food_service/Screens/Filters.dart';
import 'package:food_service/Settings%20Screns/FAQs.dart';
import 'package:food_service/Settings%20Screns/faqTest.dart';
import 'package:food_service/bottomFile.dart';
import 'package:food_service/notTest.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'Drawer_Screens/Fresh_Orders.dart';
import 'Drawer_Screens/add_MultipleImages.dart';
import 'Order Screens/pastOrders.dart';
import 'Payment Screens/Refer_To_Friend.dart';
import 'Search screens/Current_location.dart';
import 'Welcome Screens/FirstWelcome.dart';
import 'package:http/http.dart' as http;

// Future<void> backgroundHandler(RemoteMessage message) async {
//   print(message.data.toString());
//   // print(message.notification!.title);
// }

// String? token;
// FirebaseMessaging messaging = FirebaseMessaging.instance;
// // Generate and save FCM token for the logged-in user
// void generateAndSaveToken() async {
//   // Request permission for notifications
//   await messaging.requestPermission();

//   // Get the FCM token
//   token = await messaging.getToken();
//   print('FCM Token: $token');

//   await Future.delayed(Duration(seconds: 15));
//   String notificationTitle = 'Tamang food service';
//   String notificationBody = 'Welcome to Tamang food service';
//   sendNotification(token!, notificationTitle, notificationBody);
// }

// final String serverKey =
//     'AAAAbXwSTlU:APA91bEvCpFMnWOvco-UbHMGzWOsK8yTRqL1PxHwRBCjIKcRlsYKMb1mH-P9to-VkDcIsQUOhQPq0s1XoMdEZzbpFhrGGDfV1TRqQiWreVnUPPTnGfiK8Nrw4yX-bfxYTZuYrceTZ5SH'; // Replace with your FCM server key
// final String fcmEndpoint = 'https://fcm.googleapis.com/fcm/send';

// final Map<String, String> headers = {
//   'Content-Type': 'application/json',
//   'Authorization': 'key=$serverKey',
// };

// Future<void> sendNotification(String to, String title, String body) async {
//   final Map<String, dynamic> notification = {
//     'title': title,
//     'body': body,
//   };

//   final Map<String, dynamic> data = {
//     'to': to,
//     'notification': notification,
//   };

//   final String jsonString = jsonEncode(data);

//   try {
//     final response = await http.post(
//       Uri.parse(fcmEndpoint),
//       headers: headers,
//       body: jsonString,
//     );

//     if (response.statusCode == 200) {
//       print('Notification sent successfully');
//     } else {
//       print('Failed to send notification. Error: ${response.body}');
//     }
//   } catch (e) {
//     print('Error sending notification: $e');
//   }
// }

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox("SideItemsIsCheck");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  // generateAndSaveToken();

  // print('FCM Token: $token');

// sendNotificationToUser(FirebaseAuth.instance.currentUser!.uid, 'Rida Syed', 'Yes i m here');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('UserEmail');
  Stripe.publishableKey =
      'pk_test_51N59lnG4XJL1LH230PHtqwsjlin7pCwzBsa8dDh3WYkw80iJYol98O2Z9ixu62X5GQm5O0QAUXTl4DKom7TDwSyD00aqHP7qe8';
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(ProviderScope(
      child: MyWidget(
    email: email,
  )));
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key, required this.email});
  final email;
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  // @override
  // void initState() {
  //   FirebaseMessaging.instance.getInitialMessage().then((messahe) {
  //     print("app is terminated");

  //     if (messahe != null) {
  //       //firebase messaging is started from here
  //       print("New Notification");
  //     }
  //   });
  //   FirebaseMessaging.onMessage.listen((message) {
  //     print("app is running in foreground");
  //     print('Foreground Message received: ${message.notification?.title}');

  //     if (message.notification != null) {
  //       //when app running on foreground and we get notification
  //       print(message.notification!.body);
  //       print(message.notification!.title);
  //     }
  //   });
  //   ////when appp is in background and not terminated and we get notification
  //   FirebaseMessaging.onMessageOpenedApp.listen((message) {
  //     print('Background Message clicked: ${message.notification?.title}');

  //     print("app is running in background");
  //     if (message.notification != null) {
  //       print(message.notification!.body);
  //       print(message.notification!.title);
  //     }
  //   });

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // initialRoute: '/',
        // routes: {
        //   "/": (context) => ReferToFriend(),
        //   '/firstWelcome': (context) => FirstWelcome()
        // },
        debugShowCheckedModeBanner: false,
        home: widget.email == null ? FirstWelcome() : BottonNavigation());
  }
}
