import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Trash extends StatefulWidget {
  @override
  _TrashState createState() => _TrashState();
}

class _TrashState extends State<Trash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.notifications,color: Colors.white,), onPressed:(){}),
        ],
        backgroundColor: Colors.teal,
        title: Text(
          'Restore Notes',
          style: TextStyle(
              fontWeight: FontWeight.w500, letterSpacing: 0.2, fontSize: 25),
        ),
        centerTitle: true,
      ),
        drawer: Drawer(),

      body:  StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('trash')

        .snapshots(),
    builder: (context, snapshot) {
    if (!snapshot.hasData) {
    return Text('no data');
    }

    return ListView(
    children:snapshot.data.documents.map<Widget>((document)
    {
      return

        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.teal, width: 1.5),
            ),
            child: ListTile(
                title: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Container(
                    child: Text(document['title'],
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                  ),
                ),
                trailing:
                IconButton(onPressed: () {
    FirebaseFirestore.instance.collection("notes").add({
      'title': document['title'],
      'description': document['description'],
    });
    CollectionReference ref = FirebaseFirestore.instance.collection('trash');
    ref.doc(document.documentID).delete().then((value) => print('Success'));

                }, icon: Icon(Icons.restore))),
          ),
        );
    }
    ).toList(),

    );
    })
    );
  }

}
