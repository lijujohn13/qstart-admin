import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';


class CardItem extends StatelessWidget {
  final String subtitle;
  final String title;
  final String value;
  final Color color1;
  final Color color2;
 

  const CardItem(
      {Key? key,
      required this.title,
      required this.value,
      required this.color1,
      required this.color2,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
         builder: (context, sizingInformation){
           double titleSize = sizingInformation.screenSize.width <= 600 ? 12 : 16;
           return Padding(
             padding: const EdgeInsets.all(8.0),
             child: Container(
               height: 80,
               width: MediaQuery.of(context).size.width / 4,
               decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(8),
                   gradient: LinearGradient(
                       colors: [color1, color2],
                       begin: Alignment.bottomLeft,
                       end: Alignment.topRight),
                   boxShadow: [
                     BoxShadow(
                         color: Color.fromARGB(255, 224, 224, 224), offset: Offset(0, 3), blurRadius: 16)
                   ]),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Expanded(
                     child: ListTile(
                       title: Text(
                         title,
                         style: GoogleFonts.poppins(
                          fontSize: titleSize,
                         fontWeight: FontWeight.bold,
                         color: Colors.white,
                         ),
                       ),
                       subtitle: Text(
                          subtitle,
                          style: GoogleFonts.poppins( fontSize: titleSize,
                         fontWeight: FontWeight.w400,
                         color: Colors.white,)
                        
                       ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(right: 14),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text(
                            value,
                            style: GoogleFonts.poppins(
                              fontSize: titleSize + 18,
                           fontWeight: FontWeight.bold,
                           color: Colors.white,
                            )
                           
                         ),
                       ],
                     ),
                   ),
                 ],
               ),
             ),
           );
         },
    );
  }
}
