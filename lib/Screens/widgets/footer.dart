import 'package:flutter/material.dart';
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
             

            //   //social media
            //   Column(
            //     children: [
            //         Text('Follow as on social media',style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 15),),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //               Image.asset('assets/images/instagram.png',fit: BoxFit.cover,height: 20,width: 20,),
            //               Image.asset('assets/images/linkedin.png',fit: BoxFit.cover,height: 20,width: 20,),
            //               Image.asset('assets/images/twitter.png',fit: BoxFit.cover,height: 20,width: 20,),
            //           ],
            //         )
            //     ],
            //   )
            // ]),
            Divider(thickness: 0.5,),
            Padding(
              padding: const EdgeInsets.only(bottom: 20,top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
              Icon(FontAwesomeIcons.copyright,size: 15,),
                  Text(' 2023  qstartoffical  |  All Rights Reserved',style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w400),)
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}