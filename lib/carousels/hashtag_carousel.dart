import 'package:broadcastr_ui/models/hashtag_model.dart';
import 'package:flutter/material.dart';
import 'package:broadcastr_ui/homescreen.dart';


class HashTagCarousel extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
          children: <Widget> [
           Row (
             children: [
              Container (
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                 alignment: Alignment.center,
                 decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black)),
                 child: 
               Icon(Icons.tag)
               ),
               Text('Trending HashTags', 
               style: TextStyle(fontSize: 20.0, 
               fontWeight: FontWeight.bold),
               ),

               Padding(
                 padding: EdgeInsets.only(left:50),
                 child: ElevatedButton(
                 child: Text('More >',style: TextStyle(fontSize: 10.0, 
               fontWeight: FontWeight.bold),),
                  onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()
                  ));
                      })
                    ),
          ]
        ),
          Padding ( 
            padding: EdgeInsets.all(10),
            child: Container(
              height: 200.0, 
              color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: hashtags.length,
                itemBuilder: (BuildContext context, int index) 
                {
                  HashTag hashtag = hashtags[index];
                  return Container(
                 margin: EdgeInsets.all(5.0),
                   width: 150.0,
                   height: 120.0,
                   color: Colors.red,
                   child: Stack (
                     children: <Widget> [
                     Image(
                       height: 220.0,
                       width: 300.0,
                       image: AssetImage(hashtag.imageURL),
                       fit: BoxFit.fill
                     )
                     ]
                  ));
                }
               
                ),) 
              
              
              )     

      ],
      );
  }
}