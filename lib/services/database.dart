import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
   
   final String uid;
   DatabaseService ({this.uid});

  //collection reference

  final CollectionReference creatorData = Firestore.instance.collection('creators');

 Future updateUserData(String videos, String name, int followers) async {
   return  await creatorData.document(uid).setData({
     'videos': videos,
     'name': name,
     'followers': followers,
     

   });

 }

}