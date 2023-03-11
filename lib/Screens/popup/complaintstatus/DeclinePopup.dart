import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qstart_admin_web/Screens/ScreenMain.dart';
import '../../../Controller/complainController.dart';
import '../../../helpers/inputBox.dart';

final ctrl = Get.put(ComplaintContoller());

//complaint decline alert popup

Future DeclinePopup(BuildContext ctx, var complaintid) async {
  return showDialog(
      context: ctx,
      builder: (ctx1) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                   Radius.circular(25),
                 )),
          content: Container(
            width: 500,
            height: 300,
            padding: EdgeInsets.all(11),
            color: Colors.white,
            child: Obx(
              () => (ctrl.loading == true)
                  ? CircularProgressIndicator()
                  : ListView(children: [
                      Center(
                          child: Text('Decline',
                              style: GoogleFonts.poppins(fontSize: 30))),
                      SizedBox(
                        height: 10,
                      ),
                      //description box
                      TextFormField(
                        controller: ctrl.declineDescription,
                        maxLines: 4,
                        keyboardType: TextInputType.multiline,
                        decoration: inputBoxes()
                            .maininputDecoration
                            .copyWith(label: const Text('Description')),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (ctrl.declineDescription == '') {
                            // Get.snackbar('Description',
                            //     'Add description before submitting');
                            Get.snackbar('Description', 'Add description before submitting',
                                colorText: Colors.white,
                                backgroundColor: Colors.redAccent.shade200,
                                icon: const Icon(Icons.add_alert),
                                maxWidth: double.infinity,
                                snackPosition: SnackPosition.BOTTOM,
                                margin: EdgeInsets.only(
                                    left: 1000, bottom: 30, right: 3));
                            return;
                          }
                          //
                          ctrl.DeclineWork(complaintid);
                          Get.offAll(ScreenMain());
                        },
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 39, 183, 240),
                              borderRadius:
                                  BorderRadius.circular(12)),
                          child: const Center(
                              child: Text(
                            'Submit',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          )),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text('Close'))
                    ]),
            ),
          ),
        );
      });
}
