import 'package:flutter/material.dart';
import 'package:serategna_freelance_app/auth/login_screen.dart';
import 'package:serategna_freelance_app/freelancer/freelancer_jobs_details.dart';
import 'package:serategna_freelance_app/models/jobs_list.dart';

class FreelancerNotifications extends StatefulWidget {
  @override
  _FreelancerNotificationsState createState() => _FreelancerNotificationsState();
}

class _FreelancerNotificationsState extends State<FreelancerNotifications> {
 List<JobsList> jobs = [
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
        title: Text('Notifications'),
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
                subtitle: Text('Accepted! (Employer will contact you soon)\n',  style: TextStyle(color: Colors.green),
              ),
            ),
          ));
        }
      ),
     
    );
  }
}