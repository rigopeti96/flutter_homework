import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homework/alerts/errortypevalues.dart';

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

  ErrorType testType = ErrorType.blackout;

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
    String stationName = "";
    String reportType = l10n.blackout;
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
    String dateFormatted = date.toString().substring(0, date.toString().indexOf('.'));

    /*Map<ErrorType, String> errorList = <ErrorType, String>{
      ErrorType.blackout: l10n.blackout,
      ErrorType.accidentCar: l10n.accidentCar,
      ErrorType.accidentPT: l10n.accidentPT,
      ErrorType.inspector: l10n.inspector,
      ErrorType.trafficJam: l10n.trafficJam,
      ErrorType.weather: l10n.weather,
      ErrorType.unknown: l10n.unknown,
      ErrorType.delay: l10n.delay,
      ErrorType.assemblyErr: l10n.assemblyErr,
      ErrorType.passengerSick: l10n.passengerSick
    };*/

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