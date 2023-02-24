import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qstart_admin_web/Screens/popup/profiledetails/userPopup.dart';
import 'package:qstart_admin_web/Screens/widgets/footer.dart';

import '../popup/complaintsortoneachpage/userComplaint.dart';

class UserScreen extends StatefulWidget {
  static const String routeName = '\UserScreen';

  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool isStudent = false;
  bool isEmployee = false;
 
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(children: [
        //title
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Users',
            style: GoogleFonts.anybody(
                fontSize: 40, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
        ),
        
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            //student
            Checkbox(
                value: isStudent,
                onChanged: (value) {
                  setState(() {
                    isStudent = value!;
                  });
                }),

            Text(
              'Student',
              style: GoogleFonts.poppins(),
            ),
            SizedBox(
              width: 30,
            ),
            //employee
            Checkbox(
                value: isEmployee,
                onChanged: (value) {
                  setState(() {
                    isEmployee = value!;
                  });
                }),
            Text(
              'Employee',
              style: GoogleFonts.poppins(),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        //table
        new StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();
            return new DataTable(
              columns: <DataColumn>[
                new DataColumn(
                  label: Text('Unique no.'),
                  tooltip: 'eg:admission no.',
                ),
                new DataColumn(
                  label: Text('Name'),
                ),
                new DataColumn(label: Text('Dep')),
                new DataColumn(label: Text('E-mail')),
                new DataColumn(label: Text('View Complaints\nPosted')),
                new DataColumn(label: Text('View Details')),
              ],
              rows: _createRows(snapshot.data!),
            );
          },
        ),
       
      ]),
    );
  }

  List<DataRow> _createRows(QuerySnapshot snapshot) {
    List<DataRow> newList =
        snapshot.docs.map((DocumentSnapshot documentSnapshot) {
      var check =
          (documentSnapshot['type'] == 'Student') ? isStudent : isEmployee;
      return new DataRow(
          selected: check,
          onSelectChanged: (Value) {
            check = !check;
          },
          cells: [
            DataCell(Text(documentSnapshot['uniqueNo'])),
            DataCell(
              Text(documentSnapshot['username']),
            ),
            DataCell(Text(documentSnapshot['dep'])),
            DataCell(Text(documentSnapshot['email'])),
            DataCell(GestureDetector(
                onTap: () {
                  userComplaint(context, documentSnapshot['complaint'],
                      documentSnapshot['username'], documentSnapshot['id']);
                },
                child: Icon(
                  FontAwesomeIcons.solidEye,
                  color: Color.fromARGB(255, 143, 160, 245),
                ))),
            DataCell(GestureDetector(
                onTap: () {
                  userPopUpBox(context, documentSnapshot);
                },
                child: Icon(
                  FontAwesomeIcons.solidEye,
                  color: Color.fromARGB(255, 143, 160, 245),
                ))),
          ]);
    }).toList();

    return newList;
  }
}
