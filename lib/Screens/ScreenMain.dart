import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qstart_admin_web/Screens/SideBarScreens/Complaints.dart';
import 'package:qstart_admin_web/Screens/SideBarScreens/Dashboard.dart';
import 'package:qstart_admin_web/Screens/SideBarScreens/DeletedComplaints.dart';
import 'package:qstart_admin_web/Screens/SideBarScreens/Users.dart';
import 'package:qstart_admin_web/Screens/SideBarScreens/Workers.dart';

class ScreenMain extends StatefulWidget {
  const ScreenMain({super.key});

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  Widget selectedItem = DashboardScreen();

  screenSelector(item) {
    switch (item.route) {
      //dashboard
      case DashboardScreen.routeName:
        setState(() {
          selectedItem = DashboardScreen();
        });
        break;
        //users
        case UserScreen.routeName:
        setState(() {
          selectedItem = UserScreen();
        });
        break;
        //complaints
        case ComplaintScreen.routeName:
        setState(() {
          selectedItem = ComplaintScreen();
        });
        break;
        //workers
        case WorkerScreen.routeName:
        setState(() {
          selectedItem = WorkerScreen();
        });
        break;
        //deleted complaints
        case DeletedComplaints.routeName:
        setState(() {
          selectedItem = DeletedComplaints();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      sideBar: SideBar(
        backgroundColor: Color.fromARGB(255, 203, 209, 215),
        borderColor: Color.fromARGB(255, 203, 209, 215),
        
        items: [
          //dashboard
          AdminMenuItem(
            title: 'Dashboard',
            icon: Icons.dashboard,
            route: DashboardScreen.routeName,
          ),
          //User
          AdminMenuItem(
            title: 'Users',
            icon: FontAwesomeIcons.users,
            route: UserScreen.routeName,
          ),
          //Complaint
          AdminMenuItem(
            title: 'Complaints',
            icon: FontAwesomeIcons.box,
            route: ComplaintScreen.routeName,
          ),
          //Worker
          AdminMenuItem(
            title: 'Workers',
            icon: FontAwesomeIcons.hammer,
            route: WorkerScreen.routeName,
          ),
          //Deleted complaints
          AdminMenuItem(
            title: 'Deleted Complaints',
            icon: FontAwesomeIcons.trash,
            route: DeletedComplaints.routeName,
          ),
        ],
        selectedRoute: '',onSelected: ((item) => screenSelector(item)),
        // header: Container(
        //   height: 50,
        //   width: double.infinity,
        //   color: Color.fromARGB(255, 203, 209, 215),
        //   child: Center(
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
                
        //         Text(
        //           '  Welcome Admin !   ',
        //           style: GoogleFonts.poppins(
        //             color: Color.fromARGB(255, 57, 56, 56),
        //             fontWeight: FontWeight.w500,
        //           ),
        //         ),FaIcon(
        //           FontAwesomeIcons.hands,
        //           size: 15,
        //           color: Color.fromARGB(255, 57, 56, 56),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
      appBar: AppBar(
        title: Text(
          'QSTART',
          style:
              GoogleFonts.amaranth(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlue,
        // backgroundColor: Colors.transparent,
        // centerTitle: true,
      ),
      body: selectedItem);
  }
}
