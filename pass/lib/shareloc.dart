import 'package:flutter/material.dart';
//import 'package:location/location.dart';
//import 'package:firebase_database/firebase_database.dart';

import 'tracloc.dart';
import 'package:pass/geolocation/listen_location.dart';
import 'package:pass/geolocation/permission.dart';
import 'package:pass/geolocation/service_enabled.dart';


/*final DatabaseReference database = FirebaseDatabase.instance.reference().child("test"); 
  
  sendData(){
    database.push().set({
      'pin' : '1234',
      'location' :  'Longitude',

    });
  }*/
class ShareLoc extends StatefulWidget {
  
  @override
  ShareLocation createState() {
    return ShareLocation();
  }
}

class ShareLocation extends State {
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
   // sendData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Track Location',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('Generated Pin'),
        ),
        body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            PermissionStatusWidget(),
            Divider(
              height: 32,
            ),
            ServiceEnabledWidget(),
            Divider(
              height: 32,
            ),
           // GetLocationWidget(),
            //Divider(
             // height: 32,
            //),
            ListenLocationWidget(),
            Divider(
              height: 32,
            ),
            Text("PIN : $pin",style: TextStyle(fontSize:50),),
            Icon(Icons.location_on)
          ],
          
        ),
    ),
      ),
    );
  }
}