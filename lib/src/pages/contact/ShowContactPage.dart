import 'package:bazara_tecnical_test/src/models/contact.dart';
import 'package:bazara_tecnical_test/src/pages/contact/EditContactPage.dart';
import 'package:bazara_tecnical_test/src/pages/contact/IndexContactPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ShowContactPage extends StatefulWidget {
  const ShowContactPage({super.key, required this.contact});
  final Contact contact;

  @override
  State<ShowContactPage> createState() => _ShowContactPageState();
}

class _ShowContactPageState extends State<ShowContactPage> {
  Contact? contact;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contact = widget.contact;

    // print(updatedDate);
    // Future<QuerySnapshot<Map<String, dynamic>>> updatedDate() async {
    //   return FirebaseFirestore.instance
    //       .collection('contact')
    //       .doc(contact?.id)
    //       .collection('updated_at')
    //       .get();
    // };

    // print(updatedDate().);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: StreamBuilder(builder: (conext, snapshot) {
          return AppBar(
            elevation: 0,
            actions: <Widget>[
              IconButton(
                color: Colors.white,
                icon: Icon(Icons.edit),
                onPressed: () {
                  selected_contact(contact);
                },
              ),
              IconButton(
                color: Colors.white,
                icon: const Icon(Icons.delete),
                onPressed: () {
                  DeleteContact('${contact?.id}');
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const IndexContactPage()));
                },
              ),
            ],
          );
        }
            // },
            ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('contact')
            .doc(contact?.id)
            .collection('updated_at')
            .snapshots(),
        builder: (context, snapshot) {
          return ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  buildHeader(
                      context, '${contact?.first_name} ${contact?.last_name}'),
                  buildInformation(contact?.phone_number, contact?.email,
                      contact?.first_name),
                  // snapshot.data?
                ],
              )
            ],
          );
        },
      ),
    );
  }

  selected_contact(contact) async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditContactPage(
              contact: contact,
            )));
  }
}
// }

Container buildHeader(BuildContext context, String name) {
  return Container(
    decoration: BoxDecoration(color: Colors.blue),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.40,
    child: Column(
      children: <Widget>[
        SizedBox(height: 20),
        SizedBox(height: 20),
        Icon(
          Icons.person,
          color: Colors.white,
          size: 160,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Padding buildInformation(phoneNumber, email, nome) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: <Widget>[
        Card(
          child: ListTile(
            title: Text(phoneNumber.toString().isNotEmpty
                ? phoneNumber
                : 'this contact does not have a phone number'),
            subtitle: Text(
              "Phone Number",
              style: TextStyle(color: Colors.black54),
            ),
            leading: IconButton(
              icon: Icon(Icons.phone, color: Colors.blue),
              onPressed: () {},
            ),
            trailing: IconButton(
              icon: Icon(Icons.message),
              onPressed: () {},
            ),
          ),
        ),
        Card(
          child: ListTile(
            title: Text(email.toString().isNotEmpty
                ? email
                : 'This contact does not have email '),
            subtitle: Text(
              "E-mail",
              style: TextStyle(color: Colors.black54),
            ),
            leading: IconButton(
                icon: Icon(Icons.email, color: Colors.blue), onPressed: () {}),
          ),
        ),
      ],
    ),
  );
}
