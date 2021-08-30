import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  UserModel(
      {this.id,
      this.email,
      this.password,
      this.token,
      this.phoneNumber,
      this.fullName,
      this.role});
  final String id, fullName, password, phoneNumber, role, token, email;

  @override
  List<Object> get props =>
      [id, fullName, password, phoneNumber, role, token, email];

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['_id'],
        fullName: json['fullName'],
        email: json['email'],
        role: json['role'],
        phoneNumber: json['phoneNumber'],
        token: json['token']);
  }

  @override
  String toString() =>
      'UserModel { id: $id, email: $email, password: $password, role:$role}';
}
