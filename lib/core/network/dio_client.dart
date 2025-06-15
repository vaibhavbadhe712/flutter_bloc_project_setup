import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../constants/api_constants.dart';
import '../utils/logger.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio get dio {
    final dio = Dio();
    
    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: Duration(milliseconds: ApiConstants.connectTimeout),
      receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        // response: true,
        error: true,
        requestHeader: true,
        responseHeader: false,
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => AppLogger.d(obj.toString()),
      ),
    );
    
    return dio;
  }
  
  @lazySingleton
  Connectivity get connectivity => Connectivity();
}

