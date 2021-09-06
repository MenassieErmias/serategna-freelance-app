import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:serategna_freelance_app/constants/constants.dart';
import 'package:serategna_freelance_app/data_layer/models/favorite_model.dart';
import 'package:serategna_freelance_app/utils/pref_functions.dart';

class FavoriteDataProvider {
  final http.Client httpClient;

  FavoriteDataProvider({@required this.httpClient});
  LocallyStored locallyStored = LocallyStored();
  Future<void> addToFavorites(String jobId) async {
    final token = await locallyStored.getToken();
    print("jobid from addtofav: $jobId");
    final response = await httpClient.post(
      Uri.http('192.168.1.103:5000', '/favorites'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{"jobId": jobId}),
    );

    if (response.statusCode != 201) {
      throw Exception(jsonDecode(response.body)["message"]);
    }
  }

  Future<List<FavoriteModel>> getFavorites() async {
    final token = await locallyStored.getToken();
    final http.Response response = await httpClient
        .get(Uri.parse('${Constants.baseUrl}/favorites'), headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final favorites = jsonDecode(response.body) as List;
      return favorites
          .map((favorite) => FavoriteModel.fromJson(favorite))
          .toList();
    } else {
      throw Exception(jsonDecode(response.body)["message"]);
    }
  }

  Future<void> removeFromFavorites(String id) async {
    final token = await locallyStored.getToken();
    final response = await httpClient.delete(
      Uri.parse('${Constants.baseUrl}/favorites/$id'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)["message"]);
    }
  }
}
