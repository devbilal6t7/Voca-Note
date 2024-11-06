import 'package:flutter/material.dart';
import 'package:flutter_speech_to_text_tutorial/consts/assets.dart';
import 'package:flutter_speech_to_text_tutorial/screens/Home%20Screen/home_screen.dart';
import 'package:flutter_speech_to_text_tutorial/screens/Home%20Screen/home_two.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../consts/app_colors.dart';
import '../Home Screen/Lanugage Selection/app_localizations.dart';
import '../Side Drawer/side_drawer.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key,});


  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  var currentIndex = 0;
  List screens = [
    const HomeScreen(),
    const HomeTwo(),
  ];
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.cyan,
        shape: RoundedRectangleBorder(
          // Rounded corners for the dialog
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          'Exit App?',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        content: Text(
          'Are you sure you want to exit the app?',
          style: GoogleFonts.rubik(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () =>
                Navigator.of(context).pop(false),
            child: Text(
              'No',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context)
                .pop(true), // Go back to previous screen
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Yes',
                style: GoogleFonts.montserrat(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    )) ??
        false;
  }
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: SideDrawer(),
        backgroundColor: AppColors().white,
        appBar: AppBar(
          foregroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context).translate('appBar'),
            style: GoogleFonts.rubik(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          elevation: 30,
          // shadowColor: Colors.black45,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          backgroundColor: AppColors().white,
        ),
        body: screens[currentIndex],
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
            topRight: Radius.circular(28),
            topLeft: Radius.circular(28),
          )),
          child: BottomNavigationBar(
              elevation: 8,
              backgroundColor: AppColors().white,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black26,
              currentIndex: currentIndex,
              unselectedLabelStyle: GoogleFonts.rubik(
                fontWeight: FontWeight.bold,
              ),
              selectedLabelStyle: GoogleFonts.rubik(
                fontWeight: FontWeight.bold,
              ),
              onTap: (index) => setState(() {
                    currentIndex = index;
                  }),
              items: [
                BottomNavigationBarItem(
                    icon: Image.asset(
                      AppAssets.dashboard,
                      height: 23,
                      color: Colors.black54,
                    ),
                    label: 'Dashboard'),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      AppAssets.more,
                      height: 23,
                      color: Colors.black54,
                    ),
                    label: 'More'),
              ]),
        ),
      ),
    );
  }
}
