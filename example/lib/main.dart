import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:just_contacts/just_contacts.dart';
import 'package:just_contacts/models/just_contacts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<JustAContact> data = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    try {
      var x = await JustContacts.getContacts();
      setState(() {
        data = x;
      });
    } catch (e){
      print(e);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body:  ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context,int index){

              return Row(children: [Text(data.length.toString()),
                Text(data[index].firstName ?? '' + data[index].lastName ?? '',),
                Text(data[index].phoneNumbers.join('-'))
              ]);


            }
        ),
      ),
    );
  }
}
