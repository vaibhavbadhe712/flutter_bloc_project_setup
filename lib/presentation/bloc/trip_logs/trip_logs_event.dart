import 'package:equatable/equatable.dart';

abstract class TripLogsEvent extends Equatable {
  const TripLogsEvent();

  @override
  List<Object> get props => [];
}

class GetTripLogsEvent extends TripLogsEvent {
  final String tripId;

  const GetTripLogsEvent(this.tripId);

  @override
  List<Object> get props => [tripId];
}

class RefreshTripLogsEvent extends TripLogsEvent {
  final String tripId;

  const RefreshTripLogsEvent(this.tripId);

  @override
  List<Object> get props => [tripId];
}
