import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';


Future<bool> handleLocationPermission(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled)  {
    // Get.snackbar(
    //      'Location services are disabled. Please enable the services',
    //      err.message.toString(),
    //     );

    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // AppFunction.showAlert(context, 'Location permissions are denied',
      //     type: AlertType.error);

      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    // if (!context.mounted) return;
    // AppFunction.showAlert(context,
    //     'Location permissions are permanently denied, we cannot request permissions.',
    //     type: AlertType.error);

    return false;
  }
  return true;
}

Future<Position> getCurrentLocation(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // AppFunction.showAlert(
    //     context, 'Location services are disabled. Please enable the services',
    //     type: AlertType.error);

    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // AppFunction.showAlert(context, 'Location permissions are denied',
      //     type: AlertType.error);

      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // if (!context.mounted) return;
    // AppFunction.showAlert(context,
    //     'Location permissions are permanently denied, we cannot request permissions.',
    //     type: AlertType.error);

    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.best,
    // forceAndroidLocationManager: true,
  );
}

Future<String> getAddressFromLatLng(Position position) async {
  try {
    final response =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (response.isNotEmpty) {
      return await placemarkFromCoordinates(
              position.latitude, position.longitude)
          .then((placemarks) {
        Placemark place = placemarks[0];
        return '${place.country}, ${place.administrativeArea}, ${place.locality}';
      });
    } else {
      return 'Error occured';
    }
  } catch (e) {
    return '$e';
  }
}