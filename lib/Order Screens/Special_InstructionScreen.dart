// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:food_service/Order%20Screens/AddToOrder.dart';
import 'package:food_service/Order%20Screens/PreviousOrders.dart';
import 'package:food_service/featuredItems.dart';

final specialInstruction = TextEditingController();
String specialInstructions = '';

class SpecialInstructions extends StatefulWidget {
  SpecialInstructions({super.key, required this.itemsss});
  Menu itemsss;
  @override
  State<SpecialInstructions> createState() => _SpecialInstructionsState();
}

class _SpecialInstructionsState extends State<SpecialInstructions> {
  updateSpecialInstructions(Menu itemsss) {
    specialInstructions = specialInstruction.text;
    itemsss.specialInstructions == specialInstructions;
    setState(() {
      specialInstructions = specialInstruction.text;
      itemsss.specialInstructions = specialInstructions;
    });
    print("Special Instruction${itemsss.specialInstructions}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: Text(
          "Add Special Instruction",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddToOrder(
                          itemsss: items,
                        )));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: ListView(
            children: [
              Text("You can add special instruction with\nyour order!!!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600)),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                maxLines: 5,
                controller: specialInstruction,
                decoration: InputDecoration(
                  labelText: "Special Instruction",
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Material(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  child: MaterialButton(
                    onPressed: () async {
                      updateSpecialInstructions(widget.itemsss);
                      Navigator.pop(context);
                    },
                    minWidth: 230.0,
                    height: 13.0,
                    child: Text('Add Special Instruction',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        )),
                  ),
                )
              ]),
            ],
          )),
    );
  }
}
