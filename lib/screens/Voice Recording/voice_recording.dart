import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Home Screen/Lanugage Selection/app_localizations.dart';
import 'widgets/recording_manager.dart';
import '../../consts/app_bar.dart';
import '../../consts/app_colors.dart';
import '../../consts/assets.dart';

class SoundRecorder extends StatefulWidget {
  const SoundRecorder({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SoundRecorderState();
  }
}

class _SoundRecorderState extends State<SoundRecorder> {
  final AudioRecorder audioRecorder = AudioRecorder();
  final AudioPlayer audioPlayer = AudioPlayer();

  String? recordingPath;
  bool isRecording = false;
  Duration recordingDuration = Duration.zero;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    audioPlayer.dispose();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        recordingDuration += const Duration(milliseconds: 100);
      });
    });
  }

  void stopTimer() {
    timer?.cancel();
    setState(() {
      recordingDuration = Duration.zero;
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final milliseconds = twoDigits(duration.inMilliseconds.remainder(1000) ~/ 10);
    return "$minutes : $seconds : $milliseconds";
  }

  Future<void> _saveRecordingPath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> recordingPaths = prefs.getStringList('recordingPaths') ?? [];
    recordingPaths.add(path);
    await prefs.setStringList('recordingPaths', recordingPaths);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('record'),
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
        backgroundColor: AppColors().secondTileColor,
        // actions: [
        //   IconButton(
        //     icon: const Icon(
        //       Icons.edit,
        //       size: 20,
        //     ),
        //     onPressed: () {
        //       Navigator.of(context).pushReplacement(
        //           MaterialPageRoute(builder: (context) => LanguageDropdown()));
        //     },
        //   ),
        // ],
      ),
      backgroundColor: AppColors().white,
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (recordingPath != null)
            _buildRecordingContainer(),
          if (recordingPath == null)
            _buildRecordingContainer(),
        ],
      ),
    );
  }

  Widget _buildRecordingContainer() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors().secondTileColor, width: 5),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          color: Colors.white,
          shape: BoxShape.circle),
      height: 330,
      width: 300,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                isRecording ? AppLocalizations.of(context).translate('recording') : AppLocalizations.of(context).translate('recordingText'),
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                formatDuration(recordingDuration),
                style: GoogleFonts.montserrat(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:  Border.all(color: Colors.black12, width: 3),),
                child: CircleAvatar(
                  backgroundColor: isRecording
                      ? AppColors().secondTileColor
                      : Colors.white,
                  radius: 30,
                  child: InkWell(
                    onTap: () async {
                      if (isRecording) {
                        String? filePath = await audioRecorder.stop();
                        stopTimer();
                        if (filePath != null) {
                          await _saveRecordingPath(filePath);
                          setState(() {
                            isRecording = false;
                            recordingPath = filePath;
                          });

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RecordingManagerScreen(
                                recordingPaths: [filePath],
                              ),
                            ),
                          );
                        }
                      } else {
                        if (await audioRecorder.hasPermission()) {
                          final Directory appDocumentsDir =
                          await getApplicationDocumentsDirectory();
                          final String filePath = p.join(
                              appDocumentsDir.path,
                              "recording_${DateTime.now().millisecondsSinceEpoch}.wav");
                          await audioRecorder.start(
                            const RecordConfig(),
                            path: filePath,
                          );
                          startTimer();
                          setState(() {
                            isRecording = true;
                            recordingPath = null;
                          });
                        }
                      }
                    },
                    child: Image.asset(
                      AppAssets.audio,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
