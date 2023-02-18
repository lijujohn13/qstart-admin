import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qstart_admin_web/Screens/popup/complaintsortoneachpage/workerComplaint.dart';
import 'package:qstart_admin_web/Screens/popup/profiledetails/workerPopup.dart';

class WorkerScreen extends StatefulWidget {
  static const String routeName = '\WorkerScreen';

  const WorkerScreen({super.key});

  @override
  State<WorkerScreen> createState() => _WorkerScreenState();
}

class _WorkerScreenState extends State<WorkerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      child: ListView(children: [
        //title
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Workers',
            style: GoogleFonts.anybody(
                fontSize: 40, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
        ),

        SizedBox(
          height: 20,
        ),

        SizedBox(
          height: 20,
        ),
        //table
        new StreamBuilder(
          stream: FirebaseFirestore.instance.collection('worker').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();
            return new DataTable(
              columns: <DataColumn>[
                new DataColumn(
                  label: Text('Name'),
                ),
                new DataColumn(
                  label: Text('E-Mail'),
                ),
                new DataColumn(
                  label: Text('Phone no.'),
                ),
                new DataColumn(
                    label: Text('Total no. \ncomplaints\n assigned')),
                new DataColumn(label: Text('Done \nWork')),
                new DataColumn(label: Text('Pending\n Work')),
                new DataColumn(label: Text('View\nComplaints')),
                new DataColumn(label: Text('ViewMore')),
              ],
              rows: _createRows(snapshot.data!),
            );
          },
        )
      ]),
    ));
  }

  List<DataRow> _createRows(QuerySnapshot snapshot) {
    List<DataRow> newList =
        snapshot.docs.map((DocumentSnapshot documentSnapshot) {
      return new DataRow(cells: [
        DataCell(
          Text(documentSnapshot['username'],
              overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins()),
        ),
        DataCell(Text(
          documentSnapshot['email'],
          overflow: TextOverflow.ellipsis,
        )),
        DataCell(Text(
          documentSnapshot['phoneNo'],
        )),
        DataCell(Text(documentSnapshot['totalcomplaintcount'].toString())),
        DataCell(Text(documentSnapshot['donecount'].toString())),
        DataCell(Text(documentSnapshot['pendingcount'].toString())),
        //view complaints
         DataCell(GestureDetector(
            onTap: () {
           workerComplaint(context, documentSnapshot['totalcomplaintcount'], documentSnapshot['username'], documentSnapshot['id']);
            },
            child: Icon(
              FontAwesomeIcons.solidEye,
              color: Color.fromARGB(255, 143, 160, 245),
            ))),
        //view more
        DataCell(GestureDetector(
            onTap: () {
              workerPopup(context, documentSnapshot);
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
