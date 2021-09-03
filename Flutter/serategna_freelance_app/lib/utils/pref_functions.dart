import 'package:shared_preferences/shared_preferences.dart';

Future<String> pref() async {
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
