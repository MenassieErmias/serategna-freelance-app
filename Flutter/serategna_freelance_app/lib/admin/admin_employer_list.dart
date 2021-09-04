import 'package:flutter/material.dart';
import 'package:serategna_freelance_app/freelancer/freelancer_jobs_details.dart';
import 'package:serategna_freelance_app/models/employer_list.dart';

class AdminEmployerList extends StatefulWidget {
  @override
  _AdminEmployerListState createState() => _AdminEmployerListState();
}

class _AdminEmployerListState extends State<AdminEmployerList> {
 List<EmployersList> employers = [
    EmployersList(name: 'Abebe Beso', profession: 'Graphic Designer', phoneNumber: '0912457856', email: 'abebe@beso.com'),
    EmployersList(name: 'Abebe Beso', profession: 'Graphic Designer', phoneNumber: '0912457856', email: 'abebe@beso.com'),
    EmployersList(name: 'Abebe Beso', profession: 'Graphic Designer', phoneNumber: '0912457856', email: 'abebe@beso.com'),
    EmployersList(name: 'Abebe Beso', profession: 'Graphic Designer', phoneNumber: '0912457856', email: 'abebe@beso.com'),
    EmployersList(name: 'Abebe Beso', profession: 'Graphic Designer', phoneNumber: '0912457856', email: 'abebe@beso.com'),
    EmployersList(name: 'Abebe Beso', profession: 'Graphic Designer', phoneNumber: '0912457856', email: 'abebe@beso.com'),
    EmployersList(name: 'Abebe Beso', profession: 'Graphic Designer', phoneNumber: '0912457856', email: 'abebe@beso.com'),
    EmployersList(name: 'Abebe Beso', profession: 'Graphic Designer', phoneNumber: '0912457856', email: 'abebe@beso.com'),
  ];

  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text('Employers'),
        centerTitle: true,
        elevation: 0,
      ),
      body:ListView.builder(
        itemCount: employers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {},
                title: Text('\nName: '+ employers[index].name + '\n'
                            'Profession: '+employers[index].profession + '\n'
                            'Phone Number: '+employers[index].phoneNumber + '\n'
                            'Email: '+employers[index].email + '\n'
                ),
                subtitle: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                      children: <Widget>[
                        FlatButton(
                          color: Colors.red[400],
                          child: Text("Remove"),
                          onPressed: () {},
                        ),
                      ],
                    ))
                  ],
                ),
                leading: CircleAvatar(
                  // backgroundImage: AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            ),
          );
        }
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
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
            backgroundColor: Colors.blue,
            ),
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        ),
    );
  }
}