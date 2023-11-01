// // import 'package:flutter/material.dart';

// // class faqTest extends StatefulWidget {
// //   const faqTest({Key? key}) : super(key: key);

// //   @override
// //   State<faqTest> createState() => _faqTestState();
// // }

// // class _faqTestState extends State<faqTest> {
// //   List<FAQItem> faqs = [
// //     FAQItem(
// //       question: "Question 1",
// //       answer: "Answer to Question 1",
// //     ),
// //     FAQItem(
// //       question: "Question 2",
// //       answer: "Answer to Question 2",
// //     ),
// //     FAQItem(
// //       question: "Question 3",
// //       answer: "Answer to Question 3",
// //     ),
// //     FAQItem(
// //       question: "Question 4",
// //       answer: "Answer to Question 4",
// //     ),
// //   ];

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("FAQs"),
// //       ),
// //       body: ListView.builder(
// //         itemCount: faqs.length,
// //         itemBuilder: (context, index) {
// //           return FAQTile(
// //             question: faqs[index].question,
// //             answer: faqs[index].answer,
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// // class FAQItem {
// //   final String question;
// //   final String answer;

// //   FAQItem({
// //     required this.question,
// //     required this.answer,
// //   });
// // }

// // class FAQTile extends StatefulWidget {
// //   final String question;
// //   final String answer;

// //   FAQTile({
// //     required this.question,
// //     required this.answer,
// //   });

// //   @override
// //   _FAQTileState createState() => _FAQTileState();
// // }

// // class _FAQTileState extends State<FAQTile> {
// //   bool isExpanded = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       margin: EdgeInsets.all(16.0),
// //       child: InkWell(
// //         onTap: () {
// //           setState(() {
// //             isExpanded = !isExpanded;
// //           });
// //         },
// //         child: Column(
// //           children: [
// //             ListTile(
// //               title: Text(widget.question),
// //               trailing: isExpanded ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
// //             ),
// //             if (isExpanded)
// //               Padding(
// //                 padding: EdgeInsets.all(16.0),
// //                 child: Text(widget.answer),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// ListView(
//         children: [
//           SizedBox(
//             height: 20.0,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 200.0),
//             child: Container(
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Colors.orange,
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.zero,
//                     topRight: Radius.circular(
//                       10.0,
//                     ), // Circular border on top-left
//                     bottomLeft: Radius.zero,
//                     bottomRight:
//                         Radius.circular(10.0) // Circular border on top-left

//                     ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.orange,
//                   ),
//                 ],
//               ),
//               child: Center(
//                   child: Text(
//                 "Sign up for online ordering",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     fontSize: 17.0,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white),
//               )),
//             ),
//           ),
//           SizedBox(
//             height: 20.0,
//           ),


