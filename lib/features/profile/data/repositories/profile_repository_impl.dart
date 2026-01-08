import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/profile/data/datasources/local_datasource.dart';
import 'package:clean_architecture/features/profile/data/models/profile_model.dart';
import 'package:clean_architecture/features/profile/domain/entities/profile.dart';
import 'package:clean_architecture/features/profile/domain/repositories/profile_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  final ProfileLocalDataSource profileLocalDataSource;
  final HiveInterface hive;

  ProfileRepositoryImpl({
    required this.profileRemoteDataSource,
    required this.profileLocalDataSource,
    required this.hive,
  });

  @override
  Future<Either<Failure, List<Profile>>> getAllUser(int page) async {
    try {
      // check internet
      final List<ConnectivityResult> connectivityResult = await (Connectivity()
          .checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        // No available connection
        // Ngambil dari Local Data Source
        List<ProfileModel> hasil = await profileLocalDataSource.getAllUser(
          page,
        );
        return Right(hasil);
      } else {
        // Available connection
        // Ngambil dari Remote Data Source
        List<ProfileModel> hasil = await profileRemoteDataSource.getAllUser(
          page,
        );
        // Put last data profile ke Box Local
        var box = hive.box('profile_box');
        box.put('getAllUser', hasil);
        return Right(hasil);
      }
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Profile>> getUser(int id) async {
    try {
      // check internet
      final List<ConnectivityResult> connectivityResult = await (Connectivity()
          .checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        // No available connection
        // Ngambil dari Local Data Source
        ProfileModel hasil = await profileLocalDataSource.getUser(id);
        return Right(hasil);
      } else {
        // Available connection
        // Ngambil dari Remote Data Source
        ProfileModel hasil = await profileRemoteDataSource.getUser(id);
        // Put last data profile ke Box Local
        var box = hive.box('profile_box');
        box.put('getUser', hasil);
        return Right(hasil);
      }
    } catch (e) {
      return Left(Failure());
    }
  }
}
