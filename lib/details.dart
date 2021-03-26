import 'package:atg/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Details extends StatefulWidget {
  String id;
  Details({this.id});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

 @override
  void initState() {
   ErrorWidget.builder=(FlutterErrorDetails details)=>Scaffold(
     body:Center(
   child:CircularProgressIndicator(),
   ),
   );


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,

        title: Text(
          'Details',
          style: TextStyle(
              fontWeight: FontWeight.w500, letterSpacing: 0.2, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body:  StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('notes')
        .doc(widget.id)
        .snapshots(),
    builder: (context, snapshot) {

    if (!snapshot.hasData) {
    return Text('no data');
    }
    var user = snapshot.data;
    return
    ListView(
    children: [
    Padding(
    padding: EdgeInsets.only(top: 20,left: 40),
    child: Text('Title:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
    ),
    Padding(
    padding: EdgeInsets.only(top: 20,left: 40,right: 40),

      child:  Container(
          child:Center(
            child:Padding(
              padding: EdgeInsets.only(top: 10,bottom: 10),
          child:Text(user['title'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800),),
      ),
      ),


    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20.0),
    border: Border.all(color: Colors.teal,width: 1.5),
    ),

    ),
    ),

    Padding(
    padding: EdgeInsets.only(top: 20,left: 40),
    child: Text('Description:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
    ),
    Padding(
    padding: EdgeInsets.only(top: 20,left: 40,right: 40),
    child: Container(

    child: Padding(
      padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
      child:Text(user['description'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800),),
      ),

    decoration: BoxDecoration(

    borderRadius: BorderRadius.circular(20.0),
    border: Border.all(color: Colors.teal,width: 1.5),
    ),
    ),
    ),
      Center(
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: RaisedButton(
            color: Colors.teal,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            onPressed: () {
      FirebaseFirestore.instance.collection("trash").add({
      'title': user['title'],
      'description': user['description'],
      },

      );
      CollectionReference ref = FirebaseFirestore.instance.collection('notes');
      ref.doc(widget.id).delete().then((value) => print('Success'));
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
      },
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),

    ],
    );
    }
      )
    );
  }
}
