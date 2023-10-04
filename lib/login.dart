import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homework/createuser.dart';

import '../main.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.android,
                color: Colors.greenAccent,
                size: 120,
              ),
              const SizedBox(height: 16),
              const Text("This is the first page"),
              ElevatedButton(
                child: const Text("Navigate to the second page"),
                onPressed: () {
                  globalNavigatorHolderKey.currentState!.addNewPage(CreateUser(key: UniqueKey(),));
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
        ),
      ),
    );
  }
}