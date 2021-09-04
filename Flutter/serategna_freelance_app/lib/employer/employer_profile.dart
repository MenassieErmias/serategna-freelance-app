import 'package:flutter/material.dart';
import 'package:serategna_freelance_app/models/employer_list.dart';

class EmployerProfile extends StatefulWidget {

  @override
  _EmployerProfileState createState() => _EmployerProfileState();
}

class _EmployerProfileState extends State<EmployerProfile> {
 List<EmployersList> employers = [
    EmployersList(name: 'Abebe Beso', profession: 'Graphic Designer', phoneNumber: '0912457856', email: 'abebe@beso.com'),
 ];
  
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: Text('Profile'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
    return new Container(
      child: Card(child: ListTile(
                onTap: () {},
                title: Text('\nName: '+ employers[index].name + '\n'
                            'Profession: '+employers[index].profession + '\n'
                            'Phone Number: '+employers[index].phoneNumber + '\n'
                            'email: '+employers[index].email + '\n'
                ),
                subtitle: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                      children: <Widget>[
                        FlatButton(
                          color: Colors.cyan,
                          child: Text("Edit"),
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
  }),
   bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
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
