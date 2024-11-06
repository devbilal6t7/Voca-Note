import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translator/translator.dart';
import 'package:flutter/services.dart';
import '../../consts/app_colors.dart';
import '../../consts/assets.dart';
import '../Home Screen/Lanugage Selection/app_localizations.dart';

class LanguageTranslateScreen extends StatefulWidget {
  const LanguageTranslateScreen({super.key});

  @override
  State<LanguageTranslateScreen> createState() =>
      _LanguageTranslateScreenState();
}

class _LanguageTranslateScreenState extends State<LanguageTranslateScreen> {
  final translator = GoogleTranslator();
  String selectedLanguage = 'English';
  // String inputText = '';
  String translatedText = '';
  final TextEditingController _controller = TextEditingController();

  // late stt.SpeechToText _speech;
  // bool _isListening = false;
  // String _speechText = '';

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
    // _speech = stt.SpeechToText();
  }

  Future<void> _translateText() async {
    final targetLanguage = _getLanguageCode(selectedLanguage);
    final translation =
        await translator.translate(_controller.text, to: targetLanguage);
    setState(() {
      translatedText = translation.text;
    });
  }

  String _getLanguageCode(String language) {
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

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: translatedText));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(translatedText.isNotEmpty
            ? 'Copied to clipboard!'
            : AppLocalizations.of(context).translate('snackBarNoCopy')),
        duration: const Duration(seconds: 1),
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('translateLanguage'),
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
        backgroundColor: AppColors().fourthTileColor,
      ),
      backgroundColor: AppColors().appBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 170,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  color: AppColors().appBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors().fourthTileColor, width: 4),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: GoogleFonts.rubik(fontSize: 18),
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: AppLocalizations.of(context).translate('translateTextField'),
                          hintStyle: GoogleFonts.rubik(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Center(
                  child: Text(
                    AppLocalizations.of(context).translate('selectLanguage'),
                style: GoogleFonts.rubik(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
              ),
              ),
              const SizedBox(height: 13),
              // Language DropdownButton
              DropdownButtonFormField<String>(
                value: selectedLanguage,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLanguage = newValue!;
                  });
                },
                items: languages.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.rubik(
                          fontSize: 16, color: Colors.black87),
                    ),
                  );
                }).toList(),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: AppColors().fourthTileColor, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: AppColors().fourthTileColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: AppColors().fourthTileColor, width: 2),
                  ),
                ),
                dropdownColor: Colors.white,
                icon:  Icon(Icons.arrow_drop_down,
                    color: AppColors().fourthTileColor, size: 28),
                style: GoogleFonts.rubik(fontSize: 16, color: Colors.black87),
                isExpanded: true,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: _translateText,
                style: ElevatedButton.styleFrom(
                  elevation: 7,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context).translate('translate'),
                      style: GoogleFonts.rubik(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Image.asset(
                      AppAssets.translator,
                      height: 29,
                      width: 29,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                height: 170,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  color: AppColors().appBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors().fourthTileColor, width: 4),
                ),
                child: TextField(
                  controller: TextEditingController(text: translatedText),
                  enabled: false,
                  maxLines: null,
                  style: GoogleFonts.rubik(fontSize: 18),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:AppLocalizations.of(context).translate('getTranslation'),
                    hintStyle: GoogleFonts.rubik(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _copyToClipboard,
                style: ElevatedButton.styleFrom(
                  elevation: 7,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context).translate('copyTo'),
                      style: GoogleFonts.rubik(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.copy,
                      color: AppColors().fourthTileColor,
                      size: 23,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
