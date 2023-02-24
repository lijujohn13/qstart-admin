import 'dart:js_util';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 18,right: 18,left: 18),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Container(
                height: 200,
                width: 200,
                child: Image.asset('assets/images/footer2.png',fit: BoxFit.cover,),
              ),

              //social media
              Column(
                children: [
                    Text('Follow as on social media',style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 15),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Image.asset('assets/images/instagram.png',fit: BoxFit.cover,height: 20,width: 20,),
                          Image.asset('assets/images/linkedin.png',fit: BoxFit.cover,height: 20,width: 20,),
                          Image.asset('assets/images/twitter.png',fit: BoxFit.cover,height: 20,width: 20,),
                      ],
                    )
                ],
              )
            ]),
            Divider(thickness: 0.5,),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
              Icon(FontAwesomeIcons.solidCopyright,size: 15,),
                  Text(' 2023  qstartoffical  |  All Rights Reserved',style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w400),)
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}