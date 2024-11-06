import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../consts/app_colors.dart';
import '../../consts/assets.dart';
import '../History Items/history_items.dart';
import '../Notes/notes.dart';
import 'Lanugage Selection/app_localizations.dart';

class HomeTwo extends StatefulWidget {
  const HomeTwo({super.key});

  @override
  State<HomeTwo> createState() => _HomeTwoState();
}

class _HomeTwoState extends State<HomeTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: ListView.builder(
                itemCount: 5, // Number of menu items
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
                            builder: (_) => const Notes()));
                      },
                      child: _buildMenuItem(
                        icon: AppAssets.voiceNote,
                        label:
                        AppLocalizations.of(context).translate('notesMemos'),
                        color: AppColors().appIconsColor,
                        tileColor: AppColors().fifthTileColor,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const HistoryItems()));
                      },
                      child: _buildMenuItem(
                        icon: AppAssets.history,
                        label:
                        AppLocalizations.of(context).translate('historyItems'),
                        color: AppColors().appIconsColor,
                        tileColor: AppColors().sixthTileColor,
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
