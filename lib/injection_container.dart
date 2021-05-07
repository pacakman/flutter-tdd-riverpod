import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app_tdd_riverpod/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:flutter_app_tdd_riverpod/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:flutter_app_tdd_riverpod/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:flutter_app_tdd_riverpod/features/number_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'package:flutter_app_tdd_riverpod/features/number_trivia/domain/use_cases/get_random_number_trivia.dart';
import 'package:flutter_app_tdd_riverpod/features/number_trivia/presentation/view_models/number_trivia_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/data_connection_checker.dart';
import 'core/util/input_converter.dart';
import 'features/number_trivia/domain/repositories/number_trivia_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => NumberTriviaViewModel(sl(), sl()));

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(dio: sl()));

  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));

  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => DataConnectionChecker());
}
