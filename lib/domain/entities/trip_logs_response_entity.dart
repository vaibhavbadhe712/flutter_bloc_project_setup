import 'package:equatable/equatable.dart';
import 'trip_log_entity.dart';

class TripLogsResponseEntity extends Equatable {
  final String message;
  final List<TripLogEntity> data;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  const TripLogsResponseEntity({
    required this.message,
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  @override
  List<Object?> get props => [message, data, total, page, limit, totalPages];
}
