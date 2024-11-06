import 'package:flutter/material.dart';
import 'package:flutter_speech_to_text_tutorial/consts/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Home Screen/Lanugage Selection/app_localizations.dart';
import '../Voice Message/widgets/saved_messages.dart';
import '../Voice Recording/widgets/recording_manager.dart';

class HistoryItems extends StatefulWidget {
  const HistoryItems({super.key});

  @override
  State<HistoryItems> createState() => _HistoryItemsState();
}

class _HistoryItemsState extends State<HistoryItems> {
  List<String> recordingPaths = [];

  @override
  void initState() {
    super.initState();
    _loadRecordingPaths();
  }

  Future<void> _loadRecordingPaths() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      recordingPaths = prefs.getStringList('recordingPaths') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined,size: 20,),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('history'),
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
        backgroundColor: AppColors().sixthTileColor,
      ),
      backgroundColor: AppColors().white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => RecordingManagerScreen(
                        recordingPaths: recordingPaths,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: AppColors().sixthTileColor,
                    // borderRadius: BorderRadius.circular(12),
                  ),
                  height: 300,
                  width: 300,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context).translate('recordings'),
                      style: GoogleFonts.montserrat(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_)=> const SavedMessagesScreen())
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: AppColors().sixthTileColor,
                    // borderRadius: BorderRadius.circular(12),
                  ),
                  height: 300,
                  width: 300,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context).translate('voiceMessages'),
                      style: GoogleFonts.montserrat(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
