// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../data/datasources/local/trip_logs_local_datasource.dart' as _i525;
import '../../data/datasources/local/user_local_datasource.dart' as _i533;
import '../../data/datasources/remote/trip_logs_remote_datasource.dart'
    as _i402;
import '../../data/datasources/remote/user_remote_datasource.dart' as _i50;
import '../../data/repositories/trip_logs_repository.dart' as _i1025;
import '../../data/repositories/trip_logs_repository_impl.dart' as _i16;
import '../../data/repositories/user_repository_impl.dart' as _i790;
import '../../domain/repositories/user_repository.dart' as _i271;
import '../../domain/usecases/get_trip_logs_usecase.dart' as _i733;
import '../../domain/usecases/get_user_by_id_usecase.dart' as _i701;
import '../../domain/usecases/get_users_usecase.dart' as _i897;
import '../../presentation/bloc/trip_logs/trip_logs_bloc.dart' as _i221;
import '../../presentation/bloc/user/user_bloc.dart' as _i298;
import '../network/dio_client.dart' as _i667;
import '../network/network_info.dart' as _i932;
import '../storage/local_storage.dart' as _i329;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final storageModule = _$StorageModule();
    final networkModule = _$NetworkModule();
    final tripLogsDataSourceModule = _$TripLogsDataSourceModule();
    final dataSourceModule = _$DataSourceModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => storageModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i895.Connectivity>(() => networkModule.connectivity);
    gh.lazySingleton<_i402.TripLogsRemoteDataSource>(() =>
        tripLogsDataSourceModule.tripLogsRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i50.UserRemoteDataSource>(
        () => dataSourceModule.userRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i932.NetworkInfo>(
        () => _i932.NetworkInfoImpl(gh<_i895.Connectivity>()));
    gh.lazySingleton<_i329.LocalStorage>(
        () => _i329.LocalStorageImpl(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i525.TripLogsLocalDataSource>(
        () => _i525.TripLogsLocalDataSourceImpl(gh<_i329.LocalStorage>()));
    gh.lazySingleton<_i533.UserLocalDataSource>(
        () => _i533.UserLocalDataSourceImpl(gh<_i329.LocalStorage>()));
    gh.lazySingleton<_i271.UserRepository>(() => _i790.UserRepositoryImpl(
          remoteDataSource: gh<_i50.UserRemoteDataSource>(),
          localDataSource: gh<_i533.UserLocalDataSource>(),
          networkInfo: gh<_i932.NetworkInfo>(),
        ));
    gh.lazySingleton<_i1025.TripLogsRepository>(
        () => _i16.TripLogsRepositoryImpl(
              remoteDataSource: gh<_i402.TripLogsRemoteDataSource>(),
              localDataSource: gh<_i525.TripLogsLocalDataSource>(),
              networkInfo: gh<_i932.NetworkInfo>(),
            ));
    gh.factory<_i897.GetUsersUseCase>(
        () => _i897.GetUsersUseCase(gh<_i271.UserRepository>()));
    gh.factory<_i701.GetUserByIdUseCase>(
        () => _i701.GetUserByIdUseCase(gh<_i271.UserRepository>()));
    gh.factory<_i298.UserBloc>(() => _i298.UserBloc(
          getUsersUseCase: gh<_i897.GetUsersUseCase>(),
          getUserByIdUseCase: gh<_i701.GetUserByIdUseCase>(),
        ));
    gh.factory<_i733.GetTripLogsUseCase>(
        () => _i733.GetTripLogsUseCase(gh<_i1025.TripLogsRepository>()));
    gh.factory<_i221.TripLogsBloc>(() =>
        _i221.TripLogsBloc(getTripLogsUseCase: gh<_i733.GetTripLogsUseCase>()));
    return this;
  }
}

class _$StorageModule extends _i329.StorageModule {}

class _$NetworkModule extends _i667.NetworkModule {}

class _$TripLogsDataSourceModule extends _i402.TripLogsDataSourceModule {}

class _$DataSourceModule extends _i50.DataSourceModule {}
