import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:kosso_chat/widgets/variables.dart';
import 'package:kosso_chat/widgets/videoconference/createmeeting.dart';
import 'package:kosso_chat/widgets/videoconference/joinmeeting.dart';

class VideoConferenceScreen extends StatefulWidget {
  @override
  _VideoConferenceScreenState createState() => _VideoConferenceScreenState();
}

class _VideoConferenceScreenState extends State<VideoConferenceScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  buildTab(String name, Color color) => Container(
        width: 150,
        height: 50,
        child: Card(
          color: color,
          child: Center(
            child: Text(
              name,
              style: mystyle(15, Colors.white, FontWeight.w700),
            ),
          ),
        ),
      );

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conference video",
            style: mystyle(
              22,
              Colors.white,
            )),
        elevation: 0.0,
        bottom: TabBar(
          controller: tabController,
          tabs: [
            buildTab('Joindre', Colors.lightGreen),
            buildTab('Creer conference', Colors.lightBlue),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: GradientColors.beautifulGreen),
          ),
        ),
        centerTitle: true,
      ),
      body: TabBarView(
        children: [JoinMeeting(), CreatMeeting()],
        controller: tabController,
      ),
    );
  }
}
