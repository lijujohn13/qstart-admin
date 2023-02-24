import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qstart_admin_web/Screens/popup/complaintsortoneachpage/dashboardComplaint.dart';
import 'package:qstart_admin_web/Screens/widgets/footer.dart';
import '../../Controller/loginController.dart';
import '../widgets/card_item.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = '\DashboardScreen';

   DashboardScreen({super.key});
final ctrl = Get.put(loginController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      //main listview
      child: ListView(
        
        physics: BouncingScrollPhysics(),
        children: [
          //top stack
          Stack(
            children: [
              //top container with grey color
              Container(
                  height: 110,
                  width: size.width,
                  decoration: BoxDecoration(
                      // gradient: AppColor().dashboardGradient,
                      color: Colors.grey[100])),
                
              //logo in a container with aligned bottomcenter in stack
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.cover,
                    ),
                  )),
            ],
          ),
          SizedBox(height: 10,),
          //title and quote
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('QSTART',
              
                style: GoogleFonts.amaranth(
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                )),
            Text('\"Where the question ends, we begin\"',
                style: GoogleFonts.firaSans(
                  fontSize: 25,
                )),
            ],
          ),
          Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Dashboard',style: GoogleFonts.anybody(
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey
                  ),),
                ),

          SizedBox(height: 20,),
          //compaint status title text
          Padding(
            padding: const EdgeInsets.only(left: 20,bottom: 10),
            child: Text('Complaints Status :',style: GoogleFonts.poppins(
              color: Color.fromARGB(255, 92, 91, 91),
              fontSize: 20,
              fontWeight: FontWeight.bold
              ),),
          ),
          
          //cards
          Obx(
            ()=>Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                    
                    dashboardComplaintpopup(context,ctrl.isdone.toInt(),'Done');
                    },
                    child: CardItem(
                     
                      title: "Done",
                      subtitle: "No. of complaints ",
                      value: ctrl.isdone.toString(),
                      color1: Colors.lightGreen.shade400,
                      color2: Colors.lightGreen,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
          
            dashboardComplaintpopup(context, ctrl.isProcessing.toInt(),'Processing');
                    },
                    child: CardItem(
                      title: "Processing",
                      subtitle: "No. of complaints ",
                      value: ctrl.isProcessing.toString(),
                      color1: Colors.lightBlueAccent,
                      color2: Colors.blue,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
      
        dashboardComplaintpopup(context,ctrl.isDeclined.toInt(),'Declined');
                    },
                    child: CardItem(
                      title: "Declined",
                      subtitle: "No. of complaints ",
                      value: ctrl.isDeclined.toString(),
                      color1: Colors.redAccent,
                      color2: Colors.red,
                    ),
                  ),
                 
          
                ],
              ),
          ),
             Obx(
              ()=> Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
               GestureDetector(
                onTap: (){
                  
                  dashboardComplaintpopup(context,ctrl.isRequested.toInt(),'Requested');
                },
                 child: CardItem(
                      
                         title: "Requested",
                         subtitle: "No. of complaints ",
                         value: ctrl.isRequested.toString(),
                         color1: Colors.purple.shade700,
                         color2: Colors.purple,
                           ),
               ),
                         GestureDetector(
                onTap: (){
                     
                  dashboardComplaintpopup(context,ctrl.isPending.toInt(),'Pending');
                },
                child: CardItem(
                     
                        title: "Pending",
                        subtitle: "No. of complaints ",
                        value: ctrl.isPending.toString(),
                        color1: Colors.orange.shade700,
                        color2: Colors.orange,
                ),
                         ),
                         GestureDetector(
                onTap: (){
                 
                       dashboardComplaintpopup(context,ctrl.isverified.toInt(),'Verified');
                },
                child: CardItem(
                      
                        title: "Done Verified",
                        subtitle: "No. of complaints ",
                        value: ctrl.isverified.toString(),
                        color1: Colors.green.shade700,
                        color2: Colors.green,
                ),
                         ),
                       ],
                         ),
             ),
            
           Footer(),
        ],
      ),
    );
  }

  

  
  
}
