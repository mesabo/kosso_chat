import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:kosso_chat/screens/loginscreen.dart';
import 'package:kosso_chat/widgets/variables.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[250],
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: GradientColors.green)),
            child: Center(
              child: Image.asset(
                "assets/logo.jpg",
                height: 150,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.6,
              margin: EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.5),
                      spreadRadius: .5,
                      blurRadius: .5,
                      offset: const Offset(0, 3),
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: TextField(
                      controller: usernamecontroller,
                      style: mystyle(18, Colors.black),
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          hintText: "Username",
                          prefixIcon: Icon(Icons.person),
                          hintStyle:
                              mystyle(20, Colors.purple, FontWeight.w700)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: TextField(
                      controller: emailcontroller,
                      style: mystyle(18, Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Votre e-mail",
                          prefixIcon: Icon(Icons.email),
                          hintStyle:
                              mystyle(20, Colors.purple, FontWeight.w700)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: TextField(
                      controller: passwordcontroller,
                      style: mystyle(18, Colors.black),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Mot de passe",
                          prefixIcon: Icon(Icons.lock),
                          hintStyle:
                              mystyle(20, Colors.purple, FontWeight.w700)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      try {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailcontroller.text,
                                password: passwordcontroller.text)
                            .then((signedUser) {
                          usercollection.doc(signedUser.user.uid).set({
                            'username': usernamecontroller.text,
                            'email': usernamecontroller.text,
                            'password': usernamecontroller.text,
                            'uid': signedUser.user.uid,
                          });
                        });
                      } catch (e) {
                        print(e);
                        var snackbar = SnackBar(
                            content: Text(
                          e.toString(),
                          style: mystyle(18, Colors.black),
                        ));
                        Scaffold.of(context).showSnackBar(snackbar);
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 60,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: GradientColors.facebookMessenger),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "ENREGISTRER",
                          style: mystyle(25, Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text(
                      "se connecter",
                      style: mystyle(14, Colors.grey.shade500),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
