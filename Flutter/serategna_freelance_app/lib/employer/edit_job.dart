// import 'package:flutter/material.dart';

// class AddJob extends StatefulWidget {

//   @override
//   _AddJobState createState() => _AddJobState();
// }

// class _AddJobState extends State<AddJob> {
//   final _formKey = GlobalKey<FormState>();

//   // form values
//   String _currentName;
//   String _currentBrand;
//   String _currentManufacturingCompany;
//   String _currentPrice;
//   String _currentDescription;
//   String _currentManufactringDate;
//   String _currentExpireDate;
//   String docId;
  
//   @override
//   Widget build(BuildContext context) {
//         return Scaffold(
//           body: new SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 Padding(
//                 padding: const EdgeInsets.fromLTRB(30,100,30,50),
//                 child:Form(
//                     key: _formKey,
//                     child: Column(
//                       children: <Widget>[
//                         Text(
//                           'Edit Job.',
//                           style: TextStyle(fontSize: 18.0),
//                         ),
//                         SizedBox(height: 20.0),
//                         TextFormField(
//                           decoration: InputDecoration(
//                             labelText: 'Title',
//                             focusColor: Color(0xff4064f3),
//                             border: InputBorder.none,
//                             filled: true,
//                             fillColor: Theme.of(context).cardTheme.color,
//                           ),
//                           validator: (val) => val.isEmpty ? 'Please Enter Title' : null,
//                           onChanged: (val) => setState(() => _currentName = val),
//                         ),
//                         SizedBox(height: 10.0),
//                         TextFormField(
//                           decoration: InputDecoration(
//                             labelText: 'Salary',
//                             focusColor: Color(0xff4064f3),
//                             border: InputBorder.none,
//                             filled: true,
//                             fillColor: Theme.of(context).cardTheme.color,
//                           ),
//                           validator: (val) => val.isEmpty ? 'Please Enter Salary' : null,
//                           onChanged: (val) => setState(() => _currentBrand = val),
//                         ),
//                         SizedBox(height: 10.0),
//                         TextFormField(
//                           decoration: InputDecoration(
//                             labelText: 'Company',
//                             focusColor: Color(0xff4064f3),
//                             border: InputBorder.none,
//                             filled: true,
//                             fillColor: Theme.of(context).cardTheme.color,
//                           ),
//                           validator: (val) => val.isEmpty ? 'Please enter Company Name' : null,
//                           onChanged: (val) => setState(() => _currentManufacturingCompany = val),
//                         ),
//                         SizedBox(height: 10.0),
//                         TextFormField(
//                           decoration: InputDecoration(
//                             labelText: 'Position',
//                             focusColor: Color(0xff4064f3),
//                             border: InputBorder.none,
//                             filled: true,
//                             fillColor: Theme.of(context).cardTheme.color,
//                           ),
//                           validator: (val) => val.isEmpty ? 'Please Enter Position' : null,
//                           onChanged: (val) => setState(() => _currentPrice = val),
//                         ),
//                         SizedBox(height: 10.0),
//                         TextFormField(
//                           decoration: InputDecoration(
//                             labelText: 'Description',
//                             focusColor: Color(0xff4064f3),
//                             border: InputBorder.none,
//                             filled: true,
//                             fillColor: Theme.of(context).cardTheme.color,
//                           ),
//                           validator: (val) => val.isEmpty ? 'Please enter Description' : null,
//                           onChanged: (val) => setState(() => _currentDescription = val),
//                         ),
//                         SizedBox(height: 10.0),
//                         TextFormField(
//                           decoration: InputDecoration(
//                             labelText: 'Job Type',
//                             focusColor: Color(0xff4064f3),
//                             border: InputBorder.none,
//                             filled: true,
//                             fillColor: Theme.of(context).cardTheme.color,
//                           ),
//                           validator: (val) => val.isEmpty ? 'Please enter Job Type' : null,
//                           onChanged: (val) => setState(() => _currentManufactringDate = val),
//                         ),
//                         SizedBox(height: 20.0),
//                         RaisedButton(
//                           padding: EdgeInsets.symmetric(vertical: 15, horizontal: 160),
//                           color: Colors.green[400],
//                           child: Text(
//                             'Edit',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           onPressed: () {}
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               ]
//             ),
//           ),
//         );
//       }
// }