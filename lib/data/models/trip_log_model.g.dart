// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripLogModel _$TripLogModelFromJson(Map<String, dynamic> json) => TripLogModel(
      logId: json['logId'] as String,
      tripId: json['tripId'] as String,
      endTime: DateTime.parse(json['endTime'] as String),
      startTime: DateTime.parse(json['startTime'] as String),
      activityType: json['activityType'] as String,
      createdBy: json['createdBy'] as String,
      updatedBy: json['updatedBy'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$TripLogModelToJson(TripLogModel instance) =>
    <String, dynamic>{
      'logId': instance.logId,
      'tripId': instance.tripId,
      'endTime': instance.endTime.toIso8601String(),
      'startTime': instance.startTime.toIso8601String(),
      'activityType': instance.activityType,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
