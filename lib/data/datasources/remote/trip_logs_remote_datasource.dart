import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/constants/api_constants.dart';
import '../../models/trip_logs_response_model.dart';

part 'trip_logs_remote_datasource.g.dart';

@RestApi(baseUrl: ApiConstants.tripLogsBaseUrl)
abstract class TripLogsRemoteDataSource {
  @factoryMethod
  factory TripLogsRemoteDataSource(Dio dio) = _TripLogsRemoteDataSource;

  @GET('${ApiConstants.tripLogsEndpoint}/{tripId}')
  Future<TripLogsResponseModel> getTripLogs(
    @Path('tripId') String tripId, {
    @Header('Authorization') String? authorization,
    @Header('Content-Type') String contentType = 'application/json',
  });
}
// Register the data source in dependency injection
@module
abstract class TripLogsDataSourceModule {
  @lazySingleton
  TripLogsRemoteDataSource tripLogsRemoteDataSource(Dio dio) => 
      TripLogsRemoteDataSource(dio);
}
