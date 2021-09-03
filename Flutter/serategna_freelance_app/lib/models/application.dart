import 'package:equatable/equatable.dart';

class ApplicationModel extends Equatable {
  ApplicationModel({
    this.freelancer,
    this.id,
    this.job,
    this.coverLetter,
    this.applicationStatus,
  });
  final String id, coverLetter, applicationStatus;
  final Map<String, dynamic> freelancer, job;
  @override
  List<Object> get props => [
        id,
        freelancer,
        coverLetter,
        applicationStatus,
        job,
      ];

  factory ApplicationModel.fromJson(Map<String, dynamic> json) {
    return ApplicationModel(
        id: json['_id'],
        job: json['jobId'],
        freelancer: json['freelancerId'],
        coverLetter: json["coverLetter"],
        applicationStatus: json['applicationStatus']);
  }

  @override
  String toString() =>
      'ApplicationModel { id: $id, jobId: $job, coverLetter: $coverLetter, freelancer:$freelancer}';
}
