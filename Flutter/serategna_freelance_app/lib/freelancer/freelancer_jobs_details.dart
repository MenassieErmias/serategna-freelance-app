import 'package:flutter/material.dart';
import 'package:serategna_freelance_app/models/jobs_list.dart';

class FreelancerJobsDetails extends StatefulWidget {

  @override
  _FreelancerJobsDetailsState createState() => _FreelancerJobsDetailsState();
}

class _FreelancerJobsDetailsState extends State<FreelancerJobsDetails> {
 List<JobsList> jobs = [
    JobsList(titles: 'Graphics Designer', salary: '2000', jobType: 'Permanent', datePosted: '10/4/21', company: 'AZ Media'),
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
        itemCount: jobs.length,
        itemBuilder: (context, index) {
        return new Container(
          child: Card( 
            child: ListTile(
              onTap: () {},
              title: Text('\nTitle: '+ jobs[index].titles + '\n'
                          'Salary: '+jobs[index].salary + '\n'
                          'Job Type: '+jobs[index].jobType + '\n'
                          'Date Posted: '+jobs[index].datePosted + '\n'
                          'Company: '+jobs[index].company + '\n'
                          'Job Type: '+jobs[index].jobType + '\n'
                          'Date Posted: '+jobs[index].datePosted + '\n'
                          'Company: '+jobs[index].company + '\n'
                          'Job Type: '+jobs[index].jobType + '\n'
                          'Date Posted: '+jobs[index].datePosted + '\n'
                          'Company: '+jobs[index].company + '\n'
                          'Job Type: '+jobs[index].jobType + '\n'
                          'Date Posted: '+jobs[index].datePosted + '\n'
                          'Company: '+jobs[index].company + '\n'
                          'Job Type: '+jobs[index].jobType + '\n'
                          'Date Posted: '+jobs[index].datePosted + '\n'
                          'Company: '+jobs[index].company + '\n'
                          'Job Type: '+jobs[index].jobType + '\n'
                          'Date Posted: '+jobs[index].datePosted + '\n'
                          'Company: '+jobs[index].company + '\n'
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
                        color: Colors.purple[300],
                        child: Text("Apply"),
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
