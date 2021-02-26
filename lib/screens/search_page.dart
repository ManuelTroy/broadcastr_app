
import 'package:broadcastr_ui/carousels/hashtag_carousel.dart';
import 'package:broadcastr_ui/carousels/sound_carousel.dart';
import 'package:broadcastr_ui/carousels/video_carousel.dart';
import 'package:broadcastr_ui/screens/search_result.dart';
import 'package:flutter/material.dart';
import 'package:broadcastr_ui/carousels/user_carousel.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
     return MaterialApp(  
       debugShowCheckedModeBanner: false,
      home: DefaultTabController(  
        length: 4,  
        child: Scaffold(
          appBar: AppBar (
      backgroundColor: Colors.red[300],
      title: Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
      decoration: BoxDecoration(
       color: Color.fromARGB(50, 255, 255, 255),
        borderRadius: BorderRadius.all(Radius.circular(22.0)),
                ),
             
                    child: Row (
                crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
                       Expanded(
                     flex: 1,
                       child: Container (
                       padding: EdgeInsets.symmetric(horizontal: 8.0),
                   child: 
                  IconButton(icon: Icon(Icons.search, color: Colors.white), 
                  onPressed: () {
               Navigator.push(
                  context,
                MaterialPageRoute(builder: (context) => SearchResult()),
                  );
                            }),

                
                     
                         ),
                         ),

                         SizedBox(width:40.0),

                        Expanded(child:  TextFormField(
                  decoration: InputDecoration(
                 border: InputBorder.none,
                  hintText: "Search",
                    hintStyle: TextStyle(color: Colors.white ),
                  
                     ),
                        ),),
                      
                     SizedBox(width:35.0),

                   Expanded (
                   flex: 0,
                child: Container(
                     padding: EdgeInsets.symmetric(horizontal: 5.0),
                   child: Row(
                     children: <Widget>[
                     IconButton(
                 onPressed: () {},
                    icon: Icon(Icons.more_vert, color: Colors.white),
         ),
         ],
      ),
    ),
   ),

             ]

      ),
 ),
                    
     ),
 body: SafeArea(
        child: ListView(
        children: <Widget>[
          SizedBox(height:10.0),
          HashTagCarousel(),
        SizedBox(height:10.0),
          UserCarousel(),
          SizedBox(height:10.0),
          VideoCarousel(),
          SizedBox(height:10.0),
          SoundCarousel()
        ]
      ),
    ),
        )

     )
        
     );
  }
}
  
     
   

 

  

 



