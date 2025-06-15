import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../core/errors/failures.dart';
import '../../data/repositories/trip_logs_repository.dart';
import '../entities/trip_logs_response_entity.dart';

@injectable
class GetTripLogsUseCase {
  final TripLogsRepository repository;

  GetTripLogsUseCase(this.repository);

  Future<Either<Failure, TripLogsResponseEntity>> call(String tripId) async {
    return await repository.getTripLogs(tripId);
  }
}