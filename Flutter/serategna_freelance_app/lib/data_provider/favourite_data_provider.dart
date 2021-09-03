import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:serategna_freelance_app/constants/constants.dart';
import 'package:serategna_freelance_app/models/favourite_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteDataProvider {
  final http.Client httpClient;

  FavouriteDataProvider({@required this.httpClient});

  Future<String> pref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    return token;
  }

  Future<FavouriteModel> AddToFavourites(
      FavouriteModel favourite, String jobId) async {
    final token = await pref();
    final response = await httpClient.post(
      Uri.http('192.168.1.103:5000', '/favourites'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'favourite/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        "jobId": jobId,
      }),
    );

    if (response.statusCode == 201) {
      return FavouriteModel.fromJson(jsonDecode(response.body));
    } else
      throw Exception(jsonDecode(response.body)["message"]);
  }

  Future<List<FavouriteModel>> getFavourites() async {
    final token = await pref();
    final http.Response response = await httpClient
        .get(Uri.parse('${Constants.baseUrl}/favourites'), headers: {
      HttpHeaders.contentTypeHeader: 'favourite/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final favourites = jsonDecode(response.body) as List;
      // print("getfavourites $favourites");
      return favourites
          .map((favourite) => FavouriteModel.fromJson(favourite))
          .toList();
    } else {
      throw Exception(jsonDecode(response.body)["message"]);
    }
  }

  Future<void> removeFromFavourites(String id) async {
    final token = await pref();
    final response = await httpClient.delete(
      Uri.parse('${Constants.baseUrl}/favourites/$id'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'favourite/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)["message"]);
    }
  }
}
