import 'package:flutter/material.dart';
import 'package:serategna_freelance_app/models/jobs_list.dart';

class EmployerJobsDetails extends StatefulWidget {
  @override
  _EmployerJobsDetailsState createState() => _EmployerJobsDetailsState();
}

class _EmployerJobsDetailsState extends State<EmployerJobsDetails> {
  List<JobsList> jobs = [
    JobsList(
        titles: 'Graphics Designer',
        salary: '2000',
        jobType: 'Permanent',
        datePosted: '10/4/21',
        company: 'AZ Media'),
    JobsList(
        titles: 'Graphics Designer',
        salary: '2000',
        jobType: 'Permanent',
        datePosted: '10/4/21',
        company: 'AZ Media'),
    JobsList(
        titles: 'Graphics Designer',
        salary: '2000',
        jobType: 'Permanent',
        datePosted: '10/4/21',
        company: 'AZ Media'),
    JobsList(
        titles: 'Graphics Designer',
        salary: '2000',
        jobType: 'Permanent',
        datePosted: '10/4/21',
        company: 'AZ Media'),
    JobsList(
        titles: 'Graphics Designer',
        salary: '2000',
        jobType: 'Permanent',
        datePosted: '10/4/21',
        company: 'AZ Media'),
    JobsList(
        titles: 'Graphics Designer',
        salary: '2000',
        jobType: 'Permanent',
        datePosted: '10/4/21',
        company: 'AZ Media'),
    JobsList(
        titles: 'Graphics Designer',
        salary: '2000',
        jobType: 'Permanent',
        datePosted: '10/4/21',
        company: 'AZ Media'),
    JobsList(
        titles: 'Graphics Designer',
        salary: '2000',
        jobType: 'Permanent',
        datePosted: '10/4/21',
        company: 'AZ Media'),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: Text('Details'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return new Container(
              child: Card(
                child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 4.0),
                            child: Row(children: <Widget>[
                              CircleAvatar(
                                radius: 25.0,
                                backgroundColor: Colors.cyan[100],
                              ),
                              Text("\t\t\t\t" +
                                  jobs[index].titles.toUpperCase() +
                                  "\n\n\t\t\t\t" +
                                  jobs[index].salary +
                                  "\t\t\t\t" +
                                  jobs[index].company),
                              Spacer(),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: new Text(
                                    "Do you want to delete this item?"),
                                actions: [
                                  FlatButton(
                                      onPressed: () {}, child: Text("Yes")),
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("No")),
                                ],
                              ));
                    }),
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
            title: Text('Favorites'),
            backgroundColor: Colors.blue,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
