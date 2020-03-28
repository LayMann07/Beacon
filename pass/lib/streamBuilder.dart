import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class SB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tracking Location',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}


class _HomePageState extends State<HomePage> {
  StreamSubscription _subscriptionLat,_subscriptionLon;

  double _latitude = 0.0;
  double _longitude = 0.0;

  @override
  void initState() {

    FirebaseLat.getTodoStream("latitude",_updateLat)
        .then((StreamSubscription s) => _subscriptionLat = s);
    super.initState();
    FirebaseLon.getTodoStream("longitude",_updateLon)
        .then((StreamSubscription s) => _subscriptionLon = s);
    super.initState();
  }

  @override
  void dispose() {
    if (_subscriptionLat != null) {
      _subscriptionLat.cancel();
    }
    super.dispose();
    if (_subscriptionLon != null) {
      _subscriptionLon.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var itemTile = new ListTile(
      title:  Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[ 
            new Text("Latitude: $_latitude \nLongitude: $_longitude"),
            Icon(Icons.location_searching),
          ]
    ),
      ),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Tracking location"),
      ),
      body: new ListView(
        children: <Widget>[
          itemTile,
        ],
      ),
    );
  }


  _updateLat(TodoLat value) {
    double name = value.name;
    setState((){
      _latitude = name;
    });
  }
  _updateLon(TodoLon value) {
    double name = value.name;
    setState((){
      _longitude = name;
    });
  }
}




class TodoLat {
  double name;
TodoLat.fromJson(Map data) {
    name = data['latitude'];
    if (name == null) {
      name = 0.0;
    }
  }
}

class  TodoLon {
  double name;
TodoLon.fromJson(Map data) {
    name = data['latitude'];
    if (name == null) {
      name = 0.0;
    }
  }
}




class FirebaseLat {
static Future<StreamSubscription<Event>> getTodoStream(String todoKey,
      void onData(TodoLat todo)) async {
   
    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("test")
        .child("location")
        .onValue
        .listen((Event event) {
       var todo = new TodoLat.fromJson(event.snapshot.value);
      onData(todo);
    });
    return subscription;
      }
      }

      class FirebaseLon{
static Future<StreamSubscription<Event>> getTodoStream(String todoKey,
      void onData(TodoLon todo)) async {
   
    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("test")
        .child("location")
        .onValue
        .listen((Event event) {
       var todo = new TodoLon.fromJson(event.snapshot.value);
      onData(todo);
    });
    return subscription;
      }
      }


