import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homework/reportlist/reportdataresponse.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../main.dart';

class ReportListPage extends StatefulWidget {

  const ReportListPage({super.key});

  @override
  _ReportListPage createState() => _ReportListPage();
}

class _ReportListPage extends State<ReportListPage> {
  //Future<List<ReportDataResponse>> responseList;

  var reportList = [
    "Madras",
    "Kaala",
    "Kabali",
    "Sarpatta Parambarai",
    "Dhammam",
    "Natchathiram Nagargirathu",
    "Parieryum Perumal",
    "Karnan",
    "Vadachennai",
    "Asuran",
    "Jai Bhim"
  ];
  
  _ReportListPage();

  void onTapGesture(item) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$item is selected"),
    ));
  }

  Future<void> _showMyDialog(L10n l10n) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l10n.generalErrorMessage),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(l10n.jwtTokenEmptyMessage),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(l10n.okButton),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> _extendError(BuildContext context, L10n l10n, String id) async{
    try{
      final response = await http.put(
        Uri.parse('http://192.168.0.171:8080/api/reports/putReport'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization' :'Bearer $jwtToken'
        },
        body: jsonEncode(<String, String>{
          'id':id,
          'reportDateUntil': DateTime.now().add(const Duration(minutes: 5)).toString().replaceAll(" ", "T"),
          'modifierName':userName
        }),
      );

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        _showToast(context, l10n.reportUpdateSuccessMessage, l10n.okButton);
        return response.body;
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

  void _showToast(BuildContext context, String message, String okButton) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(label: okButton, onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
  
  /*void fillReportList(){
    responseList = getReports();
  }*/
  
  /*Future<List<ReportDataResponse>> getReports() async{
    final response = await http.post(
      Uri.parse('http://192.168.0.171:8080/api/auth/signin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',

      },
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      final List<ReportDataResponse> body = json.decode(response.body);
      return body.map((e) => ReportDataResponse.fromJson(e)).toList();
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }*/

  @override
  Widget build(BuildContext context) {
    final L10n l10n = L10n.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.reportListTitle),
      ),
      body: ListView.builder(
        itemCount: reportList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          reportList[index],
                        ),
                        Text("pina"),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.access_time_filled),
                      iconSize: 40,
                      onPressed: () {
                        if(jwtToken != ""){
                          //_extendError(context, l10n, reportList[index].id);
                        } else {
                          _showMyDialog(l10n);
                        }
                      },
                    )
                  ],
                )
              ),
            ),
            onTap: () => onTapGesture(reportList[index]),
          );
        },
      ),
    );
  }
}