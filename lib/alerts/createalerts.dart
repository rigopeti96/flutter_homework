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
  String reportType = "";

  @override
  Widget build(BuildContext context) {
    final L10n l10n = L10n.of(context)!;
    String stationName = "";
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
    String dateFormatted = date.toString().substring(0, date.toString().indexOf('.'));

    List<String> errorList = <String>[l10n.blackout,
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

    List<String> stationsNearList = <String>[];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.createAlertTitle)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5), //apply padding to all four sides
              child: Text(l10n.yourPosition),
            ),
            Padding(
              padding: const EdgeInsets.all(5), //apply padding to all four sides
              child: Text("Latitude: ${position.latitude.toString()}"),
            ),
            Padding(
              padding: const EdgeInsets.all(5), //apply padding to all four sides
              child: Text("Longitude: ${position.longitude.toString()}"),
            ),
            Padding(
              padding: const EdgeInsets.all(5), //apply padding to all four sides
              child: Text("Actual date: $dateFormatted"),
            ),
            //TODO Nem változik az érték, megkérdezni!
            DropdownButton<String>(
              //hint: Text(l10n.selectError),
              value: reportType,
              onChanged: (String? newValue) {
                setState(() {
                  reportType = newValue!;
                });
              },
              items: errorList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              hint: Text(l10n.selectError),
              onChanged: (String? newValue) {
                stationName = newValue!;
                setState(() {
                  newValue;
                });
              },
              value: stationName,
              items: stationsNearList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
            ),
            Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                      ),
                      child: Text(l10n.createAlert),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                )
            )
          ],
        ),
      ),
    );
  }
}