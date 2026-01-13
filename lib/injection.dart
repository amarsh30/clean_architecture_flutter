import 'package:clean_architecture/features/profile/data/datasources/local_datasource.dart';
import 'package:clean_architecture/features/profile/data/datasources/remote_datasource.dart';
import 'package:clean_architecture/features/profile/data/models/profile_model.dart';
import 'package:clean_architecture/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:clean_architecture/features/profile/domain/repositories/profile_repository.dart';
import 'package:clean_architecture/features/profile/domain/usecases/get_all_user.dart';
import 'package:clean_architecture/features/profile/domain/usecases/get_user.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import 'features/profile/presentation/bloc/profile_bloc.dart';

var myinjection = GetIt.instance; // ini merupakan tempat penyimpanan dependency

// MENG-INJECT SEMUA DEPENDENCY YANG DIBUTUHKAN
Future<void> init() async {
  /// GENERAL DEPENDENCY
  // HIVE
  Hive.registerAdapter(ProfileModelAdapter());
  var box = await Hive.openBox('profile_box');

  myinjection.registerLazySingleton(() => box);

  // HTTP CLIENT
  myinjection.registerLazySingleton(() => http.Client());

  /// FEATURES - PROFILE
  // BLOC
  myinjection.registerFactory(
    () => ProfileBloc(getAllUser: myinjection(), getUser: myinjection()),
  );
  // USE CASE
  myinjection.registerLazySingleton(() => GetAllUser(myinjection()));
  myinjection.registerLazySingleton(() => GetUser(myinjection()));

  // REPOSITORY
  myinjection.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      profileRemoteDataSource: myinjection(),
      profileLocalDataSource: myinjection(),
      box: box,
    ),
  );
  // DATA SOURCE
  myinjection.registerFactory<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(box: myinjection()),
  );

  myinjection.registerFactory<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(client: myinjection()),
  );
}
