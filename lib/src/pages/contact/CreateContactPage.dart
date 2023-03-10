// ignore_for_file: sized_box_for_whitespace, unused_local_variable, prefer_const_constructors, sort_child_properties_last

import 'package:bazara_tecnical_test/src/models/contact.dart';
import 'package:bazara_tecnical_test/src/pages/contact/IndexContactPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateContactPage extends StatefulWidget {
  const CreateContactPage({super.key});
  @override
  State<CreateContactPage> createState() => _CreateContactPageState();
}

class _CreateContactPageState extends State<CreateContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _email = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextFormField inputFirstName = TextFormField(
      controller: _firstName,
      autofocus: true,
      keyboardType: TextInputType.text,
      inputFormatters: [
        LengthLimitingTextInputFormatter(45),
      ],
      decoration: const InputDecoration(
        labelText: 'First Name',
        icon: Icon(Icons.person),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'The field of first name is required';
        }
        return null;
      },
    );

    TextFormField inputLastName = TextFormField(
      controller: _lastName,
      keyboardType: TextInputType.text,
      inputFormatters: [
        LengthLimitingTextInputFormatter(25),
      ],
      decoration: const InputDecoration(
        labelText: 'Last Name',
        icon: Icon(Icons.person),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'The field of last name is required';
        }
        return null;
      },
    );

    TextFormField inputPhoneNumber = TextFormField(
      controller: _phoneNumber,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        labelText: "Phone Number",
        icon: Icon(Icons.phone),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'The field of phone number is required';
        }
        return null;
      },
    );

    TextFormField inputEmail = TextFormField(
      controller: _email,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'E-mail',
        icon: Icon(Icons.email),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'The field of email is required';
        }
        return null;
      },
    );

    final picture = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 120.0,
          height: 120.0,
          child: const CircleAvatar(
            child: Icon(
              Icons.person,
              size: 60.0,
            ),
          ),
        ),
      ],
    );

    ElevatedButton submitButton = ElevatedButton(
      onPressed: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (_formKey.currentState!.validate()) {
          final contact = Contact(
              first_name: _firstName.text,
              last_name: _lastName.text,
              phone_number: _phoneNumber.text,
              email: _email.text);

          CreateContact(contact);

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const IndexContactPage()));
        }
      },
      child: Text('Save'),
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        minimumSize: const Size.fromHeight(50),
      ),
    );

    ListView content = ListView(
      padding: EdgeInsets.all(20),
      children: <Widget>[
        const SizedBox(height: 40),
        picture,
        const SizedBox(height: 20),
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              inputFirstName,
              inputLastName,
              inputPhoneNumber,
              inputEmail,
              const SizedBox(
                height: 40,
              ),
              submitButton
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Create new contact"),
      ),
      body: content,
    );
  }
}
