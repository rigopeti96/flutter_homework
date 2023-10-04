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
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const TextField(
            decoration: InputDecoration(
              hintText: 'Full name',
            ),
          ),
          const TextField(
            decoration: InputDecoration(
              hintText: 'User name',
            ),
          ),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
            ),
          ),
          ElevatedButton(
            child: const Text("Create user"),
            onPressed: (){
              //TODO: implement http call
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: const Text("Back"),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}