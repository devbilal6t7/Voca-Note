import 'package:flutter/material.dart';
import 'package:flutter_speech_to_text_tutorial/consts/assets.dart';
import 'package:flutter_speech_to_text_tutorial/screens/Navigation/main_navigation_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../consts/app_colors.dart';
import '../../../main.dart';

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key});

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String? _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage(context);
  }

  Future<void> _loadSelectedLanguage(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('selectedLanguage');
    if (languageCode != null) {
      setState(() {
        _selectedLanguage = languageCode;
      });
      MyApp.setLocale(context, Locale(languageCode));
    }
  }

  Future<void> _saveSelectedLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', languageCode);
    setState(() {
      _selectedLanguage = languageCode;
    });
  }

  void _navigateToHomeScreen() {
    if (_selectedLanguage != null) {
      MyApp.setLocale(context, Locale(_selectedLanguage!));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainNavigationScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a language')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selected Language',
                style: GoogleFonts.rubik(
                    fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              _selectedLanguage != null
                  ? _buildSelectedLanguageTile(_selectedLanguage!)
                  : Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF39a2db),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors().navyBlue),
                ),
                child: ListTile(
                  title: Text(
                    'Please Select Language',
                    style: GoogleFonts.rubik(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.white),
                  ),
                  // trailing: Icon(Icons.check_circle, color: AppColors().white),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      AppAssets.flag,
                      height: 24,
                      width: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'All Languages',
                style: GoogleFonts.rubik(
                    fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: 10),
                  children: [
                    _buildLanguageTile('Arabic', 'ar'),
                    _buildLanguageTile('Chinese', 'zh'),
                    _buildLanguageTile('English (US)', 'en'),
                    _buildLanguageTile('Farsi', 'fa'),
                    _buildLanguageTile('French', 'fr'),
                    _buildLanguageTile('German', 'de'),
                    _buildLanguageTile('Hindi', 'hi'),
                    _buildLanguageTile('Indonesian', 'id'),
                    _buildLanguageTile('Italian', 'it'),
                    _buildLanguageTile('Japanese', 'ja'),
                    _buildLanguageTile('Portuguese', 'pt'),
                    _buildLanguageTile('Russian', 'ru'),
                    _buildLanguageTile('Spanish', 'es'),
                    _buildLanguageTile('Thai', 'th'),
                    _buildLanguageTile('Urdu', 'ur'),
                  ],
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: _navigateToHomeScreen,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors().navyBlue,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 70),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Save Settings',
                    style: GoogleFonts.rubik(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedLanguageTile(String languageCode) {
    String languageName = _getLanguageName(languageCode);
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF39a2db),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors().navyBlue),
      ),
      child: ListTile(

        title: Text(
          languageName,
          style: GoogleFonts.rubik(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.white),
        ),
        trailing: Icon(Icons.check_circle, color: AppColors().white),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Image.asset(
            AppAssets.flag,
            height: 24,
            width: 24,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageTile(String languageName, String languageCode) {
    bool isSelected = _selectedLanguage == languageCode;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors().navyBlue : Colors.grey.shade300,
        ),
      ),
      child: ListTile(
        title: Text(
          languageName,
          style: GoogleFonts.rubik(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        leading: CircleAvatar(
          backgroundColor: isSelected
              ? AppColors().navyBlue
              : AppColors().navyBlue.withOpacity(0.7),
          child: Image.asset(
            AppAssets.flag,
            height: 24,
            width: 24,
            color: Colors.white,
          ),
        ),
        trailing: Icon(
          isSelected
              ? Icons.radio_button_checked
              : Icons.radio_button_unchecked,
          color: isSelected ? AppColors().navyBlue : Colors.grey.shade600,
        ),
        onTap: () {
          _saveSelectedLanguage(languageCode);
        },
      ),
    );
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'English (US)';
      case 'es':
        return 'Spanish';
      case 'pt':
        return 'Portuguese';
      case 'de':
        return 'German';
      case 'it':
        return 'Italian';
      case 'fr':
        return 'French';
      case 'hi':
        return 'Hindi';
      case 'ur':
        return 'Urdu';
      case 'ru':
        return 'Russian';
      case 'zh':
        return 'Chinese';
      case 'id':
        return 'Indonesian';
      case 'th':
        return 'Thai';
      case 'ar':
        return 'Arabic';
      case 'fa':
        return 'Farsi';
      case 'ja':
        return 'Japanese';
      default:
        return 'English';
    }
  }

}
