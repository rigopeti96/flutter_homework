import 'package:flutter/material.dart';
import 'package:homework/createuser.dart';

import '../main.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final L10n? l10n = L10n.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n!.loginTitle)),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/splash.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: l10n.userNameTag,
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: l10n.passwordTag,
                  filled: true,
                  fillColor: Colors.white
                ),
              ),
              ElevatedButton(
                child: Text(l10n.createUserBack),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}