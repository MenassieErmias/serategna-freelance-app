import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  UserModel(
      {this.id,
      this.email,
      this.password,
      this.token,
      this.phoneNumber,
      this.fullName,
      this.role,
      this.profession});
  final String id,
      fullName,
      password,
      phoneNumber,
      role,
      token,
      email,
      profession;

  @override
  List<Object> get props =>
      [id, fullName, password, phoneNumber, role, token, email, profession];

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['_id'],
        fullName: json['fullName'],
        email: json['email'],
        role: json['role'],
        phoneNumber: json['phoneNumber'],
        profession: json['profession'],
        token: json['token']);
  }

  @override
  String toString() =>
      'UserModel { id: $id, email: $email, password: $password, role:$role}';
}
