import 'package:flutter/material.dart';
import 'package:food_service/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../StateManagement.dart';
import 'SignIn.dart';

class ResetEmail extends ConsumerStatefulWidget {
  const ResetEmail({super.key,required this.email});
final String email;
  @override
  ConsumerState<ResetEmail> createState() => _ResetEmailState();
}

class _ResetEmailState extends ConsumerState<ResetEmail> {
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
                context, MaterialPageRoute(builder: (context) => SignIn()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Forgot Password",
          style: TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: ListView(
          children: [
            Text('Reset email sent',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color.fromRGBO(17, 30, 23, 1),
                  fontSize: 33.0,
                )),
            SizedBox(
              height: 15,
            ),
            Text(
                'We have sent a instructions email to\nyour email.   Having problem?',
                style: TextStyle(
                    fontSize: 17.0, color: Color.fromRGBO(164, 164, 164, 1))),
            SizedBox(
              height: 30,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Material(
                color: Color.fromRGBO(238, 167, 52, 1),
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                child: MaterialButton(
                  onPressed: () async {
                    await ref.read(logicalScreen.notifier).againResetPassword(widget.email)
                        .then((value) => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignIn())));
                  },
                  minWidth: 330.0,
                  height: 13.0,
                  child: Text('SEND AGAIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      )),
                ),
              )
            ]),
            SizedBox(
              height: 130,
            ),
            Center(
                child: Container(
              child: Image.asset(
                "assets/images/OpenDoodles.png",
                height: 250,
                fit: BoxFit.cover,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
