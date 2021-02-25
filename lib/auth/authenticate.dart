import 'package:broadcastr_ui/auth/register.dart';
import 'package:broadcastr_ui/main.dart';
import 'package:broadcastr_ui/screens/phone_register.dart';
import 'package:broadcastr_ui/screens/sign_in_page.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
   
   bool showSignIn = true;
  void toggleView(){
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }
  
  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return MyNavigationBar();
    } else {
      return Register(toggleView:  toggleView);
    }
  }
}