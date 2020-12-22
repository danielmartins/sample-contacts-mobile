import 'package:agenda_app/models/contact.dart';
import 'package:agenda_app/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ContactProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  var uuid = Uuid();
  String _name;
  String _gender;
  String _id;
  String _phone;
  String _email;

  // Getters
  String get name => _name;

  String get gender => _gender;

  String get id => _id;

  String get phone => _phone;

  String get email => _email;

  // Setters
  changeName(String value) {
    _name = value;
    notifyListeners();
  }

  changeGender(String value) {
    _gender = value;
    notifyListeners();
  }

  changePhone(String value) {
    _phone = value;
    notifyListeners();
  }

  changeEmail(String value) {
    _email = value;
    notifyListeners();
  }

  loadValues(Contact contact) {
    _name = contact.name;
    _gender = contact.gender;
    _phone = contact.phone;
    _email = contact.email;
    _id = contact.id;
  }

  saveContact() {
    print("$name,$gender,$phone,$email");
    if (_id == null) {
      var newContact = Contact(
          id: uuid.v4(),
          name: name,
          gender: gender,
          phone: phone,
          email: email);
      firestoreService.saveContact(newContact);
    } else {
      var updateContact = Contact(
          name: name,
          gender: gender,
          phone: phone,
          email: email,
          id: _id);
      firestoreService.saveContact(updateContact);
    }
  }

  removeContact(String contactId){
    print("Removing.... $contactId");
    firestoreService.removeContact(contactId);
  }
}
