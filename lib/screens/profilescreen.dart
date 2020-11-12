import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:kosso_chat/widgets/variables.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = '';
  bool dataisthere = false;
  TextEditingController usernamecontroller = TextEditingController();

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
      dataisthere = true;
    });
  }

  editProfile() async {
    usercollection
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({'username': usernamecontroller.text});
    setState(() {
      username = usernamecontroller.text;
    });
    Navigator.pop(context);
  }

  openEditProfileDialog() async {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          height: 200,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: usernamecontroller,
                  style: mystyle(18, Colors.black),
                  decoration: InputDecoration(
                      labelText: "Mettre a jour profile",
                      labelStyle: mystyle(16, Colors.grey)),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () => editProfile(),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                          colors: GradientColors.facebookMessenger)),
                  child: Center(
                    child: Text(
                      'Terminer',
                      style: mystyle(18, Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: dataisthere == false
          ? Center(
              child:
                  CircularProgressIndicator(backgroundColor: Colors.lightBlue))
          : Stack(
              children: [
                ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2.5,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: GradientColors.beautifulGreen)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 2 - 64,
                      top: MediaQuery.of(context).size.height / 3.1),
                  child: CircleAvatar(
                    radius: 64,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 300,
                      ),
                      Text(
                        username,
                        style: mystyle(40, Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () => openEditProfileDialog(),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                  colors: GradientColors.sunrise)),
                          child: Center(
                            child: Text(
                              'Editer profile',
                              style: mystyle(18, Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
