import 'package:flutter/material.dart';
import 'package:kosso_chat/screens/profilescreen.dart';
import 'package:kosso_chat/screens/videoconferencescreen.dart';
import 'package:kosso_chat/widgets/variables.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 0;
  List pageOptions = [VideoConferenceScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[250],
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.greenAccent.shade100,
            selectedItemColor: Colors.green,
            selectedLabelStyle: mystyle(17, Colors.green),
            unselectedItemColor: Colors.black,
            unselectedLabelStyle: mystyle(17, Colors.black),
            currentIndex: page,
            onTap: (index) {
              setState(() {
                page = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  label: "Appel video",
                  icon: Icon(
                    Icons.video_call,
                    size: 32,
                  )),
              BottomNavigationBarItem(
                  label: "Profile",
                  icon: Icon(
                    Icons.person,
                    size: 32,
                  )),
            ]),
        body: pageOptions[page]);
  }
}
