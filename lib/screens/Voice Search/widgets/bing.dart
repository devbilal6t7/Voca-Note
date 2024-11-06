import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../consts/app_bar.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/assets.dart';

class Bing extends StatefulWidget {
  const Bing({super.key});

  @override
  State<Bing> createState() => _BingState();
}

class _BingState extends State<Bing> {
  final SpeechToText _speechToText = SpeechToText();

  bool _speechEnabled = false;
  String _wordsSpoken = "";
  double _confidenceLevel = 0;

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
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      _confidenceLevel = 0;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(result) {
    setState(() {
      _wordsSpoken = result.recognizedWords;
      _confidenceLevel = result.confidence;
      if (!_speechToText.isListening && _wordsSpoken.isNotEmpty) {}
    });
  }





  void delete() {
    setState(() {
      _wordsSpoken = "";
      _confidenceLevel = 0;
    });
  }

  Future<void> openAppWebView(String url) async {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().appBackgroundColor,
        appBar:  AppBar(
          foregroundColor: Colors.white,
          title: Text(
            'Bing',
            style: GoogleFonts.rubik(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          backgroundColor: AppColors().thirdTileColor,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined,size: 20,),
          ),
        ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: 700,
                  height: 500,
                  decoration: BoxDecoration(
                    color: AppColors().thirdTileColor.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 25),
                        child: Center(
                            child: _wordsSpoken.isNotEmpty
                                ? Text(
                                    _speechToText.isListening
                                        ? "listening..."
                                        : _speechEnabled
                                            ? _wordsSpoken
                                            : "This Device is not Compatible",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.rubik(
                                      color: Colors.white,
                                      fontSize: 23,
                                    ),
                                  )
                                : Text(
                                    'Search Bing Through Voice',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.rubik(
                                      color: Colors.white,
                                      fontSize: 23,
                                    ),
                                  ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (_wordsSpoken.isNotEmpty) {
                                      openAppWebView(
                                          'https://www.bing.com/search?q=$_wordsSpoken');
                                    }
                                  });
                                },
                                child:  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: Image.asset(
                                      AppAssets.search,
                                      height: 28,
                                      width: 28,
                                    ),
                                ),
                              ),
                              InkWell(
                                onTap: delete,
                                child:  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: Image.asset(
                                      AppAssets.deleteRed,
                                      height: 29,
                                      width: 29,
                                    ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
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
                              ? AppColors().thirdTileColor
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
    );
  }
}
