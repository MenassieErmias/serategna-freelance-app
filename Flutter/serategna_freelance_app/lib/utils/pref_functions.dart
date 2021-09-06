import 'package:shared_preferences/shared_preferences.dart';

class LocallyStored {
  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    return token;
  }

  Future<String> prefUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = pref.getString("id");
    return userId;
  }

  Future<String> getRole() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String role = pref.getString('role');
    return role;
  }

  Future<Map<String, String>> getAll() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    String role = pref.getString("role");
    return <String, String>{"token": token, "role": role};
  }

  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("token");
    pref.remove("role");
    pref.remove("id");
  }
}
