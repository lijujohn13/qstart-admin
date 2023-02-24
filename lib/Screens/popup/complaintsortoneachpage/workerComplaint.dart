import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qstart_admin_web/Screens/DetailsPage/ComplaintPage.dart';

//to display complaints according to complaint assigned worker - popup on click on worker table view

Future workerComplaint(
    BuildContext ctx, int count, String workername, var workerid) async {
  print('working');

  return showDialog(
      context: ctx,
      builder: (ctx1) {
        return AlertDialog(
          actions: [
             Center(
               child: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Close')),
             )
          ],
          title: Center(
            child: Text('Complaints - ' + workername,
                        style: GoogleFonts.poppins(
                          letterSpacing: 2,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        )),
          ),
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
                            child:
                                Image.asset("assets/images/nocomplaints.gif")),
                        Text(
                          workername + 'haven\'t posted any Complaints',
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
                                  if (document['workerid'] == workerid) {
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
                height: 30,
              ),

           
             
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
              (document['status'] == 'Done' || document['status'] == 'Verified')
                  ? Container(
                      height: 40,
                      width: 40,
                      child: Image.asset('assets/images/tick.gif'),
                    )
                  : Container(
                      height: 40,
                      width: 40,
                      child: Image.asset('assets/images/notdone.gif'),
                    )
            ]),
          ])),
    ),
  );
}
