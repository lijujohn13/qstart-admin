import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qstart_admin_web/Screens/ScreenMain.dart';
import '../../../Controller/complainController.dart';

//conform complaint popup
final ctrl = Get.put(ComplaintContoller());
Future conformpopup(BuildContext ctx, String name, var complaintid,
    var workerid, var workerdocid) async {
  return showDialog(
      context: ctx,
      builder: (ctx1) {
        return AlertDialog(
          title: Center(
              child: Text('Conform ⚠️',
                  style: GoogleFonts.amaranth(
                      fontSize: 30, fontWeight: FontWeight.bold))),
          actions: [
            Center(
              child: Column(
                children: [
                  Divider(
                        thickness: 1,
                      ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              'Close',
                              style: GoogleFonts.poppins(fontSize: 15),
                            )),
                        VerticalDivider(
                          thickness: 1,
                        ),
                        TextButton(
                            onPressed: () {
                              ctrl.AcceptandAssign(
                                  complaintid, workerid, workerdocid);
                              Get.offAll(ScreenMain());
                            },
                            child: Text(
                              'Conform',
                              style: GoogleFonts.poppins(
                                  fontSize: 15, color: Colors.blueAccent),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          content: Container(
            width: 250,
            height: 250,
            padding: EdgeInsets.all(11),
            color: Colors.white,
            child: Obx(
              () => (ctrl.loading.value == true)
                  ? CircularProgressIndicator()
                  : ListView(children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Are you assigning work to  ' + name + '?',
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'You can\'t undo this action',
                        style: GoogleFonts.poppins(fontSize: 18),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      
                      SizedBox(
                        height: 20,
                      ),
                    ]),
            ),
          ),
        );
      });
}
