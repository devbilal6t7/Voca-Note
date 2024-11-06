import 'package:flutter/material.dart';
import 'package:flutter_speech_to_text_tutorial/consts/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:share/share.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as pathLib;
import '../../../consts/assets.dart';
import '../../Home Screen/Lanugage Selection/app_localizations.dart';

class RecordingManagerScreen extends StatefulWidget {
  final List<String> recordingPaths;

  const RecordingManagerScreen({super.key, required this.recordingPaths});

  @override
  State<StatefulWidget> createState() {
    return _RecordingManagerScreenState();
  }
}

class _RecordingManagerScreenState extends State<RecordingManagerScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();
  String? playingPath;

  @override
  void initState() {
    super.initState();

    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed ||
          state.processingState == ProcessingState.idle) {
        setState(() {
          playingPath = null;
        });
      }
    });
  }

  void _shareRecording(String path) async {
    try {
      await Share.shareFiles([path], text: 'Check out this recording!');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error sharing Recording ")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('recordings'),
          style: GoogleFonts.rubik(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 10,
        // shadowColor: Colors.black45,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        backgroundColor: AppColors().white,
      ),
      body: widget.recordingPaths.isEmpty
          ? Center(
              child: Container(
                height: 300,
                width: 300,
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
                  color: AppColors().white,
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: AppColors().sixthTileColor, width: 4),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)
                        .translate('noRecordingsAvailable'),
                    style: GoogleFonts.montserrat(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          : ListView.builder(
              itemCount: widget.recordingPaths.length,
              itemBuilder: (context, index) {
                final path = widget.recordingPaths[index];
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                    bottom: 0,
                    left: 8,
                    right: 8,
                  ),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors().sixthTileColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        tileColor: AppColors().sixthTileColor,
                        leading: const Icon(
                          Icons.audiotrack,
                          color: Colors.white,
                          size: 20,
                        ),
                        title: Text(
                          pathLib.basenameWithoutExtension(path),
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 8.5,
                          ),
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.left,
                        ),
                        trailing: SizedBox(
                          width: 95,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const SizedBox(width: 15),
                                IconButton(
                                  icon: playingPath == path
                                      ? Image.asset(
                                          AppAssets.pause,
                                          height: 15,
                                          width: 15,
                                          color: Colors.white,
                                        )
                                      : Image.asset(
                                          AppAssets.play,
                                          height: 15,
                                          width: 15,
                                          color: Colors.white,
                                        ),
                                  onPressed: () => _togglePlayPause(path),
                                ),
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
                                        _shareRecording(path);
                                        break;
                                      case 'delete':
                                        _deleteRecording(path);
                                        break;
                                      case 'rename':
                                        _showRenameDialog(path, index);
                                        break;
                                    }
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry<String>>[
                                    PopupMenuItem<String>(
                                      value: 'share',
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate('share'),
                                        style: GoogleFonts.montserrat(
                                          color: AppColors().sixthTileColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem<String>(
                                      value: 'delete',
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate('delete'),
                                        style: GoogleFonts.montserrat(
                                          color: AppColors().sixthTileColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem<String>(
                                      value: 'rename',
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate('rename'),
                                        style: GoogleFonts.montserrat(
                                          color: AppColors().sixthTileColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                  color: AppColors()
                                      .white, // Set the background color of the popup menu
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        12), // Rounded corners
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _togglePlayPause(String path) async {
    if (playingPath == path) {
      await audioPlayer.stop();
      setState(() {
        playingPath = null;
      });
    } else {
      await audioPlayer.setFilePath(path);
      audioPlayer.play();
      setState(() {
        playingPath = path;
      });
    }
  }

  void _deleteRecording(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }

    final prefs = await SharedPreferences.getInstance();
    List<String> recordingPaths = prefs.getStringList('recordingPaths') ?? [];
    recordingPaths.remove(path);
    await prefs.setStringList('recordingPaths', recordingPaths);

    setState(() {
      widget.recordingPaths.remove(path);
    });
  }

  void _showRenameDialog(String path, int index) {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors().sixthTileColor,
          title: Text(
            AppLocalizations.of(context).translate('renameRecord'),
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
          ),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(12)),
              hintText: AppLocalizations.of(context).translate('newName'),
              hintStyle: GoogleFonts.montserrat(
                  color: Colors.black, fontWeight: FontWeight.w400),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                      color: AppColors().appBackgroundColor,
                      borderRadius: BorderRadius.circular(11),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 5),
                        ),
                      ]),
                  child: TextButton(
                    onPressed: () {
                      _renameRecording(path, controller.text, index);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      AppLocalizations.of(context).translate('rename'),
                      style: GoogleFonts.montserrat(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors().appBackgroundColor,
                    borderRadius: BorderRadius.circular(11),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  width: 100,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      AppLocalizations.of(context).translate('cancel'),
                      style: GoogleFonts.montserrat(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  void _renameRecording(String oldPath, String newName, int index) async {
    final oldFile = File(oldPath);
    if (await oldFile.exists()) {
      final directory = oldFile.parent;
      final newPath = '${directory.path}/$newName.m4a';

      await oldFile.rename(newPath);


      final prefs = await SharedPreferences.getInstance();
      List<String> recordingPaths = prefs.getStringList('recordingPaths') ?? [];
      recordingPaths[index] = newPath;
      await prefs.setStringList('recordingPaths', recordingPaths);


      setState(() {
        widget.recordingPaths[index] = newPath;
      });
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
