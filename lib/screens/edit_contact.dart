import 'package:agenda_app/models/contact.dart';
import 'package:agenda_app/providers/contacts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditContact extends StatefulWidget {
  final Contact contact;

  EditContact([this.contact]);

  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    genderController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.contact == null) {
      // New Contact
      print('New contact!');
      nameController.text = '';
      genderController.text = '';
      phoneController.text = '';
      emailController.text = '';
      // Update State
      new Future.delayed(Duration.zero, () {
        final contactProvider =
            Provider.of<ContactProvider>(context, listen: false);
        contactProvider.loadValues(Contact());
      });
    } else {
      print('Update contact!');
      // Update Controller
      nameController.text = widget.contact.name;
      genderController.text = widget.contact.gender;
      phoneController.text = widget.contact.phone;
      emailController.text = widget.contact.email;

      // Update State
      new Future.delayed(Duration.zero, () {
        final contactProvider =
            Provider.of<ContactProvider>(context, listen: false);
        contactProvider.loadValues(widget.contact);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Edit Item')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'Name'),
              onChanged: (value) {
                contactProvider.changeName(value);
              },
            ),
            TextField(
              controller: genderController,
              decoration: InputDecoration(hintText: 'Gender'),
              onChanged: (value) {
                contactProvider.changeGender(value);
              },
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(hintText: 'Phone'),
              onChanged: (value) {
                contactProvider.changePhone(value);
              },
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'Email'),
              onChanged: (value) {
                contactProvider.changeEmail(value);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
                child: Text('Save'),
                onPressed: () {
                  print(contactProvider.id);
                  contactProvider.saveContact();
                  Navigator.of(context).pop();
                }),
            (widget.contact != null)
                ? RaisedButton(
                    child: Text('Delete'),
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: () {
                      contactProvider.removeContact(widget.contact.id);
                      Navigator.of(context).pop();
                    })
                : Container()
          ],
        ),
      ),
    );
  }
}
