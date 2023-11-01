import 'package:flutter/material.dart';
import 'package:food_service/Order%20Screens/PreviousOrders.dart';
import 'package:food_service/Payment%20Screens/AddPaymentMethod.dart';
import 'package:food_service/Payment%20Screens/Card_List.dart';
import 'package:food_service/featuredItems.dart';

class PayMethods extends StatefulWidget {
  const PayMethods({super.key,});
  


  @override
  State<PayMethods> createState() => _PayMethodsState();
}

class _PayMethodsState extends State<PayMethods> {
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
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddPayementMethod(
                  i: 0,
                  itemsss: items,
                  subtotalForPayment: 0.0,
                  
                )));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Payment Methods",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: Container(
        child: ListView(children: [
          Padding(
            padding: EdgeInsets.fromLTRB(30, 120, 60, 0),
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
            "Don't have any card\n:)",
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
            "It seems like you have not added any\ncredit or debit card. You may easily add\ncard.",
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
          
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  side: const BorderSide(width: 2, color: Color.fromRGBO(238, 167, 52, 1)),
                ),
                onPressed: () {
                   Navigator.push(context,
                MaterialPageRoute(builder: (context) => CardList()));
                },
                icon: Icon(
                  Icons.location_on,
                  color: Color.fromRGBO(238, 167, 52, 1),
                  size: 0.0,
                ),
                label: Text(
                  'ADD CREDIT CARDS',
                  style: TextStyle(color: Color.fromRGBO(238, 167, 52, 1), fontSize: 17),
                ),
              ),
          ),
           ),
        ]),
      ),
    );
  }
}
