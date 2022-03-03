import 'dart:async';

import 'package:eqmonitor/utils/earthquake.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatelessWidget {
  GoogleMapPage({Key? key}) : super(key: key);
  final Completer<GoogleMapController> googleMapControler = Completer();
  final EarthQuake earthQuake = Get.find<EarthQuake>();

  void _getUserLocation() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print(position);
    Get.showSnackbar(
      GetSnackBar(
        title: '現在地',
        message: '${position.latitude}, ${position.longitude}',
        duration: const Duration(milliseconds: 1000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // Test if location services are enabled.
          final serviceEnabled = await Geolocator.isLocationServiceEnabled();
          if (!serviceEnabled) {
            // Location services are not enabled don't continue
            // accessing the position and request users of the
            // App to enable the location services.
            return Future.error('Location services are disabled.');
          }

          var permission = await Geolocator.checkPermission();
          if (permission == LocationPermission.denied) {
            permission = await Geolocator.requestPermission();
            if (permission == LocationPermission.denied) {
              return Future.error('Location permissions are denied');
            }
          }

          if (permission == LocationPermission.deniedForever) {
            // Permissions are denied forever, handle appropriately.
            return Future.error(
              'Location permissions are permanently denied, we cannot request permissions.',
            );
          }
          _getUserLocation();
        },
        label: const Text('現在地'),
        icon: const Icon(Icons.location_searching),
      ),
      body: Obx(
        () => GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(37, 135),
          ),
          onMapCreated: googleMapControler.complete,
          mapType: MapType.normal,
          compassEnabled: true,
          mapToolbarEnabled: true,
          myLocationEnabled: false,
          myLocationButtonEnabled: true,
          trafficEnabled: false,
          circles: earthQuake.circles.value,
          markers: const {},
        ),
      ),
    );
  }
}
