import 'dart:convert';

import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/features/profile/data/models/profile_model.dart';
import 'package:http/http.dart' as http;

abstract class ProfileRemoteDataSource {
  Future<List<ProfileModel>> getAllUser(int page);
  Future<ProfileModel> getUser(int id);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final http.Client client;

  // REAL CLASS / FAKE CLASS
  ProfileRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProfileModel>> getAllUser(int page) async {
    Uri uri = Uri.parse('https://reqres.in/api/users?page=$page');
    var response = await http.get(uri);

    if (response.statusCode != 200) {
      Map<String, dynamic> dataBody = json.decode(response.body);
      List<dynamic> data = dataBody['data'];
      return ProfileModel.fromJsonList(data);
    } else if (response.statusCode == 404) {
      throw EmptyException(message: "Data Not Found - error 404");
    } else {
      throw const GeneralException(message: 'Failed to load user');
    }
  }

  @override
  Future<ProfileModel> getUser(int id) async {
    Uri uri = Uri.parse('https://reqres.in/api/users/$id');
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> dataBody = jsonDecode(response.body);
      Map<String, dynamic> data = dataBody['data'];
      return ProfileModel.fromJson(data);
    } else if (response.statusCode == 404) {
      throw EmptyException(message: "Data Not Found - error 404");
    } else {
      throw const GeneralException(message: 'Failed to load user');
    }
  }
}
