import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_speech_to_text_tutorial/screens/Home%20Screen/Lanugage%20Selection/language_dropdown.dart';
import 'package:flutter_speech_to_text_tutorial/screens/Home%20Screen/Lanugage%20Selection/app_localizations.dart';
import 'package:flutter_speech_to_text_tutorial/screens/Navigation/main_navigation_screen.dart';
import 'package:flutter_speech_to_text_tutorial/screens/Splash%20Screen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  bool _isLanguageSelected = false;

  @override
  void initState() {
    super.initState();
    _checkLanguageSelection();
  }

  Future<void> _checkLanguageSelection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('selectedLanguage');
    if (languageCode != null) {
      setState(() {
        _locale = Locale(languageCode);
        _isLanguageSelected = true;
      });
    }
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), Locale('es'), Locale('pt'), Locale('de'), Locale('it'),
        Locale('fr'), Locale('hi'), Locale('ur'), Locale('ru'), Locale('zh'),
        Locale('id'), Locale('th'), Locale('ar'), Locale('fa')
      ],
      home: _isLanguageSelected ? const SplashScreen() : const LanguageDropdown(),
    );
  }
}
