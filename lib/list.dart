import 'package:atg/details.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
class Lists extends StatefulWidget {
  @override
  _ListsState createState() => _ListsState();
}

class _ListsState extends State<Lists> {
  String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.notifications,color: Colors.white,), onPressed:(){}),
        ],
        backgroundColor: Colors.teal,
        title: Text(
          'List Of All Notes',
          style: TextStyle(
              fontWeight: FontWeight.w500, letterSpacing: 0.2, fontSize: 25),
        ),
        centerTitle: true,
      ),
drawer: Drawer(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('notes')

        .snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return Text('no data');
      }

      return ListView(
        children:snapshot.data.documents.map<Widget>((document){

          return Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: GestureDetector(
              onTap: () {
            setState(() {
              id=document.documentID;
              print(id);
            });
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Details(id:id)));
          },
              child:Container(
                child: Padding(
                  padding:
                  EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  child: Container(
                      child:Center(

                          child:Padding(
                            padding: EdgeInsets.only(top: 10,bottom: 10),
                              child:Text(
                                  document['title'],
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.w500))
                          ),
                      ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.teal, width: 1.5),
                  color: Colors.white,
                ),
              ),
          ),
              ),
              ),
          );
      }).toList(),
      );
    }
    )



    );
  }
}



