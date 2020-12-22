class Contact {
  final String id;
  final String name;
  final String gender;
  final String phone;
  final String email;

  Contact({this.id, this.name, this.gender, this.phone, this.email});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'phone': phone,
      'email': email
    };
  }

  Contact.fromFirestore(Map<String, dynamic> firestore)
      : id = firestore['id'],
        name = firestore['name'],
        gender = firestore['gender'],
        phone = firestore['phone'],
        email = firestore['email'];
}
