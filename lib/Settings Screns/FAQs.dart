import 'package:flutter/material.dart';
import 'package:food_service/Settings%20Screns/Account_Settings.dart';

class FAQItem {
  final String title;
  final List<QuestionAnswer> questions;

  FAQItem({
    required this.title,
    required this.questions,
  });
}

class QuestionAnswer {
  final String question;
  final String answer;

  QuestionAnswer({
    required this.question,
    required this.answer,
  });
}

class FAQs extends StatefulWidget {
  const FAQs({super.key});

  @override
  State<FAQs> createState() => _FAQsState();
}

class _FAQsState extends State<FAQs> {
  List<FAQItem> faqs = [
    FAQItem(
      title: "Sign Up for Online Ordering",
      questions: [
        QuestionAnswer(
          question: "How can I create an account to order food online?",
          answer:
              "To create an account for online food ordering, follow these steps:\n1. Download our mobile app or visit our website.\n2. Click on the 'Sign Up' or 'Create an Account' option.\n3. Provide your name, email address, and phone number.\n4. Set a secure password for your account.\n5. You can now start browsing restaurants and placing orders online.",
        ),
        QuestionAnswer(
          question: "What payment methods are accepted for online orders?",
          answer:
              "We accept various payment methods, including credit cards, debit cards, mobile wallets, and online payment platforms. You can securely pay for your food orders using your preferred payment method during the checkout process.",
        ),
        QuestionAnswer(
          question: "How can I track my order's status and location?",
          answer:
              "Once you place an order, you can track its status in real-time. You'll receive updates on the order's preparation, pickup by the driver, and estimated delivery time. Additionally, you can track the location of the restaurant preparing your food and the driver delivering your order on a live map.",
        ),
        QuestionAnswer(
          question: "Is there a minimum order amount for online food delivery?",
          answer:
              "The minimum order amount may vary depending on the restaurant you choose. Some restaurants may have a minimum order requirement for delivery, while others may not. You can check the specific restaurant's details and requirements when placing your order.",
        ),
      ],
    ),

    FAQItem(
      title: "Order Management",
      questions: [
        QuestionAnswer(
          question: "How can I track the status of my current order?",
          answer:
              "To track the status of your current order, go to the 'Orders' or 'Fresh Order' section in the app. You'll find real-time updates on your order's pickup, and estimated delivery time. You can also track the location of the driver delivering your order on a live map.",
        ),
        QuestionAnswer(
          question: "How can I leave special instructions for my order?",
          answer:
              "During the checkout process, you can provide special instructions or requests for your order. For example, you can specify dietary preferences, allergies, or delivery instructions. These instructions will be communicated to the restaurant and driver to ensure your order is prepared and delivered as requested.",
        ),
        QuestionAnswer(
          question: "What should I do if there is an issue with my order?",
          answer:
              "If you encounter any issues with your order, such as missing items, incorrect items, or quality concerns, please contact our customer support immediately. We are here to assist you and ensure you have a satisfying dining experience.",
        ),
      ],
    ),

    FAQItem(
      title: "Profile",
      questions: [
        QuestionAnswer(
          question: "How do I create a user profile?",
          answer:
              "To create a user profile, follow these steps:\n1. Download our mobile app or visit our website.\n2. Click on the 'Sign Up' or 'Create an Account' option.\n3. Provide your name, email address, and phone number.\n4. Set a secure password for your account.\n5. Fill in additional profile information if required.\n6. Your user profile is now created and ready to use.",
        ),
        QuestionAnswer(
          question: "How can I update my profile information?",
          answer:
              "To update your profile information, follow these steps:\n1. Log in to your account.\n2. Go to your profile settings.\n3. Edit the information you want to change, such as your name, email, or phone number.\n4. Save the changes.\n5. Your profile information is now updated.",
        ),
        QuestionAnswer(
          question: "Can I change my delivery address in my profile?",
          answer:
              "Yes, you can change your delivery address in your profile settings. Simply go to your profile, select 'Account Settings' and update your address details as needed. Ensure that your new address is accurate for a seamless food delivery experience.",
        ),
        QuestionAnswer(
          question: "How can I view my order history on my profile?",
          answer:
              "To view your order history, log in to your account and go to your profile. You should find an 'Order History' or 'Past Orders' section where you can access details of your past orders, including order dates, restaurant names, and order amounts.",
        ),
      ],
    ),

    // Add more FAQItem objects as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.orange,
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AccountSettings()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "FAQs",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final FAQItem faqItem = faqs[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 200.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.zero,
                        topRight: Radius.circular(
                          10.0,
                        ), // Circular border on top-left
                        bottomLeft: Radius.zero,
                        bottomRight:
                            Radius.circular(10.0) // Circular border on top-left

                        ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange,
                      ),
                    ],
                  ),
                  child: Center(
                      child: Text(
                    "${faqItem.title}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  )),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: faqItem.questions.length,
                itemBuilder: (context, subIndex) {
                  final QuestionAnswer qa = faqItem.questions[subIndex];
                  return FAQTile(
                    question: qa.question,
                    answer: qa.answer,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class FAQTile extends StatefulWidget {
  final String question;
  final String answer;

  FAQTile({
    required this.question,
    required this.answer,
  });

  @override
  _FAQTileState createState() => _FAQTileState();
}

class _FAQTileState extends State<FAQTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: Column(
          children: [
            ListTile(
              title: Text(widget.question),
              trailing: isExpanded
                  ? Icon(Icons.expand_less)
                  : Icon(Icons.expand_more),
            ),
            if (isExpanded)
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(widget.answer),
              ),
          ],
        ),
      ),
    );
  }
}
