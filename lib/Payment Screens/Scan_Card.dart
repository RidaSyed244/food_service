import 'package:easy_card_scanner/credit_card_scanner.dart';
import 'package:flutter/material.dart';


class ScanCard extends StatefulWidget {
  const ScanCard({
    super.key,
  });

  @override
  State<ScanCard> createState() => _ScanCardState();
}

class _ScanCardState extends State<ScanCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 180, 20, 0),
            child: Center(
              child: Text(
                "Scan Your Card :)",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Just my luck, no ice. Must go faster. Did he just\nthrow my cat out of the window",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Material(
                color: Colors.orange,
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                child: MaterialButton(
                  onPressed: () async {
                    await CardScanner.scanCard(
                            scanOptions:
                                CardScanOptions(scanCardHolderName: true));
                        // .then((context) => Navigator.push(
                        //     context as BuildContext,
                        //     MaterialPageRoute(
                        //         builder: (context) => PreviousOrders())));
                  },
                  minWidth: 330.0,
                  height: 10.0,
                  child: Text('SCAN YOUR CARD',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                ),
              )
            ]),
          )
        ],
      ),
    ));
  }
}
