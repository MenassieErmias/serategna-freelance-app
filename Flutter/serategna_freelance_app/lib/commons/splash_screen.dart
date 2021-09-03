import 'package:flutter/material.dart';
import 'package:serategna_freelance_app/admin/admin_bottom_navigation.dart';
import 'package:serategna_freelance_app/auth/login_screen.dart';
import 'package:serategna_freelance_app/employer/employer_bottom_navigation.dart';
import 'package:serategna_freelance_app/freelancer/freelancer_bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  Future<Map<String, String>> pref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    String role = pref.getString("role");
    return <String, String>{"token": token, "role": role};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: pref(),
          builder: (context, AsyncSnapshot<Map<String, String>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              Center(
                child: CircularProgressIndicator(
                  color: Colors.indigo,
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData || snapshot.data["token"] != null) {
                switch (snapshot.data["role"]) {
                  case "EMPLOYER":
                    return EmployerBottomNavigationBar();
                  case "ADMIN":
                    return AdminBottomNavigationBar();
                  case "FREELANCER":
                    return FreelancerBottomNavigationBar();
                  default:
                    return LoginPage();
                }
              } else
                return LoginPage();
            }
            return Center(
              child: CircularProgressIndicator(
                color: Colors.indigo,
              ),
            );
          }),
    );
  }
}
