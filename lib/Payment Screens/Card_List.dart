import 'package:flutter/material.dart';
import 'package:food_service/Payment%20Screens/PaymentMethods.dart';
import 'package:food_service/Payment%20Screens/Refer_To_Friend.dart';
import 'package:food_service/Search%20screens/Locations.dart';

import '../featuredItems.dart';

class CardList extends StatefulWidget {
  const CardList({super.key});

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PayMethods()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Payment Methods",
          style: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: ListView(
          children: [
            ListTile(
              textColor: Color.fromRGBO(128, 135, 131, 1),
              title: Text(
                "PayPal",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                "Default Payment",
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              leading: Container(
                width: 47,
                height: 43,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 3, 71, 128),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  "assets/images/paypal.png",
                  fit: BoxFit.contain,
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ReferToFriend()));
                },
                icon: Icon(Icons.arrow_forward_ios),
                color: Colors.black,
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              textColor: Color.fromRGBO(128, 135, 131, 1),
              title: Text(
                "MasterCard",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                "Not Default",
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              leading: Container(
                width: 43,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.asset(
                  "assets/images/masterCard.png",
                  fit: BoxFit.contain,
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ReferToFriend()));
                },
                icon: Icon(Icons.arrow_forward_ios),
                color: Colors.black,
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              textColor: Color.fromRGBO(128, 135, 131, 1),
              title: Text(
                "Visa",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                " Not Default",
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              leading: Container(
                width: 43,
                height: 40,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 13, 75, 126),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.asset(
                  "assets/images/visa.png",
                  fit: BoxFit.contain,
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ReferToFriend()));
                },
                icon: Icon(Icons.arrow_forward_ios),
                color: Colors.black,
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
