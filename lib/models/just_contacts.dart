import 'dart:convert';


class AGroupOfContacts {
  AGroupOfContacts({
    required this.justContacts,
  });

  List<JustContact> justContacts;

  factory AGroupOfContacts.fromJson(Map<String, dynamic> json) => AGroupOfContacts(
    justContacts: List<JustContact>.from(json["contacts"].map((x) => JustContact.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "contacts": List<dynamic>.from(justContacts.map((x) => x.toJson())),
  };
}

class JustContact {
  JustContact({
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

  factory JustContact.fromJson(Map<String, dynamic> json) => JustContact(
    firstName: json["firstName"],
    lastName: json["lastName"],
    phoneNumbers: List<String>.from(json["phoneNumbers"].map((x) => x)),
    name: json["name"],
    emails: List<dynamic>.from(json["emails"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "phoneNumbers": List<dynamic>.from(phoneNumbers.map((x) => x)),
    "name": name,
    "emails": List<dynamic>.from(emails.map((x) => x)),
  };
}
