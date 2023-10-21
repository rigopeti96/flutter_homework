import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../main.dart';




class CreateAlertPage extends StatefulWidget {
  final LatLng position;

  const CreateAlertPage({super.key, required this.position});

  @override
  _CreateAlertPage createState() => _CreateAlertPage(position: position);
}

class _CreateAlertPage extends State<CreateAlertPage> {
  final LatLng position;

  _CreateAlertPage({required this.position});

  @override
  Widget build(BuildContext context) {
    final L10n l10n = L10n.of(context)!;
    String reportType = l10n.blackout;

    List<String> list = <String>[l10n.blackout,
      l10n.accidentCar,
      l10n.accidentPT,
      l10n.inspector,
      l10n.trafficJam,
      l10n.weather,
      l10n.unknown,
      l10n.delay,
      l10n.assemblyErr,
      l10n.passengerSick
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.createAlert)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Your position"),
            Text("Latitude: ${position.latitude.toString()}"),
            Text("Longitude: ${position.longitude.toString()}"),
            DropdownButton<String>(
              hint: new Text("Select a user"),
              value: reportType,
              onChanged: (String? newValue) {
                setState(() {
                  reportType = newValue!;
                });
              },
              items: list.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(color: Colors.black),
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
              child: Text(l10n.createUserBack),
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