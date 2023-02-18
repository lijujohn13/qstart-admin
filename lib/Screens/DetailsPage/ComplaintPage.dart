import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qstart_admin_web/Screens/popup/complaintstatus/DeclinePopup.dart';
import 'package:qstart_admin_web/Screens/popup/complaintstatus/DoneAccepted.dart';
import 'package:qstart_admin_web/Screens/popup/complaintstatus/complaintAcceptPopup.dart';
import '../../helpers/colors.dart';

//complaint details page

class ComplaintPage extends StatelessWidget {
  final DocumentSnapshot document;
  ComplaintPage(this.document, {super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(FontAwesomeIcons.arrowLeft)),
        title: Text(
          'QSTART',
          style:
              GoogleFonts.amaranth(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlue,
        // backgroundColor: Colors.transparent,
        // centerTitle: true,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          //main row
          Row(
            children: [
              //first column
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //container for showing photo
                    Container(
                      height: 400,
                      width: 400,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: FadeInImage(
                        image: NetworkImage(
                          document['img'],
                        ),
                        placeholder:
                            const AssetImage('assets/images/imageloading.gif'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    //row for accept,verified,declined buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //accepted (processing)
                        (document['status'] == 'Requested')
                            ? GestureDetector(
                                onTap: () {
                                  complaintAccecptPopup(context, document.id);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      color: AppColor.processingColour),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    // child: Text(document['status']),
                                    child: Text('Accepted'),
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: 20,
                              ),
                        //done verified
                        (document['status'] == 'Done')
                            ? GestureDetector(
                                onTap: () {
                                  DoneAcceptedPopup(
                                      context, document.id, document['userid']);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      color: AppColor.doneVerifiedColour),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    // child: Text(document['status']),
                                    child: Text('Done Verified'),
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: 20,
                              ),
                        //decline
                        (document['status'] == 'Requested')
                            ? GestureDetector(
                                onTap: () {
                                  DeclinePopup(context, document.id);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      color: AppColor.declainedColour),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    // child: Text(document['status']),
                                    child: Text('Decline'),
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: 1,
                              )
                      ],
                    ),
                  ],
                ),
              ),

              //second column
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    //title
                    Center(
                      child: Text(document['title'],
                          style: GoogleFonts.amaranth(
                            letterSpacing: 2,
                            fontSize: 55,
                            fontWeight: FontWeight.bold,
                          )),
                    ),

                    //date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.calendar_month_outlined),
                        Text(document['date']),
                        Spacer(),
                        //posted by
                        Text('Posted by :  ' + document['useremail']),
                        SizedBox(
                          width: 15,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    //location hint
                    Text(
                      'Location hint :  ' + document['locationhint'],
                      style: GoogleFonts.poppins(
                          fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //current status
                    Row(
                      children: [
                        Text(
                          'Current Status : ',
                          style: GoogleFonts.poppins(
                              fontSize: 15, fontWeight: FontWeight.w300),
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: (document['status'] == 'Requested')
                                  ? AppColor.requestedColour
                                  : (document['status'] == 'Processing')
                                      ? AppColor.processingColour
                                      : (document['status'] == 'Declined')
                                          ? AppColor.declainedColour
                                          : (document['status'] == 'Pending')
                                              ? AppColor.pendingColour
                                              : (document['status'] ==
                                                      'Done Verified')
                                                  ? AppColor.doneVerifiedColour
                                                  : AppColor.doneColour,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              // child: Text(document['status']),
                              child: Text(document['status']),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //work assigned to
                    (document['workerid'] != '')
                        ? Text(
                            'Work Assigned to : josephjibi41@gmail.com',
                            style: GoogleFonts.poppins(
                                fontSize: 15, fontWeight: FontWeight.w300),
                          )
                        : SizedBox(
                            height: 1,
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Description :  \n ' + document['description'],
                      // 'We have been using this purifier from our 1st yr. It\'s not working from last 3 days. Do check on this and ensure it\'s working ',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
