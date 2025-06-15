import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/trip_logs_response_entity.dart';
import 'trip_log_model.dart';


@JsonSerializable()
class TripLogsResponseModel extends TripLogsResponseEntity {
  const TripLogsResponseModel({
    required super.message,
    required super.data,
    required super.total,
    required super.page,
    required super.limit,
    required super.totalPages,
  });

  factory TripLogsResponseModel.fromJson(Map<String, dynamic> json) {
    return TripLogsResponseModel(
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((item) => TripLogModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int,
      page: json['page'] as int,
      limit: json['limit'] as int,
      totalPages: json['totalPages'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((tripLog) => (tripLog as TripLogModel).toJson()).toList(),
      'total': total,
      'page': page,
      'limit': limit,
      'totalPages': totalPages,
    };
  }
}