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
                      onPressed: () {},
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