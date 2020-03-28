import 'dart:async';
import 'package:pass/rd.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:firebase_database/firebase_database.dart';



final DatabaseReference database = FirebaseDatabase.instance.reference().child("test"); 
 
  sendData(pin,locLat,locLon){
    database.push().set({
      'pin' : pin,
      'latitude' : locLat,
      'longitude': locLon,

    });
  }
  var locLatUP;
  var locLonUP;
   var q = rd();
  void updateData(){
  database.child("location").update({
    'pin' : q,
  'latitude' : locLatUP,
  'longitude': locLonUP,
    });
  }

  void deleteData(){
    database.child("location").remove();
  }

class ListenLocationWidget extends StatefulWidget {
  ListenLocationWidget({Key key}) : super(key: key);

  @override
  _ListenLocationState createState() => _ListenLocationState();
}

class _ListenLocationState extends State<ListenLocationWidget> {
  final Location location = new Location();

  LocationData _location;
  StreamSubscription<LocationData> _locationSubscription;
  String _error;

  _listenLocation() async {
    _locationSubscription = location.onLocationChanged().handleError((err) {
      setState(() {
        _error = err.code;
      });
      _locationSubscription.cancel();
    }).listen((LocationData currentLocation) {
      setState(() {
        _error = null;

        _location = currentLocation;
           locLatUP=_location.latitude;
           locLonUP=_location.longitude;
           updateData();

      });
    });
    //
    //sendData(q,_location.latitude,_location.longitude);
  }

  _stopListen() async {
    _locationSubscription.cancel();
    deleteData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Listen location: ' + (_error ?? '${_location ?? "unknown"}'),
          style: Theme.of(context).textTheme.body2,
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 42),
              child: RaisedButton(
                child: Text("Share"),
                onPressed: _listenLocation,
              ),
            ),
            RaisedButton(
              child: Text("Stop"),
              onPressed: _stopListen,
            )
          ],
        ),
      ],
    );
  }
}
