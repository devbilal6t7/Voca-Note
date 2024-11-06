import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_speech_to_text_tutorial/consts/app_colors.dart';
import 'package:flutter_speech_to_text_tutorial/consts/assets.dart';
import '../Language Translator/language_translator.dart';
import '../Voice Message/voice_message_home.dart';
import '../Voice Recording/voice_recording.dart';
import '../Voice Search/search_engine_screen.dart';
import 'Lanugage Selection/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Padding(
              padding: const EdgeInsets.only(
                top: 0,
                bottom: 5,
                left: 13,
                right: 13,
              ),
              child: ListView.builder(
                itemCount: 9, // Number of menu items
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), // Disable ListView's own scrolling
                itemBuilder: (context, index) {
                  // Define menu items for the ListView
                  List<Widget> menuItems = [
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const VoiceMessageHome()));
                      },
                      child: _buildMenuItem(
                        icon: AppAssets.voiceMessage,
                        label: AppLocalizations.of(context)
                            .translate('voiceMessage'),
                        color: AppColors().appIconsColor,
                        tileColor: AppColors().firstTileColor,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const SoundRecorder()));
                      },
                      child: _buildMenuItem(
                        icon: AppAssets.mic,
                        label: AppLocalizations.of(context)
                            .translate('voiceRecording'),
                        color: AppColors().appIconsColor,
                        tileColor: AppColors().secondTileColor,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const SearchEngineScreen()));
                      },
                      child: _buildMenuItem(
                        icon: AppAssets.searchEngine,
                        label: AppLocalizations.of(context)
                            .translate('voiceSearch'),
                        color: AppColors().appIconsColor,
                        tileColor: AppColors().thirdTileColor,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const LanguageTranslateScreen()));
                      },
                      child: _buildMenuItem(
                        icon: AppAssets.translate,
                        label: AppLocalizations.of(context)
                            .translate('voiceTranslator'),
                        color: AppColors().appIconsColor,
                        tileColor: AppColors().fourthTileColor,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ];

                  return menuItems[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      {required String icon,
      required String label,
      required Color color,
      required Color tileColor}) {
    return Card(
      elevation: 11,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 60,
        height: 110,
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Image.asset(
                icon,
                width: 50,
                height: 50,
                color: AppColors().white,
              ),
            ),
            const SizedBox(width: 20),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
