import 'package:flutter/material.dart';
import 'package:serategna_freelance_app/admin/admin_employer_list.dart';
import 'package:serategna_freelance_app/admin/admin_freelancer_list.dart';
import 'package:serategna_freelance_app/admin/admin_jobs_list.dart';
import 'package:serategna_freelance_app/auth/login_screen.dart';
import 'package:serategna_freelance_app/employer/add_job.dart';
import 'package:serategna_freelance_app/employer/employer_notifications.dart';
import 'package:serategna_freelance_app/employer/employer_profile.dart';
import 'package:serategna_freelance_app/freelancer/Freelancer_profile.dart';
import 'package:serategna_freelance_app/freelancer/freelancer_favourites.dart';
import 'package:serategna_freelance_app/freelancer/freelancer_jobs_details.dart';
import 'package:serategna_freelance_app/freelancer/freelancer_jobs_list.dart';
import 'package:serategna_freelance_app/freelancer/freelancer_notifications.dart';
import 'employer/employer_jobs_list.dart';
import 'freelancer/freelancer_bottom_navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}
