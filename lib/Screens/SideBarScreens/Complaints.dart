import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../DetailsPage/ComplaintPage.dart';
import '../../helpers/colors.dart';

class ComplaintScreen extends StatefulWidget {
  static const String routeName = '\ComplaintScreen';

  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  bool isdone = false;
  bool isverified = false;
  bool isDeclined = false;
  bool isProcessing = false;
  bool isRequested = false;
  bool isPending = false;



  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(children: [
        //title
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Complaints',
            style: GoogleFonts.anybody(
                fontSize: 40, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
        ),

        SizedBox(
          height: 20,
        ),
        //check box
        Row(
          children: [
            //Done
            Checkbox(
                value: isdone,
                onChanged: (value) {
                  setState(() {
                    isdone = value!;
                  });
                }),
            Text(
              'Done',
              style: GoogleFonts.poppins(),
            ),

            SizedBox(
              width: 30,
            ),

            //Verified
            Checkbox(
                value: isverified,
                onChanged: (value) {
                  setState(() {
                    isverified = value!;
                  });
                }),
            Text(
              'Verified',
              style: GoogleFonts.poppins(),
            ),
            SizedBox(
              width: 30,
            ),

            //Declined
            Checkbox(
                value: isDeclined,
                onChanged: (value) {
                  setState(() {
                    isDeclined = value!;
                  });
                }),
            Text(
              'Declined',
              style: GoogleFonts.poppins(),
            ),

            SizedBox(
              width: 30,
            ),
            //Processing
            Checkbox(
                value: isProcessing,
                onChanged: (value) {
                  setState(() {
                    isProcessing = value!;
                  });
                }),
            Text(
              'Processing',
              style: GoogleFonts.poppins(),
            ),

            SizedBox(
              width: 30,
            ),
            //Requested
            Checkbox(
                value: isRequested,
                onChanged: (value) {
                  setState(() {
                    isRequested = value!;
                  });
                }),
            Text(
              'Requested',
              style: GoogleFonts.poppins(),
            ),

            SizedBox(
              width: 30,
            ),
            //Pending
            Checkbox(
                value: isPending,
                onChanged: (value) {
                  setState(() {
                    isPending = value!;
                  });
                }),
            Text(
              'Pending',
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
          stream: FirebaseFirestore.instance
              .collection('complaint')
              .orderBy('date', descending: false)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();
            return new DataTable(
              columns: <DataColumn>[
                new DataColumn(
                  label: Text('Status'),
                  tooltip: 'Current position of work',
                ),
                new DataColumn(
                  label: Text('Title'),
                ),
                new DataColumn(label: Text('Date')),
                new DataColumn(label: Text('location-hint')),
                new DataColumn(label: Text('View More')),
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
      var check;
      if (documentSnapshot['status'] == 'Requested') {
        check = isRequested;
      } else if (documentSnapshot['status'] == 'Pending') {
        check = isPending;
      } else if (documentSnapshot['status'] == 'Processing') {
        check = isProcessing;
      } else if (documentSnapshot['status'] == 'Declined') {
        check = isDeclined;
      } else if (documentSnapshot['status'] == 'Verified') {
        check = isverified;
      } else {
        check = isdone;
      }
      return new DataRow(
          selected: check,
          onSelectChanged: (Value) {
            check = !check;
          },
          cells: [
            DataCell(Text(documentSnapshot['status'])),
            DataCell(
              Text(
                documentSnapshot['title'],
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  color: (documentSnapshot['status'] == 'Requested')
                      ? AppColor.requestedColour
                      : (documentSnapshot['status'] == 'Processing')
                          ? AppColor.processingColour
                          : (documentSnapshot['status'] == 'Declined')
                              ? AppColor.declainedColour
                              : (documentSnapshot['status'] == 'Pending')
                                  ? AppColor.pendingColour
                                  : (documentSnapshot['status'] == 'Verified')
                                      ? AppColor.doneVerifiedColour
                                      : AppColor.doneColour,
                ),
              ),
            ),
            DataCell(Text(
              documentSnapshot['date'],
            )),
            DataCell(Text(
              documentSnapshot['locationhint'],
              overflow: TextOverflow.ellipsis,
            )),
            DataCell(GestureDetector(
                onTap: () {
                  Get.to(ComplaintPage(documentSnapshot));
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
