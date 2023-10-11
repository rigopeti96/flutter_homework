import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homework/createuser.dart';
import 'package:homework/login.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const TraWellApp());
}

class TraWellApp extends StatelessWidget {
  const TraWellApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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



  /*LatLng getActPosition(){
    Future<LatLng> actPositionFuture = locationService.getCurrentLocation();
    actPositionFuture.then((value) {
      actualLocation = value;
    });

    return actualLocation;
  }*/

  void _navigateToNextScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TraWell - Map'),
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
              bottom: 10,
              left: 10,
              child: ElevatedButton(
                onPressed: () {
                  _navigateToNextScreen();
                },
                child: const Icon(Icons.access_alarm),
              ),
            )
          ],
        ),
      ),
    );
  }
}


