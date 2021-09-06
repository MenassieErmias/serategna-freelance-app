import 'package:flutter/material.dart';
import 'package:serategna_freelance_app/presentation/commons/jobsList.dart';
import 'package:serategna_freelance_app/presentation/commons/profile.dart';
import 'package:serategna_freelance_app/presentation/employer/employer_notifications.dart';

class EmployerBottomNavigationBar extends StatefulWidget {
  @override
  _EmployerBottomNavigationBarState createState() =>
      _EmployerBottomNavigationBarState();
}

class _EmployerBottomNavigationBarState
    extends State<EmployerBottomNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    JobsList(),
    Profile(),
    EmployerNotifications(),
  ];
  void onTapBar(int index) {
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
