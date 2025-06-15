import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/constants/api_constants.dart';
import '../../models/user_model.dart';

part 'user_remote_datasource.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class UserRemoteDataSource {
  @factoryMethod
  factory UserRemoteDataSource(Dio dio) = _UserRemoteDataSource;

  @GET(ApiConstants.users)
  Future<List<UserModel>> getUsers();

  @GET('${ApiConstants.users}/{id}')
  Future<UserModel> getUserById(@Path('id') int id);
}

// Register the data source in dependency injection
@module
abstract class DataSourceModule {
  @lazySingleton
  UserRemoteDataSource userRemoteDataSource(Dio dio) => UserRemoteDataSource(dio);
}
