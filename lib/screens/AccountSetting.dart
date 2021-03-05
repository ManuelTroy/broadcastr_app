import 'package:broadcastr_ui/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../NavigatorBar.dart';

class AccountSetting extends StatefulWidget {
  DocumentSnapshot _snapshot;
  AccountSetting(this._snapshot);
  @override
  _AccountSettingState createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  SharedPreferences preferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInstance();
  }

  getInstance() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("AccountSetting"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[300],
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 100,
              child: Center(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget._snapshot.data()["image"]),
                    maxRadius: 35.0,
                  ),
                  title: Text(widget._snapshot.data()["name"],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  subtitle: Text("change profile info and photo"),
                  trailing: InkWell(
                    onTap: () {},
                    child: Icon(Icons.arrow_forward_ios, size: 15.0),
                  ),
                  tileColor: Colors.white,
                ),
              ),
            ),
            heading("Language"),
            ListTile(
              tileColor: Colors.white,
              title: Text("Language Preference",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              subtitle: Text("choose your preferred language for content"),
              trailing: InkWell(
                onTap: () {},
                child: Icon(Icons.arrow_forward_ios, size: 15.0),
              ),
            ),
            heading("Linked accounts"),
            ListTile(
              tileColor: Colors.white,
              title: Text("Integration",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              subtitle: Text("Connect your Gmail account with Phone Number"),
              trailing: InkWell(
                onTap: () {},
                child: Icon(Icons.arrow_forward_ios, size: 15.0),
              ),
            ),
            heading("Join Community"),
            ListTile(
              tileColor: Colors.white,
              title: Text("Join BroadcastR Facebook group",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              subtitle: Text("Be a part of the BroadcastR facebook group"),
              trailing: InkWell(
                onTap: () {},
                child: Icon(Icons.arrow_forward_ios, size: 15.0),
              ),
            ),
            Spacer(),
            ListTile(
              tileColor: Colors.white,
              title: Text("Log Out of BroadcastR",
                  style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
              trailing: InkWell(
                onTap: () async {
                  AuthService().signOut();
                  preferences.clear();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => MyNavigationBar(index: 4)));
                },
                child: Icon(Icons.logout, color: Colors.orange, size: 25.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  heading(text) {
    return Padding(
      padding: const EdgeInsets.all(8.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
