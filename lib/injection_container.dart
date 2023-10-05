// ignore_for_file: cascade_invocations

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/adapters/http/dio_adapter.dart';
import 'core/adapters/http/http_adapter.dart';
import 'core/adapters/local_storage/local_storage_adapter.dart';
import 'core/adapters/local_storage/shared_preferences_adapter.dart';
import 'core/adapters/location/geolocator_adapter.dart';
import 'core/adapters/location/location_adapter.dart';
import 'core/adapters/network/internet_network_adapter.dart';
import 'core/adapters/network/network_adapter.dart';
import 'features/location/data/datasources/location_api_data_source.dart';
import 'features/location/data/datasources/location_gps_data_source.dart';
import 'features/location/data/datasources/location_local_data_source.dart';
import 'features/location/data/repositories/location_repository_impl.dart';
import 'features/location/domain/repositories/location_repository.dart';
import 'features/location/domain/usecases/get_coordinates.dart';
import 'features/location/domain/usecases/get_location_histories.dart';
import 'features/location/domain/usecases/save_location_histories.dart';
import 'features/location/presentation/bloc/location_bloc.dart';
import 'features/location/presentation/widgets/location_history/bloc/location_history_bloc.dart';

///
final sl = GetIt.instance;

///
Future<void> init() async {
  //! Features - Location
  // Bloc
  sl.registerFactory(
    () => LocationHistoryBloc(
      locationBloc: sl(),
      getLocationHistories: sl(),
      saveLocationHistories: sl(),
    ),
  );
  sl.registerFactory(() => LocationBloc(getCoordinates: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetCoordinates(sl()));
  sl.registerLazySingleton(() => SaveLocationHistories(sl()));
  sl.registerLazySingleton(() => GetLocationHistories(sl()));

  // Repository
  sl.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(
      locationApiDataSource: sl(),
      locationGpsDataSource: sl(),
      locationLocalDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<LocationGpsDataSource>(
    () => LocationGpsDataSourceImpl(locationAdapter: sl()),
  );
  sl.registerLazySingleton<LocationApiDataSource>(
    () => LocationApiDataSourceImpl(httpAdapter: sl(), networkAdapter: sl()),
  );
  sl.registerLazySingleton<LocationLocalDataSource>(
    () => LocationLocalDataSourceImpl(localStorageAdapter: sl()),
  );

  //! Core
  sl.registerLazySingleton<LocationAdapter>(GeolocatorAdapter.new);
  sl.registerLazySingleton<NetworkAdapter>(InternetNetworkAdapter.new);
  sl.registerLazySingleton<HttpAdapter>(DioAdapter.new);
  sl.registerLazySingleton<LocalStorageAdapter>(
    () => SharedPreferencesAdapter(sl()),
  );

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
