import 'package:animal_photos/core/input_converter/input_converter.dart';
import 'package:animal_photos/core/network/network_info.dart';
import 'package:animal_photos/features/animal_photos/data/api_client/api_client.dart';
import 'package:animal_photos/features/animal_photos/data/data_source/animal_remote_source.dart';
import 'package:animal_photos/features/animal_photos/data/repository/animal_repository_implementaion.dart';
import 'package:animal_photos/features/animal_photos/domain/repository/animal_repository.dart';
import 'package:animal_photos/features/animal_photos/domain/use_case/getBirdsPhotos.dart';
import 'package:animal_photos/features/animal_photos/presentation/bloc/animal_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/animal_photos/data/data_source/animal_local_source.dart';
import '../../features/animal_photos/domain/use_case/getDogsPhotos.dart';

final sl = GetIt.instance;
Future<void> init() async{
  //bloc
  sl.registerFactory(
      () => AnimalBloc(birds: sl(), dogs: sl(), converter: sl()));

  //usecase
  sl.registerLazySingleton(() => GetBirdsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetDogsUseCase(repository: sl()));

  //repository
  sl.registerLazySingleton<AnimalRepository>(() =>
      AnimalRepositoryImplementaion(network: sl(), remote: sl(), local: sl()));

  //data sources
  sl.registerLazySingleton<AnimalRemoteDataSource>(
      () => AnimalRemoteDataSourceImplementation(animalClient: sl()));
  sl.registerLazySingleton<AnimalLocalDataSource>(
      () => AnimalLoaclDataSourceImplementaion(preferences: sl()));
  sl.registerLazySingleton(() => AnimalClient());

  //core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplementation());
  sl.registerLazySingleton(() => InputConverter());

  //extrnal
  final sharedPers = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPers); 
  // sl.registerLazySingleton(() => Dio());
  // sl.registerLazySingleton(() => ConnectivityResult);

  
}
