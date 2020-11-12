import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:kosso_chat/widgets/variables.dart';
import 'package:uuid/uuid.dart';

class CreatMeeting extends StatefulWidget {
  @override
  _CreatMeetingState createState() => _CreatMeetingState();
}

class _CreatMeetingState extends State<CreatMeeting> {
  String code = '';

  createCode() {
    setState(() {
      code = Uuid().v1().substring(0, 5);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Generez un code puis partager-le avec vos correspondants!",
                style: mystyle(20),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Code: ",
                style: mystyle(30),
              ),
              Text(
                code,
                style: mystyle(32, Colors.purple, FontWeight.w800),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () => createCode(),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: GradientColors.facebookMessenger)),
              child: Center(
                child: Text(
                  "Generer code",
                  style: mystyle(17, Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
