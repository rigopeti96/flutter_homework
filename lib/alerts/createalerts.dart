import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homework/alerts/errortypevalues.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import '../../main.dart';
import 'createerrorresponse.dart';




class CreateAlertPage extends StatefulWidget {
  final LatLng position;

  const CreateAlertPage({super.key, required this.position});

  @override
  _CreateAlertPage createState() => _CreateAlertPage(position: position);
}

class _CreateAlertPage extends State<CreateAlertPage> {
  final LatLng position;
  _CreateAlertPage({required this.position});
  final errorTypeController = TextEditingController();
  ErrorType testType = ErrorType.blackout;

  Future<CreateErrorResponse> createError(BuildContext context, L10n l10n) async{
    try{
      final response = await http.post(
        Uri.parse('http://192.168.0.171:8080/api/reports/postReport'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization' :'Bearer $jwtToken'
        },
        body: jsonEncode(<String, String>{
          'reportType':l10n.generalError,
          //'stationName': _getErrorType(l10n),
          'stationName': errorTypeController.text,
          'transportType':l10n.unknown,
          'latitude': position.latitude.toString(),
          'longitude': position.longitude.toString(),
          'reportDate': DateTime.now().toString().replaceAll(" ", "T"),
          'reportDateUntil': DateTime.now().add(const Duration(minutes: 5)).toString().replaceAll(" ", "T"),
          'reporterName':userName,
          'modifierName':userName
        }),
      );

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        CreateErrorResponse loginResponse = CreateErrorResponse.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
        MainPageState createState() => MainPageState();
        Navigator.of(context).pop();
        _showToast(context, l10n.reportCreateSuccessMessage, l10n.okButton);
        return loginResponse;
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create error.');
      }
    } on Exception catch (e) {
      print(e);
      _showToast(context, l10n.connectionErrorMessage, l10n.okButton);
      throw Exception('Failed to connect.');
    }

  }

  String _getErrorType(L10n l10n){
    if(errorTypeController.text.isEmpty){
      return l10n.generalError;
    }
    return errorTypeController.text;
  }

  void _showToast(BuildContext context, String message, String okButton) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(label: okButton, onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final L10n l10n = L10n.of(context)!;
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
    String dateFormatted = date.toString().substring(0, date.toString().indexOf('.'));

    return Scaffold(
      appBar: AppBar(title: Text(l10n.createAlertTitle)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5), //apply padding to all four sides
              child: Text("${l10n.userNameTag}: $userName"),
            ),
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
            Padding(
              padding: const EdgeInsets.all(5), //apply padding to all four sides
              child: TextField(
                controller: errorTypeController,
                decoration: InputDecoration(
                  hintText: l10n.selectError,
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
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
                        createError(context, l10n);
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