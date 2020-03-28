import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'streamBuilder.dart';

final database = FirebaseDatabase.instance.reference();


class TrackLoc extends StatefulWidget {
  @override
  TrackLocation createState() {
    return TrackLocation();
  }
}

class TrackLocation extends State {
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Track Location',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('Enter The Pin'),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}





class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}





class MyCustomFormState extends State<MyCustomForm> {
  
  var checkPin = readData();
  var flag = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container(
      child:Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.number,
            
            validator: (value) {
              if (value.isEmpty) {
                flag=0;
                return 'Please enter the pin';
              }
              else if(int.parse(value)==checkPin){
               flag=1;
             }
             
             else{
               flag=0;
             }
              return null;
              
            },
            
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Center(child: 
            RaisedButton(
              onPressed: () {
     //               print(checkPin);
                if (_formKey.currentState.validate()) {
                  if(flag==1){
                  Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Processing Data')));
                Navigator.push(context,MaterialPageRoute(builder: (context)=>SB()));
               }
               }
               },
              child: Text('Submit'),
            ),
            ),
          ),
        ],
      ),
      ),
      margin: EdgeInsets.fromLTRB(50, 100, 50, 100),
    
    ); 
  }
}








var pin;


int readData(){
database.child("test").child("location").child("pin").once().then((DataSnapshot snap){
//print(pin);
return pin = (snap.value);
}
);
print(pin);
return pin;
}



