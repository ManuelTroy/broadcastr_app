import 'package:broadcastr_ui/screens/phone_register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../tik_tok_icons_icons.dart';

class InboxPage extends StatefulWidget {
  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  bool checkUser = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(left: 110.0),
            child: Text('All Activity',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
          ),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: !checkUser
              ? Padding(
                  padding: EdgeInsets.only(top: 160.0, left: 35.0),
                  child: Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Icon(TikTokIcons.messages, size: 80.0),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child:
                          Text('Messages and notifications will appear here'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: RaisedButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PhoneRegister()),
                          )
                        },
                        child: new Text('Sign Up'),
                      ),
                    ),
                  ]),
                )
              : Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Text("User exist"),
                  ),
                ),
        ));
  }

  void getUserInfo() async {
    var preferences = await SharedPreferences.getInstance();
    var a = preferences.getBool("User");
    if (a == null) {
      checkUser = false;
    } else {
      checkUser = true;
    }
    setState(() {});
  }
}
