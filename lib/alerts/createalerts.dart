import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../main.dart';




class CreateAlertPage extends StatelessWidget {
  final LatLng position;
  String selectedString  = "";
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  CreateAlertPage({super.key, required this.position});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TraWell - Create alert")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Your position"),
            Text("Latitude: ${position.latitude.toString()}"),
            Text("Longitude: ${position.longitude.toString()}"),
            DropdownButton<String>(
              hint: new Text("Select a user"),
              value: selectedString,
              onChanged: (String? newValue) {
                setState(() {
                  selectedString = newValue!;
                });
              },
              items: list.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: new TextStyle(color: Colors.black),
                  ),
                );
            }).toList(),
          ),
          ElevatedButton(
            child: const Text("Send report"),
            onPressed: (){
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
      ),
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
