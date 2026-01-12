import 'package:clean_architecture/features/profile/data/models/profile_model.dart';
import 'package:hive/hive.dart';

abstract class ProfileRemoteDataSource {
  Future<List<ProfileModel>> getAllUser(int page);
  Future<ProfileModel> getUser(int id);
}

class ProfileLocalDataSource extends ProfileRemoteDataSource {
  final Box box;

  ProfileLocalDataSource({required this.box});

  @override
  Future<List<ProfileModel>> getAllUser(int page) async {
    return box.get('getAllUser');
  }

  @override
  Future<ProfileModel> getUser(int id) async {
    return box.get('getUser_$id');
  }
}
