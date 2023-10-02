import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:homework/createuser.dart';
import 'package:homework/login.dart';

void main() {
  runApp(const TraWellApp());
}

var globalNavigatorHolderKey = GlobalKey<_NavigatorHolderState>();

class TraWellApp extends StatelessWidget {
  const TraWellApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TraWell - Flutter version',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: NavigatorHolder()
    );
  }
}

class NavigatorHolder extends StatefulWidget {
  NavigatorHolder() : super(key: globalNavigatorHolderKey);

  @override
  _NavigatorHolderState createState() => _NavigatorHolderState();
}

class _NavigatorHolderState extends State<NavigatorHolder> {
  List<Page> pages = [
    const MaterialPage(child: MainPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: pages.toList(),
      onPopPage: (Route route, dynamic result) {
        setState(() {
          route.didPop(result);
          pages.removeLast();
        });
        return true;
      },
      onGenerateRoute: (route) {
        switch (route.name) {
          case "/loginpage":
            return MaterialPageRoute(
              settings: const RouteSettings(name: "/loginpage"),
              builder: (context) => LoginPage(
              ),
            );
        }
        if (route.name?.contains("/loginpage/") ?? false) {
          final routeName = route.name!;
          final arg = routeName.substring(
              routeName.lastIndexOf("/") + 1, routeName.length);
          return MaterialPageRoute(
            settings: RouteSettings(name: "/loginpage/$arg"),
            builder: (context) => LoginPage(
            ),
          );
        }
        return null;
      },
      onUnknownRoute: (route) {
        return MaterialPageRoute(
          builder: (_) => LoginPage(
          ),
        );
      },
    );
  }

  void addNewPage(Widget page) {
    setState(() {
      pages.add(MaterialPage(child: page));
    });
  }

  void replaceTopPage(Widget page) {
    setState(() {
      pages.removeLast();
      pages.add(MaterialPage(child: page));
    });
  }
}

class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var result = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Are you sure?"),
                content: const Text("Do you really want to quit?"),
                actions: [
                  TextButton(
                    child: const Text("No"),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                  TextButton(
                    child: const Text("Yes"),
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ],
              );
            });
        return result ?? false;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Main page")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("This is the main page!"),
              ElevatedButton(
                child: const Text("Go to first page"),
                onPressed: () {
                  globalNavigatorHolderKey.currentState!
                      .addNewPage(const LoginPage());
                },
              ),
              ElevatedButton(
                child: const Text("Go to second page"),
                onPressed: () {
                  globalNavigatorHolderKey.currentState!
                      .addNewPage(const CreateUser());
                },
              ),
              ElevatedButton(
                child: const Text("Go back"),
                onPressed: () async {
                  var handledPop = await Navigator.maybePop(context);
                  if (!handledPop) {
                    SystemNavigator.pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}