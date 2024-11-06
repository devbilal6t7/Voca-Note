import 'package:flutter/material.dart';
import 'package:flutter_speech_to_text_tutorial/consts/app_colors.dart';
import 'package:flutter_speech_to_text_tutorial/screens/Voice%20Search/widgets/duck.dart';
import 'package:flutter_speech_to_text_tutorial/screens/Voice%20Search/widgets/wiki.dart';
import 'package:flutter_speech_to_text_tutorial/screens/Voice%20Search/widgets/yahoo.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Home Screen/Lanugage Selection/app_localizations.dart';
import 'widgets/bing.dart';
import 'widgets/google.dart';

class SearchEngineScreen extends StatelessWidget {
  const SearchEngineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColors().white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('searchEngine'),
          style: GoogleFonts.rubik(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 8,
        shadowColor: Colors.black45,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        backgroundColor: AppColors().thirdTileColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20,),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children:  [
                  SearchOptionTile(
                    imagePath: 'assets/images/google.png',
                    title: 'Google',
                    onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=> const Google(),)
                    );
                  },
                  ),
                  SearchOptionTile(
                    imagePath: 'assets/images/bing.png',
                    title: 'Bing',
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=> const Bing(),)
                      );
                    },
                  ),
                  SearchOptionTile(
                    imagePath: 'assets/images/duckduckgo.png',
                    title: 'Duck Duck Go',
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=> const Duck(),)
                      );
                    },
                  ),
                  SearchOptionTile(
                    imagePath: 'assets/images/yahoo.png',
                    title: 'Yahoo',
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=> const Yahoo(),)
                      );
                    },
                  ),
                  SearchOptionTile(
                    imagePath: 'assets/images/wiki.png',
                    title: 'Wikipedia',
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=> const Wikipedia(),)
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchOptionTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final void Function() onTap;

  const SearchOptionTile({super.key, required this.imagePath, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),

        ),
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 40),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}