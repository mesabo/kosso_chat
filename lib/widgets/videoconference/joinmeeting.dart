import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:kosso_chat/widgets/variables.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class JoinMeeting extends StatefulWidget {
  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController subjectcontroller = TextEditingController();
  TextEditingController roomcontroller = TextEditingController();
  String username = '';
  String email = '';
  String subjet = '';
  bool videoMuet = true;
  bool audioMuet = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  getUserData() async {
    DocumentSnapshot userdoc =
        await usercollection.doc(FirebaseAuth.instance.currentUser.uid).get();
    setState(() {
      username = userdoc.data()['username'];
      email = userdoc.data()['email'];
      subjet =
          subjet == '' ? userdoc.data()['username'] : subjectcontroller.text;
    });
  }

// parametres durant la conference
  joinmeeting() async {
    try {
      Map<FeatureFlagEnum, bool> featurellags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false
      };

      if (Platform.isAndroid) {
        featurellags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        featurellags[FeatureFlagEnum.PIP_ENABLED] = false;
      }
      var options = JitsiMeetingOptions()
        ..room = roomcontroller.text
        ..userDisplayName =
            namecontroller == '' ? namecontroller : namecontroller.text
        ..userEmail = email
        ..audioMuted = audioMuet
        ..videoMuted = videoMuet
        ..subject = subjet
        ..featureFlags.addAll(featurellags);

      await JitsiMeet.joinMeeting(options);
    } catch (e) {
      print("ERREUR: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text("Code de la conference"),
            PinCodeTextField(
                controller: roomcontroller,
                autoDisposeControllers: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(shape: PinCodeFieldShape.underline),
                animationDuration: Duration(microseconds: 300),
                appContext: context,
                length: 5,
                onChanged: (value) {}),
            SizedBox(
              height: 10,
            ),
            Text("Nom de la conference"),
            TextField(
              controller: subjectcontroller,
              style: mystyle(20),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "ex: Cours de Markov",
                  labelStyle: mystyle(15)),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Votre nom"),
            TextField(
              controller: namecontroller,
              style: mystyle(20),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Username (optionnel)",
                  labelStyle: mystyle(15)),
            ),
            SizedBox(
              height: 20,
            ),
            CheckboxListTile(
              value: videoMuet,
              onChanged: (value) {
                setState(() {
                  videoMuet = value;
                });
              },
              title: Text(
                "Video muette",
                style: mystyle(18, Colors.black),
              ),
            ),
            CheckboxListTile(
              value: audioMuet,
              onChanged: (value) {
                setState(() {
                  audioMuet = value;
                });
              },
              title: Text(
                "Audio muet",
                style: mystyle(18, Colors.black),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              "Vous pouvez les modifier plutard, pendant la conference",
              style: mystyle(15, Colors.black),
            )),
            Divider(
              height: 48,
              thickness: 2.0,
            ),
            InkWell(
              onTap: () => joinmeeting(),
              child: Container(
                height: 64,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: GradientColors.facebookMessenger)),
                child: Center(
                  child: Text(
                    "Rejoindre conference",
                    style: mystyle(17, Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
