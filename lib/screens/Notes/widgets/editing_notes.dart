import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../../consts/app_bar.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/assets.dart';
import '../../Home Screen/Lanugage Selection/app_localizations.dart';
import '../notes.dart';

class NoteEditScreen extends StatefulWidget {
  final Note? note;

  const NoteEditScreen({super.key, this.note});

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}
class _NoteEditScreenState extends State<NoteEditScreen> {
  late TextEditingController _controller;
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _speechText = '';
  String _selectedLanguage = 'English';


  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.note?.content ?? '');
  }



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().appBackgroundColor,
      appBar : AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          widget.note == null ? AppLocalizations.of(context).translate('addNote') : AppLocalizations.of(context).translate('editNote'),
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
        backgroundColor: AppColors().fifthTileColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Container(
                height: 450,
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
                  border: Border.all(color: AppColors().fifthTileColor, width: 4),
                ),
                child: TextField(
                  controller: _controller,
                  style: GoogleFonts.rubik(fontSize: 18),
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: AppLocalizations.of(context).translate('noteContent'),
                    hintStyle: GoogleFonts.rubik(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 63,
        width: 63,
        child: FloatingActionButton(
          backgroundColor: AppColors().fifthTileColor,
          onPressed: () {
            if (_controller.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(
                  content: Text(
                    AppLocalizations.of(context).translate('noteCannotEmptySnackBar'),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            } else {
              Navigator.pop(context, _controller.text);
            }
          },
          child: const Icon(
            Icons.save_alt_rounded,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}