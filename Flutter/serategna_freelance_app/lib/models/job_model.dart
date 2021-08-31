import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  UserModel(
      {this.id,
      this.description,
      this.employer,
      this.position,
      this.salary,
      this.title,
      this.company,
      this.jobType,
      this.isAcceptingApplication});
  final String id, title, salary, company, position, description, jobType;
  final Map<String, dynamic> employer;
  final bool isAcceptingApplication;

  @override
  List<Object> get props => [
        id,
        title,
        employer,
        salary,
        company,
        position,
        description,
        jobType,
        isAcceptingApplication
      ];

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
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
      'UserModel { id: $id, description: $description, employer: $employer, company:$company}';
}
