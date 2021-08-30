import 'package:meta/meta.dart';
import 'package:serategna_freelance_app/data_provider/user_data_provider.dart';
import 'package:serategna_freelance_app/models/user_model.dart';

class UserRepo {
  final UserDataProvider userDataProvider;
  UserRepo({@required this.userDataProvider});

  Future<UserModel> loginUser(UserModel user) async {
    return userDataProvider.loginUser(user);
  }

  Future<UserModel> getUserByID(String id) async {
    return userDataProvider.getUserByID(id);
  }

  Future<UserModel> registerUser(UserModel user) async {
    return userDataProvider.registerUser(user);
  }

  Future<void> updateSelf(UserModel user) async {
    return userDataProvider.updateSelf(user);
  }

  Future<void> updateUser(UserModel user) async {
    return userDataProvider.updateUser(user);
  }

  Future<void> deleteUser(String id) async {
    return userDataProvider.deleteUser(id);
  }

  Future<List<UserModel>> getUsers() async {
    return userDataProvider.getUsers();
  }
}
