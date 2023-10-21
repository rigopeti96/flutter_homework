import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<CreateUser> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final L10n l10n = L10n.of(context)!;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: l10n.fullNameTag,
            ),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: l10n.userNameTag,
            ),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: l10n.passwordTag,
            ),
          ),
          ElevatedButton(
            child: Text(l10n.createUser),
            onPressed: (){
              //TODO: implement http call
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: Text(l10n.createUserBack),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}