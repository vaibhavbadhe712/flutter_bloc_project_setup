import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../core/constants/api_constants.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/trip_logs_response_entity.dart';
import '../datasources/local/trip_logs_local_datasource.dart';
import '../datasources/remote/trip_logs_remote_datasource.dart';
import 'trip_logs_repository.dart';

@LazySingleton(as: TripLogsRepository)
class TripLogsRepositoryImpl implements TripLogsRepository {
  final TripLogsRemoteDataSource remoteDataSource;
  final TripLogsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TripLogsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, TripLogsResponseEntity>> getTripLogs(String tripId) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getTripLogs(
          tripId,
          authorization: 'Bearer ${ApiConstants.bearerToken}',
        );
        
        // Cache the response
        await localDataSource.cacheTripLogs(tripId, response);
        return Right(response);
      } else {
        // Try to get cached data
        final cachedResponse = await localDataSource.getCachedTripLogs(tripId);
        if (cachedResponse != null) {
          return Right(cachedResponse);
        } else {
          return const Left(NetworkFailure('No internet connection and no cached data'));
        }
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
