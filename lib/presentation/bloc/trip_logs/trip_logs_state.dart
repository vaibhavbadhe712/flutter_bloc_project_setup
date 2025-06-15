import 'package:equatable/equatable.dart';
import '../../../domain/entities/trip_logs_response_entity.dart';

abstract class TripLogsState extends Equatable {
  const TripLogsState();

  @override
  List<Object> get props => [];
}

class TripLogsInitial extends TripLogsState {
  const TripLogsInitial();
}

class TripLogsLoading extends TripLogsState {
  const TripLogsLoading();
}

class TripLogsRefreshing extends TripLogsState {
  final TripLogsResponseEntity response;
  
  const TripLogsRefreshing(this.response);
  
  @override
  List<Object> get props => [response];
}

class TripLogsLoaded extends TripLogsState {
  final TripLogsResponseEntity response;

  const TripLogsLoaded(this.response);

  @override
  List<Object> get props => [response];
}

class TripLogsError extends TripLogsState {
  final String message;

  const TripLogsError(this.message);

  @override
  List<Object> get props => [message];
}
