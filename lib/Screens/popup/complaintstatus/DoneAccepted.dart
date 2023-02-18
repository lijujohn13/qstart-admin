import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qstart_admin_web/Screens/ScreenMain.dart';
import '../../../Controller/complainController.dart';

final ctrl = Get.put(ComplaintContoller());
// complaint verified popup
Future DoneAcceptedPopup(BuildContext ctx, var complaintid, var userid) async {
  return showDialog(
      context: ctx,
      builder: (ctx1) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          content: Container(
            width: 230,
            height: 230,
            padding: EdgeInsets.all(11),
            color: Colors.white,
            child: Obx(
              () => (ctrl.loading.value == true)
                  ? CircularProgressIndicator()
                  : ListView(children: [
                      Center(
                          child: Text('Conform ⚠️',
                              style: GoogleFonts.amaranth(
                                  fontSize: 30, fontWeight: FontWeight.bold))),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Conform',
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Work has completed successfully ?',
                        style: GoogleFonts.poppins(fontSize: 18),
                      ),
                      SizedBox(
                        height: 30,
                      ),
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
                                  ctrl.DoneVerified(complaintid, userid);

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
                      SizedBox(
                        height: 20,
                      ),
                    ]),
            ),
          ),
        );
      });
}
