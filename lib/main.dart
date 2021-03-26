import 'package:atg/add.dart';
import 'package:atg/list.dart';
import 'package:atg/trash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> screens = [
    Lists(),
    Add(),
    Trash(),
  ];
  final Map<String, IconData> icons = const {
    'List': Icons.article_outlined,
    'Add': Icons.addchart_outlined,
    'Trash': Icons.delete_sweep_outlined,
  };
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[currentindex],
        bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.teal,
              type: BottomNavigationBarType.fixed,
              items: icons
                  .map(
                    (title, icon) => MapEntry(
                      title,
                      BottomNavigationBarItem(
                        icon: Icon(
                          icon,
                          size: 30.0,
                        ),
                        title: Text(title),
                      ),
                    ),
                  )
                  .values
                  .toList(),
              currentIndex: currentindex,
              selectedItemColor: Colors.white,
              selectedFontSize: 15,
              unselectedItemColor: Colors.white70,
              unselectedFontSize: 15,
              onTap: (index) => setState(() => currentindex = index),
            )));
  }
}
