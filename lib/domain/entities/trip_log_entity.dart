import 'package:equatable/equatable.dart';

class TripLogEntity extends Equatable {
  final String logId;
  final String tripId;
  final DateTime endTime;
  final DateTime startTime;
  final String activityType;
  final String createdBy;
  final String updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TripLogEntity({
    required this.logId,
    required this.tripId,
    required this.endTime,
    required this.startTime,
    required this.activityType,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  // Helper method to get duration
  Duration get duration => endTime.difference(startTime);

  // Helper method to format activity type
  String get formattedActivityType {
    return activityType.split('_').map((word) => 
      word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1)
    ).join(' ');
  }

  @override
  List<Object?> get props => [
    logId, tripId, endTime, startTime, activityType,
    createdBy, updatedBy, createdAt, updatedAt,
  ];
}
