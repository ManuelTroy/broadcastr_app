import 'package:broadcastr_ui/auth/authenticate.dart';
import 'package:broadcastr_ui/models/user.dart';
import 'package:broadcastr_ui/screens/phone_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print (user);


    // return either Home or Authenticate Widget
    if (user == null) {
     return Authenticate();
    }
    else {
      return MyNavigationBar();
    }
    
  }
}