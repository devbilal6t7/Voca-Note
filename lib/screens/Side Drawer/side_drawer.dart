import 'package:flutter/material.dart';
import 'package:flutter_speech_to_text_tutorial/consts/assets.dart';
import 'package:flutter_speech_to_text_tutorial/screens/Home%20Screen/Lanugage%20Selection/language_dropdown.dart';
import 'package:flutter_speech_to_text_tutorial/screens/privacy_policy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../consts/app_colors.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({
    super.key,
  });

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  String? _selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Load user data from SharedPreferences
  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage =
          _getLanguageName(prefs.getString('selectedLanguage') ?? 'en');
    });
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'ar':
        return 'Arabic';
      case 'zh':
        return 'Chinese';
      case 'fr':
        return 'French';
      case 'de':
        return 'German';
      case 'hi':
        return 'Hindi';
      case 'id':
        return 'Indonesian';
      case 'it':
        return 'Italian';
      case 'fa':
        return 'Persian';
      case 'pt':
        return 'Portuguese';
      case 'ru':
        return 'Russian';
      case 'es':
        return 'Spanish';
      case 'th':
        return 'Thai';
      case 'ur':
        return 'Urdu';
      default:
        return 'English'; // Default to English if no match
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors().navyBlue,
            ),
            child: Center(
              child: Text(
                'VOCA NOTE',
                style: GoogleFonts.rubik(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          // Language Selection Tile
          ListTile(
            title: Text(
              'Language',
              style:
                  GoogleFonts.rubik(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            trailing: Text(
              _selectedLanguage ?? 'English',
              style:
                  GoogleFonts.rubik(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => const LanguageDropdown()),
              );
            },
          ),
          const Divider(),
          // Privacy Policy Tile
          ListTile(
            title: Text(
              'Privacy Policy',
              style:
                  GoogleFonts.rubik(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            trailing: Icon(Icons.privacy_tip, color: AppColors().navyBlue),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyScreen()),
              );
            },
          ),
          const Divider(),
          // Privacy Policy Tile
          ListTile(
            title: Text(
              'App Version',
              style:
                  GoogleFonts.rubik(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            trailing: Text(
              "1.0",
              style:
                  GoogleFonts.rubik(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
