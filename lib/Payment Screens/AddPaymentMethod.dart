import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_service/Home%20Screens/HomePage.dart';
import 'package:food_service/Order%20Screens/AddToOrder.dart';
import 'package:food_service/Order%20Screens/ConFirmYourOrder.dart';
import 'package:food_service/Order%20Screens/Confirm_order.dart';
import 'package:food_service/Order%20Screens/OrderDone.dart';
import 'package:food_service/Order%20Screens/Special_InstructionScreen.dart';
import 'package:food_service/Order%20Screens/Your_Orders.dart';
import 'package:food_service/Payment%20Screens/Scan_Card.dart';
import 'package:food_service/cartChangeNotifier.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../Order Screens/PreviousOrders.dart';
import '../StateManagement.dart';
import 'package:http/http.dart' as http;

import '../featuredItems.dart';

final payment = StateNotifierProvider((ref) => Services());

class AddPayementMethod extends ConsumerStatefulWidget {
  final String? restrauntName;
  final String? restrauntLocation;
  final Menu itemsss;
  final String? storeId;
  final totalItems;
  final String? categoryId;
  final String? productId;
  final int? indexSI;
  final double subtotalForPayment;
  final int i;
  AddPayementMethod({
    required this.itemsss,
    this.restrauntName,
    this.restrauntLocation,
    this.categoryId,
    this.totalItems,
    this.indexSI,
    required this.subtotalForPayment,
    required this.i,
    this.productId,
    this.storeId,
  });

  @override
  ConsumerState<AddPayementMethod> createState() => _AddPayementMethodState();
}

class _AddPayementMethodState extends ConsumerState<AddPayementMethod> {
  @override
  void initState() {
    cardNumberController.addListener(() {
      ref.watch(payment.notifier).getCardTypeFrnNum();
    });
    super.initState();
  }

  Map<String, dynamic>? paymentIntentData;
  Future makePayment() async {
    try {
      paymentIntentData = await createPaymentIntent("usd");
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentData?['client_secret'],
        // applePay: true,
        // googlePay: true,
        // merchantCountryCode: 'US',
        merchantDisplayName: 'Food Service',
      ));
      displayPaymentSheet();
    } catch (e) {
      print("exception" + e.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData?['client_secret'],
        ),
      );
      // Stripe.instance.presentPaymentSheet(
      //   params: PresentPaymentSheetParameters(
      //   clientSecret: paymentIntentData!['client_secret'],
      // confirmPayment: true,
      // )

      // );
      setState(() {
        paymentIntentData = null;
      });

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromRGBO(238, 167, 52, 1),
          content: const Text('Paid Successfully',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500))));
    } on StripeException catch (e) {
      print(e.toString());
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String currency) async {
    try {
      Map<String, dynamic> body = {
        "amount": calculateAmount(),
        "currency": currency,
        "payment_method_types[]": "card",
      };
      var response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            "Authorization":
                "Bearer sk_test_51N59lnG4XJL1LH23Jk69bTx5ctGARNx2UhedYEtzVYVrHqyqL5RBfG9u9IJL9KHvrnHsyLbTn3sCIRjlkxYtiJtg00q0BryBTi",
            "Content_Type": "application/x-www-form-urlencoded",
          });
      return jsonDecode(response.body.toString());
    } catch (e) {
      print("exception" + e.toString());
    }
  }

  calculateAmount() {
    final price = (widget.subtotalForPayment).toStringAsFixed(0);
    return price.toString();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   cardNumberController.dispose();
  //   cvcController.dispose();
  //   cardMonthController.dispose();

  // }

  @override
  Widget build(BuildContext context) {
    // final totalItems = ref.watch(cart);

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            color: Colors.black,
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => YourOrders()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 25,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Add your payment methods",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "This card will only be charged when\nyou place an order",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, color: Colors.grey),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    controller: cardNumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(19),
                      CardMonthInputFormatter(),
                    ],
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color.fromARGB(255, 204, 201, 201),
                        )),
                        hintText: "4343 4343 4343 4343",
                        filled: true,
                        fillColor: Color.fromRGBO(251, 251, 251, 1),
                        prefixIcon: Icon(Icons.credit_card)),
                  ),
                ],
              )),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: cvcController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color.fromARGB(255, 204, 201, 201),
                        )),
                        hintText: "CVC",
                        filled: true,
                        fillColor: Color.fromRGBO(251, 251, 251, 1),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: cardMonthController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(5),
                        CardMonthInputDateFormatter(),
                      ],
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color.fromARGB(255, 204, 201, 201),
                        )),
                        hintText: "MM/YY",
                        filled: true,
                        fillColor: Color.fromRGBO(251, 251, 251, 1),
                      ),
                    ),
                  )
                ],
              ),
              Spacer(),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Material(
                  color: Color.fromRGBO(238, 167, 52, 1),
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  child: MaterialButton(
                    onPressed: () async {
                      await makePayment();
                      // for (var i = 0;
                      //     i < sideItems.length;
                      //     i++)

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConfirmYourOrders(
                                    itemsss: widget.itemsss,
                                    totalItems: widget.totalItems,
                                    userCardExpiryDate: cvcController.text,
                                    userCardNumber: cardNumberController.text,
                                  )));
                    },
                    minWidth: 330.0,
                    height: 10.0,
                    child: Text('CHECKOUT(${widget.totalItems.totalPrice})',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                  ),
                )
              ]),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                width: 330,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    side: const BorderSide(
                        width: 2, color: Color.fromARGB(255, 204, 201, 201)),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ScanCard()));
                  },
                  icon: Icon(
                    Icons.credit_card,
                    color: Colors.black,
                    size: 24.0,
                  ),
                  label: Text(
                    'SCAN CARD',
                    style: TextStyle(color: Colors.grey, fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != newText.length) {
        buffer.write('  ');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

class CardMonthInputDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
