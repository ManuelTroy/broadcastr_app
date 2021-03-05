import 'package:broadcastr_ui/homescreen.dart';
import 'package:broadcastr_ui/screens/inbox_page.dart';
import 'package:broadcastr_ui/screens/profile_page.dart';
import 'package:broadcastr_ui/screens/search_page.dart';
import 'package:broadcastr_ui/tik_tok_icons_icons.dart';
import 'package:flutter/material.dart';

class MyNavigationBar extends StatefulWidget {
  int index;
  MyNavigationBar({this.index});
  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _currentIndex = 0;
  final tabs = [
    HomeScreen(),
    SearchPage(),
    Center(child: Text('Create')),
    InboxPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              TikTokIcons.home,
              size: 20.0,
            ),
            title: Text('Home'),
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
              icon: Icon(
                TikTokIcons.search,
                size: 20.0,
              ),
              title: Text('Search')),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.stream,
                size: 30.0,
              ),
              title: Text('Create')),
          BottomNavigationBarItem(
              icon: Icon(
                TikTokIcons.messages,
                size: 20.0,
              ),
              title: Text('inbox')),
          BottomNavigationBarItem(
            icon: Icon(
              TikTokIcons.profile,
              size: 20.0,
            ),
            title: Text('Me'),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
