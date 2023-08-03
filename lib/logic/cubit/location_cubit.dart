import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    debugPrint("Getting location");

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    debugPrint("Service enabled? ${serviceEnabled.toString()}");
    if (!serviceEnabled) {
      String error = 'Location services are disabled.';
      emit(LocationError(error, ErrorStates.serviceDisabled));
      return Future.error(error);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        String error = 'Location permissions are denied';
        emit(LocationError(error, ErrorStates.permissionDenied));
        return Future.error(error);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      String error = 'Location permissions are permanently denied, we cannot request permissions.';
      emit(LocationError(error, ErrorStates.permanentlyDenied));
      return Future.error(error);
    }
    try{
      Position location = await Geolocator.getCurrentPosition();
      emit(LocationSuccess(location));
      return location;
    }catch(error){
      String error = 'A location error occurred';
      emit(LocationError(error, ErrorStates.other));
      return Future.error(error);
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
  }

}
