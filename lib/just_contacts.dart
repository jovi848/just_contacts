
import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:just_contacts/models/just_contacts.dart';
import 'package:uuid/uuid.dart';

class JustContacts {
  static const MethodChannel _channel =
      const MethodChannel('just_contacts');

  static var _uuid = Uuid();
  static Future<List<JustAContact>> getContacts() async {
    var completer = Completer<List<JustAContact>>();

    try {

      var uuid = _uuid.v4();
      final _ = await _channel.invokeMethod('getPlatformVersion',uuid);

      _channel.setMethodCallHandler((call) {
        if(call.method == ('getPlatformVersion'+uuid)){
          print(call.arguments);
          var json = jsonDecode(call.arguments.toString());
          var aGroupOfContacts = AGroupOfContacts.fromJson(json);
          completer.complete(aGroupOfContacts.justContacts);
        }
        return Future.value(true);
      });

    } on PlatformException {
      completer.completeError('unable to retrieve contacts');

    }

    return completer.future;
  }


}
