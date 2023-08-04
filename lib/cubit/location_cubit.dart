import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(const LocationState());

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    debugPrint("Getting location");

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    debugPrint("Service enabled? ${serviceEnabled.toString()}");
    if (!serviceEnabled) {
      String error = 'Location services are disabled.';
      emit(LocationState(status: LocationStatus.error, errorMessage: error));
      return Future.error(error);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        String error = 'Location permissions are denied';
        emit(LocationState(status: LocationStatus.error, errorMessage: error));
        return Future.error(error);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      String error = 'Location permissions are permanently denied, we cannot request permissions.';
      emit(LocationState(status: LocationStatus.error, errorMessage: error));
      return Future.error(error);
    }
    try{
      Position location = await Geolocator.getCurrentPosition();
      emit(LocationState(status: LocationStatus.success, position: location));
      return location;
    }catch(error){
      String error = 'A location error occurred';
      emit(LocationState(status: LocationStatus.error, errorMessage: error));
      return Future.error(error);
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
  }

}
