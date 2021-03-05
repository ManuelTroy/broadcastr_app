import 'package:broadcastr_ui/screens/phone_register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../tik_tok_icons_icons.dart';
import 'ProfilePageTest.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool checkUser = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return !checkUser
        ? Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: EdgeInsets.only(left: 130.0),
                child: Text('Profile',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
              ),
              backgroundColor: Colors.white,
            ),
            body: SafeArea(
                child: Padding(
              padding: EdgeInsets.only(top: 100.0, left: 100.0),
              child: Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(TikTokIcons.profile, size: 100.0),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Sign Up for an Account'),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PhoneRegister(false)),
                      )
                    },
                    child: new Text('Sign Up'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PhoneRegister(true)),
                      )
                    },
                    child: new Text('SignIn'),
                  ),
                ),
              ]),
            )))
        : ProfileOkPage();
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
