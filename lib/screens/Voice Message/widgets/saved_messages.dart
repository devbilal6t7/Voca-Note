import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_bar.dart';
import '../../../consts/assets.dart';
import '../../Home Screen/Lanugage Selection/app_localizations.dart';

class SavedMessagesScreen extends StatefulWidget {
  const SavedMessagesScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SavedMessagesScreenState();
  }
}

class _SavedMessagesScreenState extends State<SavedMessagesScreen> {
  List<String> _savedMessages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedMessages = prefs.getStringList('messages') ?? [];
    });
  }

  void _deleteMessage(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _savedMessages.removeAt(index);
    });

    await prefs.setStringList('messages', _savedMessages);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context).translate('messageDel')),
      ),
    );
  }

  void _shareMessage(String message) {
    Share.share(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('savedMessages'),
          style: GoogleFonts.rubik(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 30,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        backgroundColor: AppColors().white,
      ),
      body: ListView.builder(
        itemCount: _savedMessages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 16,
              right: 8,
              left: 8,
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              tileColor: AppColors().sixthTileColor,
              leading: Text(
                '${index + 1}',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              title: Text(
                _savedMessages[index],
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 16,
                ),
                overflow: TextOverflow.clip,
                textAlign: TextAlign.left,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PopupMenuButton<String>(
                    icon: Image.asset(
                      AppAssets.menu,
                      height: 20,
                      width: 20,
                      color: Colors.white,
                    ),
                    onSelected: (value) {
                      switch (value) {
                        case 'share':
                          _shareMessage(_savedMessages[index]);
                          break;
                        case 'delete':
                          _deleteMessage(index);
                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'share',
                        child: Text(
                          AppLocalizations.of(context).translate('share'),
                          style: GoogleFonts.montserrat(
                              color: AppColors().sixthTileColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'delete',
                        child: Text(
                          AppLocalizations.of(context).translate('delete'),
                          style: GoogleFonts.montserrat(
                              color: AppColors().sixthTileColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                    color: AppColors()
                        .white, // Set the background color of the popup menu
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Rounded corners
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
