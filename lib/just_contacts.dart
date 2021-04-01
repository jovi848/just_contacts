
import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:just_contacts/models/just_contacts.dart';

class JustContacts {
  static const MethodChannel _channel =
      const MethodChannel('just_contacts');

  static Future<String?> getContacts(Function(String) then) async {
    Stopwatch stopwatch = new Stopwatch()..start();

    var uuid = 'some random id';

    _channel.setMethodCallHandler((call) {
      if(call.method == ('getPlatformVersion'+uuid)){
        print(call.arguments);
        then(call.arguments.toString());
      }
      return Future.value(true);
    });

    final String? json = await _channel.invokeMethod('getPlatformVersion',uuid);

    print('doSomething() executed in ${stopwatch.elapsed}');

    return json;
  }
}
