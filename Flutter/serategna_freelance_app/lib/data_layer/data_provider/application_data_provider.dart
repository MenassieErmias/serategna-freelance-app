import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:serategna_freelance_app/constants/constants.dart';
import 'package:serategna_freelance_app/data_layer/models/application_model.dart';
import 'package:serategna_freelance_app/utils/pref_functions.dart';

class ApplicationDataProvider {
  // final _baseUrl = 'http://192.168.122.1:5050';
  final http.Client httpClient;

  ApplicationDataProvider({@required this.httpClient});
  LocallyStored locallyStored = LocallyStored();

  Future<ApplicationModel> createApplication(
      ApplicationModel application, String jobId) async {
    final token = await locallyStored.getToken();
    final response = await httpClient.post(
      Uri.http('172.20.7.192:5000', '/applications'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        "jobId": jobId,
        "coverLetter": application.coverLetter,
      }),
    );

    if (response.statusCode == 201) {
      return ApplicationModel.fromJson(jsonDecode(response.body));
    } else
      throw Exception(jsonDecode(response.body)["message"]);
  }

  Future<List<ApplicationModel>> getApplications() async {
    final token = await locallyStored.getToken();
    final userId = await locallyStored.prefUser();
    final role = await locallyStored.getRole();
    final http.Response response = role == Constants.FREELANCER
        ? await httpClient.get(
            Uri.parse('${Constants.baseUrl}/applications/own/$userId'),
            headers: {
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=UTF-8',
                HttpHeaders.authorizationHeader: 'Bearer $token',
              })
        : role == Constants.EMPLOYER
            ? await httpClient.get(
                Uri.parse('${Constants.baseUrl}/applications/employer/$userId'),
                headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=UTF-8',
                    HttpHeaders.authorizationHeader: 'Bearer $token',
                  })
            : await httpClient
                .get(Uri.parse('${Constants.baseUrl}/applications'), headers: {
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=UTF-8',
                HttpHeaders.authorizationHeader: 'Bearer $token',
              });
    if (response.statusCode == 200) {
      final applications = jsonDecode(response.body) as List;
      // print("getapplications $applications");
      return applications
          .map((application) => ApplicationModel.fromJson(application))
          .toList();
    } else {
      throw Exception(jsonDecode(response.body)["message"]);
    }
  }

  Future<List<ApplicationModel>> getJobApplications(String jobId) async {
    final token = await locallyStored.getToken();
    final http.Response response = await httpClient.get(
        Uri.parse('${Constants.baseUrl}/applications/job/$jobId'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
    if (response.statusCode == 200) {
      final applications = jsonDecode(response.body) as List;
      // print("getapplications $applications");
      return applications
          .map((application) => ApplicationModel.fromJson(application))
          .toList();
    } else {
      throw Exception(jsonDecode(response.body)["message"]);
    }
  }

  Future<ApplicationModel> getApplicationByID(String id) async {
    final token = await locallyStored.getToken();
    final http.Response response = await httpClient
        .get(Uri.parse('${Constants.baseUrl}/applications/$id'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 200)
      return ApplicationModel.fromJson(jsonDecode(response.body));
    else
      throw Exception(jsonDecode(response.body)["message"]);
  }

  Future<void> deleteApplication(String id) async {
    final token = await locallyStored.getToken();
    final response = await httpClient.delete(
      Uri.parse('${Constants.baseUrl}/applications/$id'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)["message"]);
    }
  }

  Future<void> updateApplication(
      ApplicationModel application, String status) async {
    print("update: $application");
    final token = await locallyStored.getToken();
    final role = await locallyStored.getRole();
    Map<String, dynamic> body = {};

    if (role == Constants.EMPLOYER)
      body["applicationStatus"] = status;
    else
      body["coverLetter"] = application.coverLetter;

    print("application id ${application.id == null ? application.id : null}");
    final http.Response response = await httpClient.put(
      Uri.parse('${Constants.baseUrl}/applications/${application.id}'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)["message"]);
    }
  }
}
