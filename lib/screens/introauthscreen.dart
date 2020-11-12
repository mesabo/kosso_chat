import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:kosso_chat/screens/navigateauthscreen.dart';
import 'package:kosso_chat/widgets/variables.dart';

class IntroAuthScreen extends StatefulWidget {
  @override
  _IntroAuthScreenState createState() => _IntroAuthScreenState();
}

class _IntroAuthScreenState extends State<IntroAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        // WELCOME
        PageViewModel(
            title: "ESATIC COURS EN LIGNE",
            body:
                "Bienvenu sur kosso chat, la plateforme de cours en ligne de l'ESATIC",
            image: Center(
              child: Image.asset("assets/welcome.jpg", height: 175),
            ),
            decoration: PageDecoration(
              bodyTextStyle: mystyle(20, Colors.black),
              titleTextStyle: mystyle(20, Colors.black),
            )),
        PageViewModel(
            title: "REJOINDRE UNE CONFERENCE",
            body: "Facile d'acces et pratique",
            image: Center(
              child: Image.asset("assets/calling.jpg", height: 175),
            ),
            // JOIN NOW
            decoration: PageDecoration(
              bodyTextStyle: mystyle(20, Colors.black),
              titleTextStyle: mystyle(20, Colors.black),
            )),
        PageViewModel(
            title: "SECURITE",
            body: "Votre securite est garantie.",
            image: Center(
              child: Image.asset("assets/welcome.jpg", height: 175),
            ),
            decoration: PageDecoration(
              bodyTextStyle: mystyle(20, Colors.black),
              titleTextStyle: mystyle(20, Colors.black),
            )),
      ],
      onDone: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NavigateAuthScreen(),
            ));
      },
      onSkip: () {
        //todo
      },
      showSkipButton: true,
      skip: const Icon(
        Icons.skip_next,
        size: 45,
      ),
      next: const Icon(
        Icons.arrow_forward,
        size: 45,
      ),
      done: Text(
        "Passer",
        style: mystyle(20, Colors.black),
      ),
    );
  }
}
