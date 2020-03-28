import 'package:flutter/material.dart';
import 'package:pass/shareloc.dart';
import 'tracloc.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
    home:Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading:IconButton(icon: Icon(Icons.location_searching),onPressed:(){

        } ,),
        title: Text('MainScreen'),
      ),
      body: Center(
        child: Column( 
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Container(
                child:RaisedButton(
          child: Text('Share Location'), 
          color: Colors.amber,
          onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>ShareLoc()));
          },
        ),
        margin: EdgeInsets.fromLTRB(50, 220, 50, 20)
        ),
         Container(
                child: RaisedButton(
          child: Text('Track Location'), 
          color: Colors.amber,
          onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>TrackLoc()));
            
          },
        ),
        margin: EdgeInsets.fromLTRB(50, 10, 50, 100),
        ),
          ]
        ),
        ),
    ),
    );
  }
}