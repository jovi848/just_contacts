
import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:just_contacts/models/just_contacts.dart';

class JustContacts {
  static const MethodChannel _channel =
      const MethodChannel('just_contacts');

  static Future<String> get platformVersion async {
    Stopwatch stopwatch = new Stopwatch()..start();

    final String json = await _channel.invokeMethod('getPlatformVersion');
   var jovi = AGroupOfContacts.fromJson(jsonDecode(json));
    print('doSomething() executed in ${stopwatch.elapsed}');

    return json;
  }
}
