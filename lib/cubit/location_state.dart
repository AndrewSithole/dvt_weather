part of 'location_cubit.dart';
enum LocationStatus { initial, loading, success, error }

extension LocationStatusX on LocationStatus {
  bool get isInitial => this == LocationStatus.initial;
  bool get isLoading => this == LocationStatus.loading;
  bool get isSuccess => this == LocationStatus.success;
  bool get isFailure => this == LocationStatus.error;
}

final class LocationState extends Equatable {
  const LocationState({
    this.status = LocationStatus.initial,
    this.position,
    this.errorMessage
  });

  final LocationStatus status;
  final Position? position;
  final String? errorMessage;

  LocationState copyWith({
    LocationStatus? status,
    Position? position,
    String? errorMessage,
  }) {
    return LocationState(
      status: status ?? this.status,
      position: position ?? this.position,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, position, errorMessage];
}
