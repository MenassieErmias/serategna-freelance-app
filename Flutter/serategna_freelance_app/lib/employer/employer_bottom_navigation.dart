import 'package:flutter/material.dart';
import 'package:serategna_freelance_app/employer/employer_jobs_list.dart';
import 'package:serategna_freelance_app/employer/employer_notifications.dart';
import 'package:serategna_freelance_app/employer/employer_profile.dart';

class EmployerBottomNavigationBar extends StatefulWidget {
  @override
  _EmployerBottomNavigationBarState createState() => _EmployerBottomNavigationBarState();
}

class _EmployerBottomNavigationBarState extends State<EmployerBottomNavigationBar> {
  
  int _currentIndex = 0;
  final List<Widget> _children = [
    EmployerJobsList(),
    EmployerProfile(),
    EmployerNotifications(),
  ];
  void onTapBar(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
            title: Text('Profile'),
            backgroundColor: Colors.green,
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Notifications'),
            backgroundColor: Colors.blue,
            )
        ],
      ),
    );
  }
}