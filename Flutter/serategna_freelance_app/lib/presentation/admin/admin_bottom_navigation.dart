import 'package:flutter/material.dart';
import 'package:serategna_freelance_app/presentation/admin/admin_employer_list.dart';
import 'package:serategna_freelance_app/presentation/admin/admin_freelancer_list.dart';
import 'package:serategna_freelance_app/presentation/admin/admin_jobs_list.dart';

class AdminBottomNavigationBar extends StatefulWidget {
  @override
  _AdminBottomNavigationBarState createState() =>
      _AdminBottomNavigationBarState();
}

class _AdminBottomNavigationBarState extends State<AdminBottomNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    AdminJobsList(),
    AdminFreelancersList(),
    AdminEmployersList(),
  ];
  void onTapBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: onTapBar,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            title: Text('Jobs'),
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Freelancers'),
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            title: Text('Employers'),
            backgroundColor: Colors.blue,
          )
        ],
      ),
    );
  }
}
