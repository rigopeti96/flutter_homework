import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ReportListPage extends StatefulWidget {

  const ReportListPage({super.key});

  @override
  _ReportListPage createState() => _ReportListPage();
}

class _ReportListPage extends State<ReportListPage> {

  _ReportListPage();

  var movieList = [
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

    void onTapGesture(item) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$item is selected"),
      ));
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("List"),
        ),
        body: ListView.builder(
          itemCount: movieList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 16.0),
                  child: Text(
                    movieList[index],
                  ),
                ),
              ),
              onTap: () => onTapGesture(movieList[index]),
            );
          },
        ),
      );
    }
}