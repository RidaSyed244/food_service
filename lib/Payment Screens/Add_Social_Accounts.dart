import 'package:flutter/material.dart';
import 'package:food_service/Settings%20Screns/Account_Settings.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class AddSocialAccounts extends StatefulWidget {
  const AddSocialAccounts({super.key});

  @override
  State<AddSocialAccounts> createState() => _AddSocialAccountsState();
}

class _AddSocialAccountsState extends State<AddSocialAccounts> {
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
                MaterialPageRoute(builder: (context) => AccountSettings()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Add Social Accounts",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 90, 20, 0),
        child: ListView(
          children: [
            Text(
              "Add social accounts",
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
              "Add your social accounts for more security.\nYou will go directly to their site",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SocialLoginButton(
              text: "CONNECT WITH FACEBOOK",
              fontSize: 13,
              borderRadius: 10,
              backgroundColor: Color.fromARGB(255, 19, 61, 95),
              textColor: Colors.white,
              buttonType: SocialLoginButtonType.facebook,
              onPressed: () {},
            ),
            SizedBox(
              height: 20,
            ),
            SocialLoginButton(
              text: "CONNECT WITH GOOGLE",
              fontSize: 13,
              borderRadius: 10,
              backgroundColor: Colors.lightBlueAccent,
              textColor: Colors.white,
              buttonType: SocialLoginButtonType.google,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
