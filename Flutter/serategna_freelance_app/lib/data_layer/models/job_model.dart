import 'package:equatable/equatable.dart';

class JobModel extends Equatable {
  JobModel(
      {this.id,
      this.description,
      this.employer,
      this.position,
      this.title,
      this.company,
      this.jobType,
      this.createdAt,
      this.salary,
      this.isAcceptingApplication});
  final int salary;
  final String id, title, company, position, description, jobType, createdAt;
  final Map<String, dynamic> employer;
  final bool isAcceptingApplication;

  @override
  List<Object> get props => [
        id,
        title,
        employer,
        company,
        position,
        description,
        jobType,
        salary,
        isAcceptingApplication,
        createdAt
      ];

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      company: json['company'],
      employer: json['employer'] != null
          ? json['employer']
          : <String, dynamic>{"fullName": "", "email": "", "role": ""},
      salary: json['salary'],
      jobType: json['jobType'],
      isAcceptingApplication: json['isAcceptingApplication'],
      position: json['position'],
      createdAt: json['createdAt'],
    );
  }

  @override
  String toString() =>
      'JobModel { id: $id, description: $description, createdAt: $createdAt, company:$company}';
}
