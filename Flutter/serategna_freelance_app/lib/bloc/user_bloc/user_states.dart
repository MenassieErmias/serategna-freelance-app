import 'package:equatable/equatable.dart';
import 'package:serategna_freelance_app/models/user_model.dart';

class UserState extends Equatable {
  const UserState();
  @override
  List<Object> get props => [];
}

class FormInitState extends UserState {}

class LoadingState extends UserState {}

class FreelancerLoginSucessState extends UserState {
  final UserModel user;
  FreelancerLoginSucessState({this.user});
  @override
  List<Object> get props => [user];
}

class AdminLoginSucessState extends UserState {
  final UserModel user;
  AdminLoginSucessState({this.user});
  @override
  List<Object> get props => [user];
}

class EmployerLoginSucessState extends UserState {
  final UserModel user;
  EmployerLoginSucessState({this.user});
  @override
  List<Object> get props => [user];
}

class UserRegisterSucessState extends UserState {}

class UsersLoadSucessState extends UserState {
  final List<UserModel> users;
  UsersLoadSucessState([this.users = const []]);
  List<Object> get props => [users];
}

class LoggedInUserSuccessState extends UserState {
  final UserModel user;
  LoggedInUserSuccessState({this.user});
  List<Object> get props => [user];
  @override
  String toString() => 'Logged In user $user';
}

class UserFailureState extends UserState {
  final String message;
  UserFailureState({this.message});
  @override
  List<Object> get props => [message];
}
