import 'package:equatable/equatable.dart';
import 'package:serategna_freelance_app/data_layer/models/job_model.dart';

abstract class JobEvent extends Equatable {
  const JobEvent();
}

class JobLoad extends JobEvent {
  const JobLoad();

  @override
  List<Object> get props => [];
}

class JobCreate extends JobEvent {
  final JobModel job;
  const JobCreate(this.job);

  @override
  List<Object> get props => [job];

  @override
  String toString() => 'Job Created {job: $job}';
}

class JobUpdate extends JobEvent {
  final JobModel job;
  const JobUpdate(this.job);

  @override
  List<Object> get props => [job];

  @override
  String toString() => 'Job Updated {job: $job}';
}

class JobDetail extends JobEvent {
  final String id;

  JobDetail(this.id);
  @override
  List<Object> get props => [id];

  @override
  toString() => 'Job Detail';
}

class JobDelete extends JobEvent {
  final JobModel job;
  const JobDelete({this.job});

  @override
  List<Object> get props => [job];

  @override
  toString() => 'Job Deleted {job: $job}';
}
