import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


//deleted complaints details page

class DeleteComplaintPage extends StatelessWidget {
  final DocumentSnapshot document;
  DeleteComplaintPage(this.document, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            children: [
              //first container holds image
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Image.asset(
                      'assets/images/image.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //close button
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 20),
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Row(
                            children: [
                              Icon(
                                color: Colors.white,
                                  // Icons.close,
                                  size: 30,
                                  
                                  FontAwesomeIcons.backward),
                              Text(
                                ' Back',
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),

              //secont container holds inputboxes
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 2,
                color: Colors.grey[100],
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      //container for showing photo
                      Padding(
                        padding: const EdgeInsets.only(left: 49, right: 49),
                        child: Container(
                          height: 370,
                          width: 150,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: FadeInImage(
                            image: NetworkImage(
                              document['img'],
                            ),
                            placeholder: const AssetImage(
                                'assets/images/imageloading.gif'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                      SizedBox(
                        height: 10,
                      ),
                      Text('Posted by :  ' + document['useremail']),
                      SizedBox(
                        height: 20,
                      ),
                      //posted date
                      Text('Posted On :    '),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.calendar_month_outlined),
                          Text(document['posteddate']),
                          Spacer(),
                          const Icon(
                            FontAwesomeIcons.clock,
                            size: 15,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(document['postedtime']),
                        ],
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      //deleted date
                      Text('Deleted On : '),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.calendar_month_outlined),
                          Text(document['deldate']),
                          Spacer(),
                          Icon(
                            FontAwesomeIcons.clock,
                            size: 15,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(document['deltime']),
                        ],
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      //location hint
                      Text(
                        'Location hint :  ' + document['locationhint'],
                        style: GoogleFonts.poppins(),
                      ),
                      SizedBox(
                        height: 10,
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
                )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
