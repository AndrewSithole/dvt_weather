part of 'location_cubit.dart';

@immutable
abstract class LocationState {
  final Position position = Position.fromMap({
    "latitude": 10.058494,
    "longitude": 40.162310,
  });
}
enum ErrorStates {
  serviceDisabled,
  permissionDenied,
  permanentlyDenied,
  other,
}

class LocationInitial extends LocationState {}
class LocationLoading extends LocationState {}
class LocationSuccess extends LocationState {
  final Position position;
  LocationSuccess(this.position);
}
class LocationError extends LocationState {
  final String error;
  final ErrorStates errorState;
  LocationError(this.error, this.errorState);
}
