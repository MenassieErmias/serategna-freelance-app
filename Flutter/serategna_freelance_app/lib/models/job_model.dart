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
      this.salary,
      this.isAcceptingApplication});
  final int salary;
  final String id, title, company, position, description, jobType;
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
        isAcceptingApplication
      ];

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
        id: json['_id'],
        title: json['title'],
        description: json['description'],
        company: json['company'],
        salary: json['salary'],
        jobType: json['jobType'],
        isAcceptingApplication: json['isAcceptingApplication'],
        position: json['position']);
  }

  @override
  String toString() =>
      'JobModel { id: $id, description: $description, employer: $employer, company:$company}';
}
