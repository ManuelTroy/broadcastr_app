import 'package:broadcastr_ui/screens/search_page.dart';
import 'package:flutter/material.dart';
import '../homescreen.dart';


class DiscoverPage extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    
    return MaterialApp(  
       debugShowCheckedModeBanner: false,
      home: DefaultTabController(  
        length: 2,  
        child: Scaffold(  
          appBar: AppBar(  
            bottom: TabBar(  
              tabs: [  
                Tab(icon: Icon(Icons.contacts), text: "Tab 1"),  
                Tab(icon: Icon(Icons.camera_alt), text: "Tab 2")  
              ],  
            ),  
          ),  
          body: TabBarView(  
            children: [  
              SearchPage(),  
              HomeScreen(),  
            ],  
          ),  
        ),  
      ),  
    );  
  }  
}  