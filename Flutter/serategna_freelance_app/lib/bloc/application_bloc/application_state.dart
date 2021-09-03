import 'package:equatable/equatable.dart';
import 'package:serategna_freelance_app/models/application_model.dart';

class ApplicationState extends Equatable {
  const ApplicationState();

  @override
  List<Object> get props => [];
}

class ApplicationLoading extends ApplicationState {}

class ApplicationLoadSuccess extends ApplicationState {
  final List<ApplicationModel> applications;

  ApplicationLoadSuccess([this.applications = const []]);
  @override
  List<Object> get props => [applications];
}

class ApplicationOperationFailure extends ApplicationState {
  final String message;
  ApplicationOperationFailure({this.message});
  @override
  List<Object> get props => [message];
}
