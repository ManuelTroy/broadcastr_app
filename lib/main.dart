import 'package:broadcastr_ui/models/user.dart';
import 'package:broadcastr_ui/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'NavigatorBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override

  // main.dart text theme update
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'BroadCaster_App',
        theme: ThemeData(
            // Uncomment in phase 3 to apply white to text
            textTheme:
                Theme.of(context).textTheme.apply(bodyColor: Colors.black),
            primaryColor: Colors.black,
            accentColor: Color(0xFFD8ECF1)),
        debugShowCheckedModeBanner: false,
        home: MyNavigationBar(),
      ),
    );
  }
}
