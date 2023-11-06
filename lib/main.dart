import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homework/createuser.dart';
import 'package:homework/login/login.dart';
import 'package:geolocator/geolocator.dart';
import 'package:homework/alerts/createalerts.dart';
import 'package:homework/main.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:homework/reportlist/reportlist.dart';
export 'package:flutter_gen/gen_l10n/l10n.dart';

void main() {
  runApp(const TraWellApp());
}

class TraWellApp extends StatelessWidget {
  const TraWellApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late GoogleMapController mapController;

  List<Page> pages = [
    const MaterialPage(child: TraWellApp()),
  ];


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  LatLng getActPosition(){
    Future<Position> actPosFuture = _determinePosition();
    actPosFuture.then((value){
      return LatLng(value.latitude, value.longitude);
    });

    return const LatLng(47.4983, 19.0408);
  }

  void locationSettingsFunction(){
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
            (Position? position) {
          print(position == null ? 'Unknown' : '${position.latitude.toString()}, ${position.longitude.toString()}');
          //GoogleMap
        });
  }

  void _navigateToLoginScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  void _navigateToCreateUserScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CreateUser(),
      ),
    );
  }

  void _navigateToCreateAlertScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateAlertPage(position: getActPosition()),
      ),
    );
  }

  void _navigateToReportsScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ReportListPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final L10n l10n = L10n.of(context)!;
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(l10n.homeTitle),
          elevation: 2,
        ),
        // Egymásra helyezed ezzel a widgeteket CSS-ben ez a z-index
        body: Stack(
          children: [
            StreamBuilder<Position>(
              stream: Geolocator.getPositionStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final position = snapshot.data;
                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(position!.latitude, position.longitude),
                      zoom: 15.0,
                    ),
                    onMapCreated: _onMapCreated,
                    markers: <Marker>{

                      Marker(
                        markerId: const MarkerId('user_location'),
                        position: LatLng(position.latitude, position.longitude),
                        icon: BitmapDescriptor.defaultMarker,

                      ),
                    },
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            Positioned(
              top: 10,
              right: 10,
              child: ElevatedButton(
                onPressed: () {
                  _navigateToLoginScreen();
                },
                child: const Icon(Icons.login),
              ),
            ),
            Positioned(
              top: 60,
              right: 10,
              child: ElevatedButton(
                onPressed: () {
                  _navigateToCreateUserScreen();
                },
                child: const Icon(Icons.add_reaction_outlined),
              ),
            ),
            Positioned(
              top: 110,
              right: 10,
              child: ElevatedButton(
                onPressed: () {
                  _navigateToCreateAlertScreen();
                },
                child: const Icon(Icons.notifications_active),
              ),
            ),
            Positioned(
              top: 160,
              right: 10,
              child: ElevatedButton(
                onPressed: () {
                  _navigateToReportsScreen();
                },
                child: const Icon(Icons.railway_alert),
              ),
            )
          ],
        ),
      ),
    );
  }
}


