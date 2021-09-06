import 'package:flutter/material.dart';
import 'package:serategna_freelance_app/constants/constants.dart';
import 'package:serategna_freelance_app/presentation/admin/admin_bottom_navigation.dart';
import 'package:serategna_freelance_app/presentation/auth/login_screen.dart';
import 'package:serategna_freelance_app/presentation/employer/employer_bottom_navigation.dart';
import 'package:serategna_freelance_app/presentation/freelancer/freelancer_bottom_navigation.dart';
import 'package:serategna_freelance_app/utils/pref_functions.dart';

class SplashScreen extends StatelessWidget {
  LocallyStored locallyStored = LocallyStored();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: locallyStored.getAll(),
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
                  case Constants.EMPLOYER:
                    return EmployerBottomNavigationBar();
                  case Constants.ADMIN:
                    return AdminBottomNavigationBar();
                  case Constants.FREELANCER:
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
