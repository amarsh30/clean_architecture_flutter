import 'package:clean_architecture/features/profile/data/models/profile_model.dart';
import 'package:hive/hive.dart';

abstract class ProfileLocalDataSource {
  Future<List<ProfileModel>> getAllUser(int page);
  Future<ProfileModel> getUser(int id);
}

class ProfileLocalDataSourceImpl extends ProfileLocalDataSource {
  final Box box;

  ProfileLocalDataSourceImpl({required this.box});

  @override
  Future<List<ProfileModel>> getAllUser(int page) async {
    return box.get('getAllUser');
  }

  @override
  Future<ProfileModel> getUser(int id) async {
    return box.get('getUser_$id');
  }
}
