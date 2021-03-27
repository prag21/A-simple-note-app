import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  String id;
  TextEditingController title = new TextEditingController();
  TextEditingController description = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.notifications, color: Colors.white,),
              onPressed: () {}),
        ],
        backgroundColor: Colors.teal,
        title:
        Container(

          child: Text(
            'Add Note',
            style: TextStyle(
                fontWeight: FontWeight.w500, letterSpacing: 0.2, fontSize: 25),
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Text(
              'Title',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 10, right: 20),
            child: Theme(
              data: ThemeData(
                primaryColor: Colors.teal,
              ),
              child: TextField(
                controller: title,
                decoration: InputDecoration(
                  focusColor: Colors.black,
                  hoverColor: Colors.black,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  hintText: 'Enter Title',
                ),
                maxLines: 4,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Text(
              'Description',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 10, right: 20),
            child: Theme(
              data: ThemeData(
                primaryColor: Colors.teal,
              ),
              child: TextField(
                controller: description,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    hintText: 'Enter Description'),
                maxLines: 15,
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
                onPressed: () async {
                  final docref = await FirebaseFirestore.instance.collection(
                      "notes").add({
                    'title': title.text,
                    'description': description.text,
                  });
                  id = docref.id;
                  print(id);


                  if (title.text != '' && description.text != '') {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Added Successfully.', style: TextStyle(
                          color: Colors
                              .black),),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.white,
                    ));
                  }
                  else if (title.text == '') {
                    CollectionReference ref = FirebaseFirestore.instance
                        .collection('notes');
                    ref.doc(id).delete().then((value) => print('Success'));
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Error.Title cannot be empty.', style: TextStyle(
                          color: Colors
                              .black),),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.white,
                    ));
                  }
                  else {
                    CollectionReference ref = FirebaseFirestore.instance
                        .collection('notes');
                    ref.doc(id).delete().then((value) => print('Success'));
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Error.Description cannot be empty.', style: TextStyle(
                          color: Colors
                              .black),),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.white,
                    ));
                  }
                },
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}