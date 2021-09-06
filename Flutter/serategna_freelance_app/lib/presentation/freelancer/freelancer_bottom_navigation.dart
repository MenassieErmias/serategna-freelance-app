import 'package:flutter/material.dart';
import 'package:serategna_freelance_app/presentation/commons/jobsList.dart';
import 'package:serategna_freelance_app/presentation/commons/profile.dart';
import 'package:serategna_freelance_app/presentation/freelancer/freelancer_favorites.dart';
import 'package:serategna_freelance_app/presentation/freelancer/freelancer_notifications.dart';

class FreelancerBottomNavigationBar extends StatefulWidget {
  @override
  _FreelancerBottomNavigationBarState createState() =>
      _FreelancerBottomNavigationBarState();
}

class _FreelancerBottomNavigationBarState
    extends State<FreelancerBottomNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    JobsList(),
    Profile(),
    FreelancerNotifications(),
    FreelancerFavorites(),
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
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Favorites'),
            backgroundColor: Colors.purple,
          )
        ],
      ),
    );
  }
}
