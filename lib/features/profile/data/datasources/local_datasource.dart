import 'package:clean_architecture/features/profile/data/models/profile_model.dart';
import 'package:hive/hive.dart';

abstract class ProfileRemoteDataSource {
  Future<List<ProfileModel>> getAllUser(int page);
  Future<ProfileModel> getUser(int id);
}

class ProfileLocalDataSourceImplementation extends ProfileRemoteDataSource {
  final HiveInterface hive;

  ProfileLocalDataSourceImplementation({required this.hive});

  @override
  Future<List<ProfileModel>> getAllUser(int page) async {
    var box = await hive.openBox('profileBox');
    return box.get('getAllUser');
  }

  @override
  Future<ProfileModel> getUser(int id) async {
    var box = await hive.openBox('profileBox');
    return box.get('getUser_$id');
  }
}
