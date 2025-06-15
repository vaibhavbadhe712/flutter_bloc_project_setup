import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/trip_log_entity.dart';

part 'trip_log_model.g.dart';

@JsonSerializable()
class TripLogModel extends TripLogEntity {
  const TripLogModel({
    required super.logId,
    required super.tripId,
    required super.endTime,
    required super.startTime,
    required super.activityType,
    required super.createdBy,
    required super.updatedBy,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TripLogModel.fromJson(Map<String, dynamic> json) {
    return TripLogModel(
      logId: json['log_id'] as String,
      tripId: json['trip_id'] as String,
      endTime: DateTime.parse(json['end_time'] as String),
      startTime: DateTime.parse(json['start_time'] as String),
      activityType: json['activity_type'] as String,
      createdBy: json['created_by'] as String,
      updatedBy: json['updated_by'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'log_id': logId,
      'trip_id': tripId,
      'end_time': endTime.toIso8601String(),
      'start_time': startTime.toIso8601String(),
      'activity_type': activityType,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
