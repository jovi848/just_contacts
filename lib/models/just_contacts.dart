import 'dart:convert';


class AGroupOfContacts {
  AGroupOfContacts({
    required this.justContacts,
  });

  List<JustAContact> justContacts;

  factory AGroupOfContacts.fromJson(Map<String, dynamic> json) {
    var index = 0;
    return AGroupOfContacts(
        justContacts: List<JustAContact>.from(json["contacts"].map((x) {

      print("x=$index");
      JustAContact.fromJson(x);
      index++;
    })));
  }

  Map<String, dynamic> toJson() => {
    "contacts": List<dynamic>.from(justContacts.map((x) => x.toJson())),
  };
}

class JustAContact {
  JustAContact({
    required this.firstName,
    required this.lastName,
    required this.phoneNumbers,
    required this.name,
    required this.emails,
  });

  String firstName;
  String lastName;
  List<String> phoneNumbers;
  String name;
  List<dynamic> emails;

  factory JustAContact.fromJson(Map<String, dynamic> json) => JustAContact(
    firstName: json["firstName"],
    lastName: json["lastName"],
    phoneNumbers: List<String>.from(json["numbers"].map((x) => x)),
    name: json["name"],
    emails: List<dynamic>.from(json["emails"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "numbers": List<dynamic>.from(phoneNumbers.map((x) => x)),
    "name": name,
    "emails": List<dynamic>.from(emails.map((x) => x)),
  };
}
