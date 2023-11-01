import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_service/Map%20Screens/Ratings_Reviews.dart';
import 'package:food_service/Payment%20Screens/AddPaymentMethod.dart';
import 'package:food_service/Payment%20Screens/Add_Social_Accounts.dart';
import 'package:food_service/Payment%20Screens/Refer_To_Friend.dart';
import 'package:food_service/Screens/Filters.dart';
import 'package:food_service/Search%20screens/Current_location.dart';
import 'package:food_service/Settings%20Screns/FAQs.dart';
import 'package:food_service/Settings%20Screns/PasswordChange.dart';
import 'package:food_service/Welcome%20Screens/FirstWelcome.dart';
import 'package:food_service/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart';
import 'Profile_Settings.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class AccountSettings extends ConsumerStatefulWidget {
  const AccountSettings({super.key});

  @override
  ConsumerState<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends ConsumerState<AccountSettings> {
  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  

  bool _showNotifications = true; // Initialize with the desired default value
  @override
  void initState() {
    super.initState();
   

    FirebaseMessaging.onMessage.listen((message) {
      if (_showNotifications) {
        print("app is running in foreground");
        print('Foreground Message received: ${message.notification?.title}');

        if (message.notification != null) {
          print(message.notification!.body);
          print(message.notification!.title);
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (_showNotifications) {
        print(message.notification!.body);
        print(message.notification!.title);
      }
    });
  }

  final ProfileSettings profileSettings = ProfileSettings();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: Text(
                " Account Settings",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                  "Update your settings like notifications\npayments,profile edit etc.",
                  style: TextStyle(color: Colors.grey, fontSize: 20)),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              iconColor: Colors.grey,
              textColor: Colors.grey,
              leading: Icon(Icons.person),
              onTap: () {},
              title: Text("Profile Information"),
              subtitle: Text("Change your account information"),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileSettings()),
                    );
                  },
                  icon: Icon(Icons.arrow_forward_ios)),
            ),
            ListTile(
              iconColor: Colors.grey,
              textColor: Colors.grey,
              leading: Icon(Icons.lock),
              title: Text("Change Password"),
              subtitle: Text("Change your password"),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePassword()));
                  },
                  icon: Icon(Icons.arrow_forward_ios)),
            ),
            ListTile(
              iconColor: Colors.grey,
              textColor: Colors.grey,
              leading: Icon(Icons.payment),
              title: Text("Payment Methods"),
              subtitle: Text("Add your credit and debit cards"),
              trailing: IconButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => AddPayementMethod(
                    //             i: 0,
                    //             itemsss: items,
                    //             subtotalForPayment: 0.0,
                    //           )),
                    // );
                  },
                  icon: Icon(Icons.arrow_forward_ios)),
            ),
            ListTile(
              iconColor: Colors.grey,
              textColor: Colors.grey,
              leading: Icon(Icons.location_history),
              title: Text("Locations"),
              subtitle: Text("Add or remove your delivery locations"),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CurrentLocation()));
                  }, icon: Icon(Icons.arrow_forward_ios)),
            ),
            ListTile(
              iconColor: Colors.grey,
              textColor: Colors.grey,
              leading: Icon(Icons.facebook),
              title: Text("Add Social Account"),
              subtitle: Text("Add facebook, twitter etc."),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddSocialAccounts()));
                  },
                  icon: Icon(Icons.arrow_forward_ios)),
            ),
            ListTile(
              iconColor: Colors.grey,
              textColor: Colors.grey,
              leading: Icon(Icons.share),
              title: Text("Refer to Friends"),
              subtitle: Text("Get \$10 for reffering friends"),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReferToFriend()),
                    );
                  },
                  icon: Icon(Icons.arrow_forward_ios)),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text("NOTIFICATIONS",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              iconColor: Colors.grey,
              textColor: Colors.grey,
              leading: Icon(Icons.notifications),
              title: Text("Push Notifications"),
              subtitle: Text("For daily update you will get it"),
              trailing: Switch(
                value: _showNotifications,
                onChanged: (newValue) {
                  setState(() {
                    _showNotifications = newValue;
                  });
                },
                activeColor: Color.fromRGBO(238, 167, 52, 1),
                inactiveTrackColor: Colors.grey,
              ),
            ),
            ListTile(
              iconColor: Colors.grey,
              textColor: Colors.grey,
              leading: Icon(Icons.notifications),
              title: Text("SMS notifications"),
              subtitle: Text("For daily update you will get it"),
              trailing: Switch(
                value: _value2,
                onChanged: (newValue) {
                  setState(() {
                    _value2 = newValue;
                  });
                },
                activeColor: Color.fromRGBO(238, 167, 52, 1),
                inactiveTrackColor: Colors.grey,
              ),
            ),
            ListTile(
              iconColor: Colors.grey,
              textColor: Colors.grey,
              leading: Icon(Icons.notifications),
              title: Text("Promotional Notifications"),
              subtitle: Text("For daily update you will get it"),
              trailing: Switch(
                value: _value3,
                onChanged: (newValue) {
                  setState(() {
                    _value3 = newValue;
                  });
                },
                activeColor: Color.fromRGBO(238, 167, 52, 1),
                inactiveTrackColor: Colors.grey,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text("MORE",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              iconColor: Colors.grey,
              textColor: Colors.grey,
              leading: Icon(Icons.star),
              title: Text("Rate Us"),
              subtitle: Text("Rate us playstore,appstore"),
              trailing: IconButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => RatingsReviews()),
                    // );
                  },
                  icon: Icon(Icons.arrow_forward_ios)),
            ),
            ListTile(
              iconColor: Colors.grey,
              textColor: Colors.grey,
              leading: Icon(Icons.book),
              title: Text("FAQ"),
              subtitle: Text("Frequently asked questions"),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FAQs()),
                    );
                  
                  }, icon: Icon(Icons.arrow_forward_ios)),
            ),
            ListTile(
              iconColor: Colors.grey,
              textColor: Colors.grey,
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              trailing: IconButton(
                  onPressed: () async {
                    await ref
                        .read(logicalScreen.notifier)
                        .signout()
                        .then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FirstWelcome()),
                            ));
                  },
                  icon: Icon(Icons.arrow_forward_ios)),
            ),
          ],
        ),
      ),
    );
  }
}
