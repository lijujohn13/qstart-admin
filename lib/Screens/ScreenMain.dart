import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qstart_admin_web/Screens/SideBarScreens/Complaints.dart';
import 'package:qstart_admin_web/Screens/SideBarScreens/Dashboard.dart';
import 'package:qstart_admin_web/Screens/SideBarScreens/DeletedComplaints.dart';
import 'package:qstart_admin_web/Screens/SideBarScreens/Users.dart';
import 'package:qstart_admin_web/Screens/SideBarScreens/Workers.dart';
import 'package:qstart_admin_web/Screens/popup/changePasswordPopup.dart';

import '../Controller/loginController.dart';

class ScreenMain extends StatefulWidget {
  const ScreenMain({super.key});

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  int _selectedIndex = 0;
  bool showNavigationBar = true;
  final ctrl = Get.put(loginController());
  var list = [
    DashboardScreen(),
    UserScreen(),
    ComplaintScreen(),
    WorkerScreen(),
    DeletedComplaints()
  ];

  var title = [
    "HomePage",
    'WalkPage',
    'LocationPage',
    'NotificationPage',
    'SettingsPage',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.grey[100],
        
        title:  Text(
          (_selectedIndex!=0)?
          'QSTART':
          '',
          style:
              GoogleFonts.amaranth(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          // IconButton(
          //   onPressed: (){}, icon: Icon(FontAwesomeIcons.caretDown,color: Colors.black,))
          PopupMenuButton(
            icon: Icon(
              FontAwesomeIcons.caretDown,
              color: Colors.black,
              size: 30,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("Change Password"),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text("Logout"),
                ),
              ];
            },
            onSelected: ((value) {
              if(value == 0){
                changePasswordpopup(context);
            }else if(value == 1){
               ctrl.signout();
            }
            }),
          )
        ],
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                showNavigationBar = !showNavigationBar;
              });
            }),
      ),
      body: Row(
        children: <Widget>[
          Visibility(
            visible: showNavigationBar,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: NavigationRail(
                selectedIconTheme: IconThemeData(color: Colors.lightBlueAccent),
                selectedLabelTextStyle: GoogleFonts.poppins(
                    color: Colors.lightBlueAccent, fontWeight: FontWeight.bold),
                unselectedLabelTextStyle:
                    GoogleFonts.poppins(color: Colors.black),
                selectedIndex: _selectedIndex,
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                labelType: NavigationRailLabelType.all,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.dashboard_sharp),
                    selectedIcon: Icon(Icons.dashboard),
                    label: Text('Dashboard'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(FontAwesomeIcons.usersRays),
                    selectedIcon: Icon(FontAwesomeIcons.users),
                    label: Text('Users'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(FontAwesomeIcons.boxesStacked),
                    selectedIcon: Icon(FontAwesomeIcons.box),
                    label: Text('Complaints'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(FontAwesomeIcons.wrench),
                    selectedIcon: Icon(FontAwesomeIcons.screwdriverWrench),
                    label: Text('Workers'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(FontAwesomeIcons.solidTrashCan),
                    selectedIcon: Icon(FontAwesomeIcons.trash),
                    label: Text('     Deleted\nComplaints'),
                  ),
                ],
              ),
            ),
          ),
          VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: list[_selectedIndex],
          )
        ],
      ),
    );
  }
}
