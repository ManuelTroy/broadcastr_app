import 'package:broadcastr_ui/services/auth.dart';
import 'package:broadcastr_ui/widgets/action_toolbar.dart';
import 'package:broadcastr_ui/widgets/get_follow_icon.dart';
import 'package:broadcastr_ui/widgets/video_description.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, this.user}) : super(key: key);
  final FirebaseUser user;
  

 @override
  _HomeScreenState createState() => _HomeScreenState();


}
  

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _auth = AuthService();

  @override

 // Top section
     Widget get topSection =>   Container(
          height: 100.0,
          padding: EdgeInsets.only(bottom: 15.0),
            alignment: Alignment(0.0, 1.0),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('My Feed',  style: TextStyle(
                         color: Colors.black)),
                Container(
                  width: 15.0,
                ),
                Text('tdf',
                    style: TextStyle(
                        fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.black)),
                        
              ]),
        );


       // Middle expanded
        Widget get middleSection =>  Expanded(
        child: Stack(
                  children:<Widget>[ 
            Positioned(
              top: 280,
              left: 300,
              child: ActionsToolbar(),
            ),

          VideoDescription(),
           FollowIcon(),
          ]
        ));

  Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: <Widget>[
       
     topSection,
     middleSection
       
       
      ],
    ),
  );
}
}