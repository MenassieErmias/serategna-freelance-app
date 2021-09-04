import 'package:flutter/material.dart';
import 'package:serategna_freelance_app/freelancer/Freelancer_profile.dart';
import 'package:serategna_freelance_app/freelancer/freelancer_favourites.dart';
import 'package:serategna_freelance_app/freelancer/freelancer_jobs_list.dart';
import 'package:serategna_freelance_app/freelancer/freelancer_notifications.dart';

class FreelancerBottomNavigationBar extends StatefulWidget {
  @override
  _FreelancerBottomNavigationBarState createState() => _FreelancerBottomNavigationBarState();
}

class _FreelancerBottomNavigationBarState extends State<FreelancerBottomNavigationBar> {
  
  int _currentIndex = 0;
  final List<Widget> _children = [
    FreelancerJobsList(),
    FreelancerProfile(),
    FreelancerNotifications(),
    FreelancerFavourites(),
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
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Favourites'),
            backgroundColor: Colors.purple,
          )
        ],
      ),
    );
  }
}