import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controller/loginController.dart';
import '../../helpers/inputBox.dart';


final ctrl = Get.put(loginController());

//popup for change password (from appbar)
Future changePasswordpopup(BuildContext ctx) async {
    return showDialog(
        context: ctx,
        builder: (ctx1) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25))),
            content: Container(
              width: 500,
              height: 450,
              padding: EdgeInsets.all(11),
              color: Colors.white,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Container(
                      height: 200,
                      width: 200,
                      child: Image.asset('assets/images/changepassword.gif'),
                    ),
                    Text('Reset Password',
                        style: GoogleFonts.poppins(fontSize: 30,fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Send password reset email to\n \'qstartoffical@gmail.com\' ',
                        style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async{
                        
                        ctrl.changePassword();
                      
                      },
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 39, 183, 240),
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                            child: Text(
                          'Send Reset Link',
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
                          Navigator.of(ctx).pop();
                        },
                        child: const Text('Close'))
                  ]),
                ),
              ),
            ),
          );
        });
}