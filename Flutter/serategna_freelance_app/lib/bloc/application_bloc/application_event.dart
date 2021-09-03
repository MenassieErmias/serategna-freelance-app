import 'package:equatable/equatable.dart';
import 'package:serategna_freelance_app/models/application_model.dart';

abstract class ApplicationEvent extends Equatable {
  const ApplicationEvent();
}

class ApplicationLoad extends ApplicationEvent {
  const ApplicationLoad();

  @override
  List<Object> get props => [];
}

class ApplicationCreate extends ApplicationEvent {
  final ApplicationModel application;
  final String jobId;
  const ApplicationCreate(this.application, this.jobId);

  @override
  List<Object> get props => [application];

  @override
  String toString() => 'Application Created {application: $application}';
}

class ApplicationUpdate extends ApplicationEvent {
  final ApplicationModel application;
  final String status;
  const ApplicationUpdate(this.application, this.status);

  @override
  List<Object> get props => [application, status];

  @override
  String toString() => 'Application Updated {application: $application}';
}

class ApplicationDelete extends ApplicationEvent {
  final ApplicationModel application;
  const ApplicationDelete({this.application});

  @override
  List<Object> get props => [application];

  @override
  toString() => 'Application Deleted {application: $application}';
}
