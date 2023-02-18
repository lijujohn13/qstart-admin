import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qstart_admin_web/Screens/DetailsPage/ComplaintPage.dart';

// dashboard count card popup - to display complaints according to complaint status
Future dashboardComplaintpopup(BuildContext ctx, int count, String type) async {
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
            height: 500,
            width: 500,
            padding: EdgeInsets.all(11.0),
            color: Colors.white,
            child: ListView(children: [
              //

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Complaints - ' + type,
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
              //complaint list
              (count == 0)
                  ? Column(
                      children: [
                        Container(
                            height: 200,
                            width: 200,
                            child: Image.asset("assets/images/nodone.gif")),
                        Text(
                          'There is no ' + type + ' Complaints',
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  : Expanded(
                      child: new StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('complaint')
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
                                  if (document['status'] == type) {
                                    return card(document, ctx);
                                  } else {
                                    return SizedBox();
                                  }
                                }).toList(),
                              );
                          }),
                    ),
              //

              //
              SizedBox(
                height: 40,
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

GestureDetector card(QueryDocumentSnapshot document, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Get.to(ComplaintPage(document));
    },
    child: Card(
      color: Color.fromARGB(255, 244, 245, 245),
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(document['locationhint'],
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                    color: Color.fromARGB(255, 126, 124, 124))),
            SizedBox(height: 5.0),
            Row(children: [
              Icon(Icons.work),
              SizedBox(width: 10.0),
              Text(
                document['title'],
                style: GoogleFonts.poppins(),
                overflow: TextOverflow.ellipsis,
              ),
              Spacer(),
              Text(document['date'])
            ]),
          ])),
    ),
  );
}
