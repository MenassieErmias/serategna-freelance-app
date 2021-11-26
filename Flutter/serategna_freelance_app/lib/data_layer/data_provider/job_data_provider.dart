import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:serategna_freelance_app/constants/constants.dart';
import 'package:serategna_freelance_app/data_layer/models/job_model.dart';
import 'package:serategna_freelance_app/utils/pref_functions.dart';

class JobDataProvider {
  final http.Client httpClient;

  JobDataProvider({@required this.httpClient});
  LocallyStored locallyStored = LocallyStored();

  Future<void> createJob(JobModel job) async {
    final token = await locallyStored.getToken();
    final userId = await locallyStored.prefUser();
    final response = await httpClient.post(
      Uri.http('172.20.7.192:5000', '/jobs'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        "title": job.title,
        "employer": userId,
        "description": job.description,
        "company": job.company,
        "salary": job.salary,
        "position": job.position,
        "jobType": job.jobType,
      }),
    );

    if (response.statusCode != 201)
      throw Exception(jsonDecode(response.body)["message"]);
  }

  Future<List<JobModel>> getJobs() async {
    final token = await locallyStored.getToken();
    final userId = await locallyStored.prefUser();
    final role = await locallyStored.getRole();
    String endpoint = role == Constants.EMPLOYER ? 'jobs/own/$userId' : 'jobs';
    final http.Response response = await httpClient
        .get(Uri.parse('${Constants.baseUrl}/$endpoint'), headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final jobs = jsonDecode(response.body) as List;
      // print("getjobs $jobs");
      return jobs.map((job) => JobModel.fromJson(job)).toList();
    } else {
      throw Exception(jsonDecode(response.body)["message"]);
    }
  }

  Future<JobModel> getJobByID(String id) async {
    final token = await locallyStored.getToken();
    final http.Response response = await httpClient
        .get(Uri.parse('${Constants.baseUrl}/jobs/$id'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print('from by id: ${response.body}');
      return JobModel.fromJson(jsonDecode(response.body));
    } else
      throw Exception(jsonDecode(response.body)["message"]);
  }

  Future<void> deleteJob(String id) async {
    final token = await locallyStored.getToken();
    final response = await httpClient.delete(
      Uri.parse('${Constants.baseUrl}/jobs/$id'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)["message"]);
    }
  }

  Future<void> updateJob(JobModel job) async {
    final token = await locallyStored.getToken();
    Map<String, dynamic> body = {
      "title": job.title,
      "description": job.description,
      "company": job.company,
      "salary": job.salary,
      "position": job.position,
      "jobType": job.jobType,
    };
    print("job id ${job.id == null ? job.id : null}");
    final http.Response response = await httpClient.put(
      Uri.parse('${Constants.baseUrl}/jobs/${job.id}'),
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
