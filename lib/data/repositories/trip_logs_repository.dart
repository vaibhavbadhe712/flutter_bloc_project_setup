import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/trip_logs_response_entity.dart';

abstract class TripLogsRepository {
  Future<Either<Failure, TripLogsResponseEntity>> getTripLogs(String tripId);
}
