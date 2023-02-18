import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'conformpopup.dart';

//complaint accept popup
Future complaintAccecptPopup(BuildContext ctx, var complaintid) async {
  print('working');

  return showDialog(
      context: ctx,
      builder: (ctx1) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25))),
          content: Container(
            height: MediaQuery.of(ctx).size.height,
            width: MediaQuery.of(ctx).size.width,
            padding: EdgeInsets.all(11.0),
            color: Colors.white,
            child: ListView(children: [
              //

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Work is assigned to :\n(Select any worker)',
                      style: GoogleFonts.amaranth(
                        letterSpacing: 2,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              //worker list
              Expanded(
                child: new StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('worker')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData)
                        return LinearProgressIndicator();
                      else
                        return ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: snapshot.data!.docs.map((document) {
                            print('working in popup');
                            return card(document, ctx, complaintid);
                          }).toList(),
                        );
                    }),
              ),
              //

              //
              SizedBox(
                height: 20,
              ),

              Spacer(),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Close'))
            ]),
          ),
        );
      });
}

GestureDetector card(
    QueryDocumentSnapshot document, BuildContext context, var complaintid) {
  return GestureDetector(
    onTap: () {
      conformpopup(context, document['username'], complaintid, document['id']);
    },
    child: Card(
      color: Color.fromARGB(255, 244, 245, 245),
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(document['type'],
                style: GoogleFonts.poppins(
                    color: Color.fromARGB(255, 126, 124, 124))),
            SizedBox(height: 5.0),
            Row(children: [
              Icon(Icons.work),
              SizedBox(width: 10.0),
              Text(
                document['username'],
                style: GoogleFonts.poppins(),
                overflow: TextOverflow.ellipsis,
              ),
            ]),
          ])),
    ),
  );
}
