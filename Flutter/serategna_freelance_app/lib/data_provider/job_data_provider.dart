import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:serategna_freelance_app/constants/constants.dart';
import 'package:serategna_freelance_app/models/job_model.dart';
import 'package:serategna_freelance_app/models/job_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobDataProvider {
  // final _baseUrl = 'http://192.168.122.1:5050';
  final http.Client httpClient;

  JobDataProvider({@required this.httpClient});

  Future<String> pref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    return token;
  }

  Future<String> prefJob() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = pref.getString("id");
    return userId;
  }

  Future<JobModel> createJob(JobModel job) async {
    final token = await pref();
    final userId = await prefJob();
    final response = await httpClient.post(
      Uri.http('192.168.1.100:5000', '/jobs'),
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

    if (response.statusCode == 201) {
      return JobModel.fromJson(jsonDecode(response.body));
    } else
      throw Exception(jsonDecode(response.body)["message"]);
  }

  Future<List<JobModel>> getJobs() async {
    final token = await pref();
    final http.Response response =
        await httpClient.get(Uri.parse('${Constants.baseUrl}/jobs'), headers: {
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
    final token = await pref();
    final http.Response response = await httpClient
        .get(Uri.parse('${Constants.baseUrl}/jobs/$id'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 200)
      return JobModel.fromJson(jsonDecode(response.body));
    else
      throw Exception(jsonDecode(response.body)["message"]);
  }

  Future<void> deleteJob(String id) async {
    final token = await pref();
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
    final token = await pref();
    Map<String, dynamic> body = {
      "title": job.title,
      "description": job.description,
      "company": job.company,
      "salary": job.salary,
      "position": job.position,
      "jobType": job.jobType,
    };
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
