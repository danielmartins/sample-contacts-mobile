import 'package:agenda_app/models/contact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveContact(Contact contact){
    return _db.collection('contacts').doc(contact.id).set(contact.toMap());
  }

  Stream<List<Contact>> getContacts(){
    return _db.collection('contacts').snapshots().map((snapshot) => snapshot.docs.map((doc) => Contact.fromFirestore(doc.data())).toList());
  }

  Future<void> removeContact(String contactId) {
    return _db.collection('contacts').doc(contactId).delete();
  }
}