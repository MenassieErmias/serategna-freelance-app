import 'package:flutter/material.dart';
import 'package:serategna_freelance_app/auth/login_screen.dart';
import 'package:serategna_freelance_app/freelancer/freelancer_jobs_details.dart';
import 'package:serategna_freelance_app/models/jobs_list.dart';

class FreelancerJobsList extends StatefulWidget {
  @override
  _FreelancerJobsListState createState() => _FreelancerJobsListState();
}

class _FreelancerJobsListState extends State<FreelancerJobsList> {
 List<JobsList> jobs = [
    JobsList(titles: 'Graphics Designer', salary: '2000', jobType: 'Permanent', datePosted: '10/4/21', company: 'AZ Media'),
    JobsList(titles: 'Graphics Designer', salary: '2000', jobType: 'Permanent', datePosted: '10/4/21', company: 'AZ Media'),
    JobsList(titles: 'Graphics Designer', salary: '2000', jobType: 'Permanent', datePosted: '10/4/21', company: 'AZ Media'),
    JobsList(titles: 'Graphics Designer', salary: '2000', jobType: 'Permanent', datePosted: '10/4/21', company: 'AZ Media'),
    JobsList(titles: 'Graphics Designer', salary: '2000', jobType: 'Permanent', datePosted: '10/4/21', company: 'AZ Media'),
    JobsList(titles: 'Graphics Designer', salary: '2000', jobType: 'Permanent', datePosted: '10/4/21', company: 'AZ Media'),
    JobsList(titles: 'Graphics Designer', salary: '2000', jobType: 'Permanent', datePosted: '10/4/21', company: 'AZ Media'),
    JobsList(titles: 'Graphics Designer', salary: '2000', jobType: 'Permanent', datePosted: '10/4/21', company: 'AZ Media'),
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
        backgroundColor: Colors.purple[900],
        title: Text('Jobs'),
        centerTitle: true,
        elevation: 0,
      ),
      body:ListView.builder(
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {},
                title: Text('\nTitle: '+ jobs[index].titles + '\n'
                            'Salary: '+jobs[index].salary + '\n'
                            'Job Type: '+jobs[index].jobType + '\n'
                            'Date Posted: '+jobs[index].datePosted + '\n'
                            'Company: '+jobs[index].company + '\n'
                ),
                subtitle: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                      children: <Widget>[
                        FlatButton(
                          color: Colors.amber,
                          child: Text("Details"),
                          onPressed: () {        
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => FreelancerJobsDetails()));
                          },
                        ),
                        SizedBox(width: 15,),
                        FlatButton(
                          color: Colors.lime,
                          child: Text("Favourite"),
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