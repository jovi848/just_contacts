
import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:just_contacts/models/just_contacts.dart';

class JustContacts {
  static const MethodChannel _channel =
      const MethodChannel('just_contacts');


  static void getContacts({required Function(String) then,required Function() onError}) async {
    Stopwatch stopwatch = new Stopwatch()..start();
    try {

      var uuid = 'some random id';
      final String? json = await _channel.invokeMethod('getPlatformVersion',uuid);

      _channel.setMethodCallHandler((call) {
        if(call.method == ('getPlatformVersion'+uuid)){
          print(call.arguments);
          then(call.arguments.toString());
        }
        return Future.value(true);
      });

      } on PlatformException {
        onError();
      }


      print('doSomething() executed in ${stopwatch.elapsed}');

  }
}
