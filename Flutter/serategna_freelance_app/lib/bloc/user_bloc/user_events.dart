import 'package:serategna_freelance_app/models/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class StartEvent extends UserEvent {
  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends UserEvent {
  final UserModel user;
  LoginButtonPressed({this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'User $user loggedIN';
}

class RegisterButtonPressed extends UserEvent {
  final UserModel user;
  RegisterButtonPressed({this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'User $user Registered';
}

class UserSelfUpdate extends UserEvent {
  final UserModel user;
  UserSelfUpdate({this.user});
  @override
  List<Object> get props => [user];
  @override
  String toString() => 'User $user Self-Updated';
}

class UserUpdate extends UserEvent {
  final UserModel user;
  UserUpdate({this.user});
  @override
  List<Object> get props => [user];
  @override
  String toString() => 'User $user Updated';
}

class FreelancerDelete extends UserEvent {
  final UserModel user;
  FreelancerDelete({this.user});
  @override
  List<Object> get props => [user];
  @override
  String toString() => 'User $user Deleted';
}

class EmployerDelete extends UserEvent {
  final UserModel user;
  EmployerDelete({this.user});
  @override
  List<Object> get props => [user];
  @override
  String toString() => 'User $user Deleted';
}

class EmployersLoad extends UserEvent {
  final List<UserModel> user;
  EmployersLoad({this.user});
  @override
  List<Object> get props => [user];
  @override
  String toString() => 'Users $user';
}

class FreelancersLoad extends UserEvent {
  final List<UserModel> user;
  FreelancersLoad({this.user});
  @override
  List<Object> get props => [user];
  @override
  String toString() => 'Users $user';
}

class LoggedInUser extends UserEvent {
  final String id;
  LoggedInUser({this.id});
  List<Object> get props => [id];
  @override
  String toString() => 'Logged In user $id';
}
