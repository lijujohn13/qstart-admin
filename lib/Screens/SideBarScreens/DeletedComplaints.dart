import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qstart_admin_web/Screens/DetailsPage/DeleteComplaintPage.dart';

class DeletedComplaints extends StatelessWidget {

  static const String routeName='\DeletedComplaints';
  const DeletedComplaints({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    
      child: ListView(children: [
      //title
        Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text('Deleted Complaints',style: GoogleFonts.anybody(
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey
                  ),),
          ),
          
        SizedBox(height: 20,),
       
       SizedBox(height: 20,),
      //table
     new StreamBuilder(
            stream:  FirebaseFirestore.instance
                          .collection('deletedcomplaint')
                          .orderBy('deldate',descending: false)
                          .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();
              return new DataTable(
                dataTextStyle: GoogleFonts.poppins(color: Color.fromARGB(255, 180, 64, 64)),
                headingTextStyle: GoogleFonts.poppins(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w500,
                ),
              
                columns: <DataColumn>[
                  new DataColumn(
                    label: Text('Title'),),
                  new DataColumn(label: Text('Posted \n Date'),),
                  new DataColumn(label: Text('Deleted \n Date')),
                  new DataColumn(label: Text('location-hint')),
                  new DataColumn(label: Text('View More...')),
                ],
                rows: _createRows(snapshot.data!),

              );
            },
          ),
        
      ]),
    );
  }
  List<DataRow> _createRows(QuerySnapshot snapshot) {
   
    List<DataRow> newList = snapshot.docs.map((DocumentSnapshot documentSnapshot) {
   
      
      return new DataRow(
       
       
        cells: [
        DataCell(Text(documentSnapshot['title'],overflow: TextOverflow.ellipsis)),
        DataCell(Text(documentSnapshot['posteddate'],),),
        DataCell(Text(documentSnapshot['deldate'], )),
        DataCell(Text(documentSnapshot['locationhint'],overflow: TextOverflow.ellipsis,)),
        DataCell(GestureDetector(
          onTap: (){
            Get.to(DeleteComplaintPage(documentSnapshot));
          },
          child: Icon(FontAwesomeIcons.solidEye,color:Color.fromARGB(255, 160, 133, 211),))), 
      ]);
    }).toList();

    return newList;
  }
}