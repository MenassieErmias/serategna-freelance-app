import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:serategna_freelance_app/constants/constants.dart';
import 'package:serategna_freelance_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataProvider {
  // final _baseUrl = 'http://192.168.122.1:5050';
  final http.Client httpClient;

  UserDataProvider({@required this.httpClient});

  Future<String> pref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    return token;
  }

  Future<UserModel> loginUser(UserModel user) async {
    final response = await httpClient.post(
      Uri.http('192.168.1.103:5000', '/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{"email": user.email, "password": user.password}),
    );

    if (response.statusCode == 200)
      return UserModel.fromJson(jsonDecode(response.body));
    else
      throw Exception(jsonDecode(response.body)["message"]);
  }

  Future<UserModel> registerUser(UserModel user) async {
    final response = await httpClient.post(
      Uri.http('192.168.1.103:5000', '/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "email": user.email,
        "password": user.password,
        "fullName": user.fullName,
        "phoneNumber": user.phoneNumber,
        "profession": user.profession,
        "role": user.role.toUpperCase()
      }),
    );

    if (response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else
      throw Exception(jsonDecode(response.body)["message"]);
  }

  Future<void> deleteUser(String id) async {
    final token = await pref();
    final response = await httpClient.delete(
      Uri.parse('${Constants.baseUrl}/users/$id'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    if (response.statusCode != 204) {
      throw Exception("error deleting user");
    }
  }

  Future<void> updateUser(UserModel user) async {
    final token = await pref();
    Map<String, dynamic> body1 = {
      'fullName': user.fullName,
      'email': user.email,
      'password': user.password,
      'role': user.role,
      'phoneNumber': user.phoneNumber,
    };
    Map<String, dynamic> body2 = {
      'fullName': user.fullName,
      'email': user.email,
      'role': user.role,
      'phoneNumber': user.phoneNumber
    };
    final http.Response response = await httpClient.put(
      Uri.parse('${Constants.baseUrl}/users/${user.id}'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
      body: jsonEncode(user.password != null ? body1 : body2),
    );

    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)["message"]);
    }
  }

  Future<void> updateSelf(UserModel user) async {
    final token = await pref();
    Map<String, dynamic> body = {
      'fullName': user.fullName,
      'email': user.email,
      'profession': user.profession,
      'phoneNumber': user.phoneNumber
    };
    if (user.password != null) {
      body["password"] = user.password;
    }
    final http.Response response = await httpClient.put(
      Uri.parse('${Constants.baseUrl}/users/update'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)["message"]);
    }
  }

  Future<List<UserModel>> getEmployers() async {
    final token = await pref();
    final http.Response response = await httpClient
        .get(Uri.parse('${Constants.baseUrl}/users/employers'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print("employer");
      final users = jsonDecode(response.body) as List;
      // print("getusers $users");
      return users.map((user) => UserModel.fromJson(user)).toList();
    } else {
      throw Exception(jsonDecode(response.body)["message"]);
    }
  }

  Future<List<UserModel>> getFreelancers() async {
    final token = await pref();
    final http.Response response = await httpClient
        .get(Uri.parse('${Constants.baseUrl}/users/freelancers'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final users = jsonDecode(response.body) as List;
      // print("getusers $users");
      return users.map((user) => UserModel.fromJson(user)).toList();
    } else {
      throw Exception(jsonDecode(response.body)["message"]);
    }
  }

  Future<UserModel> getUserByID(String id) async {
    final token = await pref();
    final http.Response response = await httpClient
        .get(Uri.parse('${Constants.baseUrl}/users/$id'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 200)
      return UserModel.fromJson(jsonDecode(response.body));
    else
      throw Exception(jsonDecode(response.body)["message"]);
  }
}
