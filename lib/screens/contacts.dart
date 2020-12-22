import 'package:agenda_app/models/contact.dart';
import 'package:agenda_app/screens/edit_contact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Contacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contacts = Provider.of<List<Contact>>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.add,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditContact()));
              })
        ],
      ),
      body: (contacts != null)
          ? ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(contacts[index].name),
                  trailing: Text(contacts[index].gender),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditContact(contacts[index])));
                  },
                );
              })
          : Center(child: CircularProgressIndicator()),
    );
  }
}
