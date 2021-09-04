import 'package:flutter/material.dart';
import 'package:serategna_freelance_app/admin/admin_jobs_details.dart';
import 'package:serategna_freelance_app/models/jobs_list.dart';

class AdminJobsList extends StatefulWidget {
  @override
  _AdminJobsListState createState() => _AdminJobsListState();
}

class _AdminJobsListState extends State<AdminJobsList> {
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
        backgroundColor: Colors.red[900],
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
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => AdminJobsDetails()));
                          },
                        ),
                        SizedBox(width: 15,),
                        FlatButton(
                          color: Colors.red[300],
                          child: Text("Delete"),
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