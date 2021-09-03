import 'package:equatable/equatable.dart';
import 'package:serategna_freelance_app/models/job_model.dart';

class JobState extends Equatable {
  const JobState();

  @override
  List<Object> get props => [];
}

class JobLoading extends JobState {}

class JobLoadSuccess extends JobState {
  final List<JobModel> jobs;

  JobLoadSuccess([this.jobs = const []]);
  @override
  List<Object> get props => [jobs];
}

class JobByIdLoadSuccess extends JobState {
  final JobModel job;
  JobByIdLoadSuccess({this.job});
  List<Object> get props => [job];
  @override
  String toString() => 'Loaded job $job';
}

class JobOperationFailure extends JobState {
  final String message;
  JobOperationFailure({this.message});
  @override
  List<Object> get props => [message];
}
