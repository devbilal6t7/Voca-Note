import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../consts/app_colors.dart';
import '../../consts/assets.dart';
import '../Home Screen/Lanugage Selection/app_localizations.dart';

class VoiceMessageHome extends StatefulWidget {
  const VoiceMessageHome({super.key});

  @override
  State<VoiceMessageHome> createState() => _VoiceMessageHomeState();
}

class _VoiceMessageHomeState extends State<VoiceMessageHome> {
  final SpeechToText _speechToText = SpeechToText();

  bool _speechEnabled = false;
  String _wordsSpoken = "";
  double _confidenceLevel = 0;
  String _selectedLanguage = 'English';
  final List<String> languages = [
    'Abkhaz',
    'Afar',
    'Afrikaans',
    'Akan',
    'Albanian',
    'Amharic',
    'Arabic',
    'Armenian',
    'Assamese',
    'Avar',
    'Avestan',
    'Aymara',
    'Azerbaijani',
    'Bashkir',
    'Basque',
    'Belarusian',
    'Bemba',
    'Bengali',
    'Bhojpuri',
    'Bislama',
    'Bosnian',
    'Breton',
    'Bulgarian',
    'Burmese',
    'Catalan',
    'Cebuano',
    'Chichewa',
    'Chinese',
    'Chuvash',
    'Cornish',
    'Corsican',
    'Croatian',
    'Czech',
    'Danish',
    'Divehi',
    'Dutch',
    'Dzongkha',
    'Edo',
    'English',
    'Esperanto',
    'Estonian',
    'Ewe',
    'Fijian',
    'Finnish',
    'French',
    'Fula',
    'Galician',
    'Georgian',
    'German',
    'Gikuyu',
    'Guarani',
    'Gujarati',
    'Haitian Creole',
    'Hausa',
    'Hawaiian',
    'Hebrew',
    'Hindi',
    'Hmong',
    'Hungarian',
    'Icelandic',
    'Igbo',
    'Indonesian',
    'Interlingua',
    'Irish',
    'Italian',
    'Japanese',
    'Javanese',
    'Kalaallisut',
    'Kannada',
    'Kazakh',
    'Kinyarwanda',
    'Kirmanjki',
    'Kyrgyz',
    'Lao',
    'Latin',
    'Latvian',
    'Limburgish',
    'Lingala',
    'Lithuanian',
    'Luxembourgish',
    'Macedonian',
    'Malagasy',
    'Malay',
    'Malayalam',
    'Maltese',
    'Manx',
    'Mongolian',
    'Myanmar',
    'Nepali',
    'Norwegian',
    'Nyanja',
    'Occitan',
    'Oromo',
    'Ossetian',
    'Pali',
    'Pashto',
    'Persian',
    'Polish',
    'Portuguese',
    'Punjabi',
    'Quechua',
    'Romanian',
    'Russian',
    'Samoan',
    'Sanskrit',
    'Scots Gaelic',
    'Serbian',
    'Sesotho',
    'Shona',
    'Sindhi',
    'Sinhala',
    'Slovak',
    'Slovenian',
    'Somali',
    'Spanish',
    'Sundanese',
    'Swahili',
    'Swedish',
    'Tajik',
    'Tamil',
    'Tatar',
    'Telugu',
    'Thai',
    'Tigrinya',
    'Turkish',
    'Turkmen',
    'Twi',
    'Ukrainian',
    'Urdu',
    'Uzbek',
    'Vietnamese',
    'Welsh',
    'Wolof',
    'Xhosa',
    'Yoruba',
    'Zulu',
  ];

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      localeId: _getLocaleCode(_selectedLanguage), // Use the selected language
    );
    setState(() {
      _confidenceLevel = 0;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _saveMessage(String message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? messages = prefs.getStringList('messages') ?? [];
    messages.add(message);
    await prefs.setStringList('messages', messages);
  }

  void _onSpeechResult(result) {
    setState(() {
      _wordsSpoken = result.recognizedWords;
      _confidenceLevel = result.confidence;
      if (!_speechToText.isListening && _wordsSpoken.isNotEmpty) {
        _saveMessage(_wordsSpoken);
      }
    });
  }

  void _sendText() {
    if (_wordsSpoken.isNotEmpty) {
      Share.share(_wordsSpoken);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text(AppLocalizations.of(context).translate('snackBarNoShare')),
        ),
      );
    }
  }

  void _copyText() {
    if (_wordsSpoken.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: _wordsSpoken));
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text(AppLocalizations.of(context).translate('copiedToClipBoard')),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text(AppLocalizations.of(context).translate('snackBarNoCopy'),
        ),
         ),
      );
    }
  }

  void delete() {
    setState(() {
      _wordsSpoken = "";
      _confidenceLevel = 0;
    });
  }

  String _getLocaleCode(String language) {
    switch (language) {
      case 'Abkhaz':
        return 'ab';
      case 'Afar':
        return 'aa';
      case 'Afrikaans':
        return 'af';
      case 'Akan':
        return 'ak';
      case 'Albanian':
        return 'sq';
      case 'Amharic':
        return 'am';
      case 'Arabic':
        return 'ar';
      case 'Armenian':
        return 'hy';
      case 'Assamese':
        return 'as';
      case 'Avar':
        return 'av';
      case 'Avestan':
        return 'ae';
      case 'Aymara':
        return 'ay';
      case 'Azerbaijani':
        return 'az';
      case 'Bashkir':
        return 'ba';
      case 'Basque':
        return 'eu';
      case 'Belarusian':
        return 'be';
      case 'Bemba':
        return 'bem';
      case 'Bengali':
        return 'bn';
      case 'Bhojpuri':
        return 'bho';
      case 'Bislama':
        return 'bi';
      case 'Bosnian':
        return 'bs';
      case 'Breton':
        return 'br';
      case 'Bulgarian':
        return 'bg';
      case 'Burmese':
        return 'my';
      case 'Catalan':
        return 'ca';
      case 'Cebuano':
        return 'ceb';
      case 'Chichewa':
        return 'ny';
      case 'Chinese':
        return 'zh-cn';
      case 'Chuvash':
        return 'cv';
      case 'Cornish':
        return 'kw';
      case 'Corsican':
        return 'co';
      case 'Croatian':
        return 'hr';
      case 'Czech':
        return 'cs';
      case 'Danish':
        return 'da';
      case 'Divehi':
        return 'dv';
      case 'Dutch':
        return 'nl';
      case 'Dzongkha':
        return 'dz';
      case 'Edo':
        return 'edo';
      case 'English':
        return 'en';
      case 'Esperanto':
        return 'eo';
      case 'Estonian':
        return 'et';
      case 'Ewe':
        return 'ee';
      case 'Fijian':
        return 'fj';
      case 'Finnish':
        return 'fi';
      case 'French':
        return 'fr';
      case 'Fula':
        return 'ff';
      case 'Galician':
        return 'gl';
      case 'Georgian':
        return 'ka';
      case 'German':
        return 'de';
      case 'Gikuyu':
        return 'gik';
      case 'Guarani':
        return 'gn';
      case 'Gujarati':
        return 'gu';
      case 'Haitian Creole':
        return 'ht';
      case 'Hausa':
        return 'ha';
      case 'Hawaiian':
        return 'haw';
      case 'Hebrew':
        return 'he';
      case 'Hindi':
        return 'hi';
      case 'Hmong':
        return 'hmn';
      case 'Hungarian':
        return 'hu';
      case 'Icelandic':
        return 'is';
      case 'Igbo':
        return 'ig';
      case 'Indonesian':
        return 'id';
      case 'Interlingua':
        return 'ia';
      case 'Irish':
        return 'ga';
      case 'Italian':
        return 'it';
      case 'Japanese':
        return 'ja';
      case 'Javanese':
        return 'jv';
      case 'Kalaallisut':
        return 'kl';
      case 'Kannada':
        return 'kn';
      case 'Kazakh':
        return 'kk';
      case 'Kinyarwanda':
        return 'rw';
      case 'Kirmanjki':
        return 'kmr';
      case 'Kyrgyz':
        return 'ky';
      case 'Lao':
        return 'lo';
      case 'Latin':
        return 'la';
      case 'Latvian':
        return 'lv';
      case 'Limburgish':
        return 'li';
      case 'Lingala':
        return 'ln';
      case 'Lithuanian':
        return 'lt';
      case 'Luxembourgish':
        return 'lb';
      case 'Macedonian':
        return 'mk';
      case 'Malagasy':
        return 'mg';
      case 'Malay':
        return 'ms';
      case 'Malayalam':
        return 'ml';
      case 'Maltese':
        return 'mt';
      case 'Manx':
        return 'gv';
      case 'Mongolian':
        return 'mn';
      case 'Myanmar':
        return 'my';
      case 'Nepali':
        return 'ne';
      case 'Norwegian':
        return 'no';
      case 'Nyanja':
        return 'ny';
      case 'Occitan':
        return 'oc';
      case 'Oromo':
        return 'om';
      case 'Ossetian':
        return 'os';
      case 'Pali':
        return 'pi';
      case 'Pashto':
        return 'ps';
      case 'Persian':
        return 'fa';
      case 'Polish':
        return 'pl';
      case 'Portuguese':
        return 'pt';
      case 'Punjabi':
        return 'pa';
      case 'Quechua':
        return 'qu';
      case 'Romanian':
        return 'ro';
      case 'Russian':
        return 'ru';
      case 'Samoan':
        return 'sm';
      case 'Sanskrit':
        return 'sa';
      case 'Scots Gaelic':
        return 'gd';
      case 'Serbian':
        return 'sr';
      case 'Sesotho':
        return 'st';
      case 'Shona':
        return 'sn';
      case 'Sindhi':
        return 'sd';
      case 'Sinhala':
        return 'si';
      case 'Slovak':
        return 'sk';
      case 'Slovenian':
        return 'sl';
      case 'Somali':
        return 'so';
      case 'Spanish':
        return 'es';
      case 'Sundanese':
        return 'su';
      case 'Swahili':
        return 'sw';
      case 'Swedish':
        return 'sv';
      case 'Tajik':
        return 'tg';
      case 'Tamil':
        return 'ta';
      case 'Tatar':
        return 'tt';
      case 'Telugu':
        return 'te';
      case 'Thai':
        return 'th';
      case 'Tigrinya':
        return 'ti';
      case 'Turkish':
        return 'tr';
      case 'Turkmen':
        return 'tk';
      case 'Twi':
        return 'tw';
      case 'Ukrainian':
        return 'uk';
      case 'Uzbek':
        return 'uz';
      case 'Urdu':
        return 'ur';
      case 'Vietnamese':
        return 'vi';
      case 'Welsh':
        return 'cy';
      case 'Wolof':
        return 'wo';
      case 'Xhosa':
        return 'xh';
      case 'Yoruba':
        return 'yo';
      case 'Zulu':
        return 'zu';
      default:
        return 'en';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('voiceMessage'),
          style: GoogleFonts.rubik(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 7,
        shadowColor: Colors.black45,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        backgroundColor: AppColors().firstTileColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Row(
                children: [
                  Text(
                    'Select Language:',
                    style: GoogleFonts.rubik(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 320,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.grey.shade200],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 6,
                    spreadRadius: 2,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ],
              ),
              child: Center(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: AppColors().firstTileColor,
                    ),
                    iconSize: 30,
                    style: GoogleFonts.rubik(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    dropdownColor: Colors.white,
                    value: _selectedLanguage,
                    items: languages.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            value,
                            style: GoogleFonts.rubik(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedLanguage = newValue!;
                      });
                    },
                    borderRadius: BorderRadius.circular(8),
                    isExpanded: true,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 700,
                height: 400,
                decoration: BoxDecoration(
                  color: AppColors().firstTileColor.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
                      child: Center(
                        child: _wordsSpoken.isNotEmpty
                            ? Text(
                          _speechToText.isListening
                              ? "...${AppLocalizations.of(context).translate('listening')}"
                              : _speechEnabled
                              ? _wordsSpoken
                              : "This Device is not Compatible",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.rubik(
                            color: Colors.white,
                            fontSize: 21,
                          ),
                        )
                            : Text(
                          AppLocalizations.of(context).translate('startSpeaking'),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.rubik(
                            color: Colors.white,
                            fontSize: 21,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 9,
                      right: 16,
                      child: Row(
                        children: [

                          InkWell(
                            onTap: delete,
                            child: Image.asset(
                              AppAssets.deleteRed,
                              height: 35,
                              width: 35,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: _speechToText.isListening
                                  ? _stopListening
                                  : _startListening,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: _speechToText.isListening
                                    ? AppColors().firstTileColor
                                    : Colors.white,
                                child: InkWell(
                                  child: Image.asset(
                                    AppAssets.audio,
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors().white,
                      backgroundColor: AppColors().firstTileColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 10,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                    ),
                    onPressed: _copyText,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppLocalizations.of(context).translate('copy'),
                          style: GoogleFonts.rubik(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.copy,
                          color:AppColors().white,
                          size: 24,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors().white,
                      backgroundColor: AppColors().firstTileColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 10,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                    ),
                    onPressed: _sendText,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppLocalizations.of(context).translate('send'),
                          style: GoogleFonts.rubik(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 12),
                        Image.asset(
                          AppAssets.send,
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
