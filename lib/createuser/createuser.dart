import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../main.dart';
import 'createuserresponse.dart';

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
  Set<String> roles = {'USER'};

  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  Future<CreateUserResponse> signup(BuildContext context, L10n l10n) async{
    try{
      final response = await http.post(
        Uri.parse('http://192.168.0.129:8080/api/auth/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': fullNameController.text,
          'username': userNameController.text,
          'password': passwordController.text,
          'email': emailController.text,
          'roles': roles.toString()
        }),
      );

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        return CreateUserResponse.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create user!');
      }
    } catch(_){
      _showToast(context, l10n);
      throw Exception('Failed to connect.');
    }

  }

  void _showToast(BuildContext context, L10n l10n) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(l10n.connectionErrorMessage),
        action: SnackBarAction(label: l10n.dismissButton, onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final L10n l10n = L10n.of(context)!;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: fullNameController,
            decoration: InputDecoration(
              hintText: l10n.fullNameTag,
            ),
          ),
          TextField(
            controller: userNameController,
            decoration: InputDecoration(
              hintText: l10n.userNameTag,
            ),
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: l10n.passwordTag,
            ),
          ),
          TextField(
            controller: emailController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: l10n.emailTag,
            ),
          ),
          ElevatedButton(
            child: Text(l10n.createUser),
            onPressed: (){
              signup(context, l10n);
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