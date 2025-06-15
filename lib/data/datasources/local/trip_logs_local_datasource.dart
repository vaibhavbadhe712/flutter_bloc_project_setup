import 'package:injectable/injectable.dart';
import '../../../core/storage/local_storage.dart';
import '../../models/trip_logs_response_model.dart';
import '../../models/trip_log_model.dart';
import 'dart:convert';

abstract class TripLogsLocalDataSource {
  Future<TripLogsResponseModel?> getCachedTripLogs(String tripId);
  Future<void> cacheTripLogs(String tripId, TripLogsResponseModel response);
  Future<void> clearTripLogsCache();
}

@LazySingleton(as: TripLogsLocalDataSource)
class TripLogsLocalDataSourceImpl implements TripLogsLocalDataSource {
  final LocalStorage localStorage;
  
  TripLogsLocalDataSourceImpl(this.localStorage);
  
  static const String _tripLogsKey = 'cached_trip_logs_';
  
  @override
  Future<TripLogsResponseModel?> getCachedTripLogs(String tripId) async {
    try {
      final cacheKey = '$_tripLogsKey$tripId';
      final cachedData = await localStorage.getString(cacheKey);
      
      if (cachedData != null) {
        final Map<String, dynamic> json = jsonDecode(cachedData);
        return TripLogsResponseModel.fromJson(json);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
  
  @override
  Future<void> cacheTripLogs(String tripId, TripLogsResponseModel response) async {
    try {
      final cacheKey = '$_tripLogsKey$tripId';
      final jsonString = jsonEncode(response.toJson());
      await localStorage.saveString(cacheKey, jsonString);
    } catch (e) {
      // Handle caching error
    }
  }
  
  @override
  Future<void> clearTripLogsCache() async {
    try {
      // Clear all trip logs cache
      // Note: This is a simplified approach. In production, you might want
      // to keep track of all cached trip IDs for efficient clearing
      await localStorage.clear();
    } catch (e) {
      // Handle clearing error
    }
  }
}
