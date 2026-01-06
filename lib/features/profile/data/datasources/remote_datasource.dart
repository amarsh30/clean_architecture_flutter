import 'dart:convert';

import 'package:clean_architecture/features/profile/data/models/profile_model.dart';
import 'package:http/http.dart' as http;

abstract class ProfileRemoteDatasource {
  Future<List<ProfileModel>> getAllUser(int page);
  Future<ProfileModel> getUser(int id);
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  @override
  Future<List<ProfileModel>> getAllUser(int page) async {
    Uri uri = Uri.parse('https://reqres.in/api/users?page=$page');
    var response = await http.get(uri);

    Map<String, dynamic> dataBody = json.decode(response.body);
    List<Map<String, dynamic>> data = dataBody['data'];
    return ProfileModel.fromJsonList(data);
  }

  @override
  Future<ProfileModel> getUser(int id) async {
    Uri uri = Uri.parse('https://reqres.in/api/users/$id');
    var response = await http.get(uri);

    Map<String, dynamic> dataBody = json.decode(response.body);
    Map<String, dynamic> data = dataBody['data'];
    return ProfileModel.fromJson(data);
  }
}
