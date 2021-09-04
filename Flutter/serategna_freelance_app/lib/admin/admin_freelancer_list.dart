import 'package:flutter/material.dart';
import 'package:serategna_freelance_app/models/freelancer_list.dart';

class AdminFreelancersList extends StatefulWidget {
  @override
  _AdminFreelancersListState createState() => _AdminFreelancersListState();
}

class _AdminFreelancersListState extends State<AdminFreelancersList> {
 List<FreelancersList> freelancers = [
    FreelancersList(name: 'Abebe Beso', profession: 'Graphic Designer', phoneNumber: '0912457856', email: 'abebe@beso.com'),
    FreelancersList(name: 'Abebe Beso', profession: 'Graphic Designer', phoneNumber: '0912457856', email: 'abebe@beso.com'),
    FreelancersList(name: 'Abebe Beso', profession: 'Graphic Designer', phoneNumber: '0912457856', email: 'abebe@beso.com'),
    FreelancersList(name: 'Abebe Beso', profession: 'Graphic Designer', phoneNumber: '0912457856', email: 'abebe@beso.com'),
    FreelancersList(name: 'Abebe Beso', profession: 'Graphic Designer', phoneNumber: '0912457856', email: 'abebe@beso.com'),
    FreelancersList(name: 'Abebe Beso', profession: 'Graphic Designer', phoneNumber: '0912457856', email: 'abebe@beso.com'),
    FreelancersList(name: 'Abebe Beso', profession: 'Graphic Designer', phoneNumber: '0912457856', email: 'abebe@beso.com'),
    FreelancersList(name: 'Abebe Beso', profession: 'Graphic Designer', phoneNumber: '0912457856', email: 'abebe@beso.com'),
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
        title: Text('Freelancers'),
        centerTitle: true,
        elevation: 0,
      ),
      body:ListView.builder(
        itemCount: freelancers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {},
                title: Text('\nName: '+ freelancers[index].name + '\n'
                            'Profession: '+freelancers[index].profession + '\n'
                            'Phone Number: '+freelancers[index].phoneNumber + '\n'
                            'Email: '+freelancers[index].email + '\n'
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
     
    );
  }
}