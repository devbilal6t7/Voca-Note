import 'package:flutter/material.dart';
import 'package:flutter_speech_to_text_tutorial/screens/Navigation/main_navigation_screen.dart';
import 'package:google_fonts/google_fonts.dart';


class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
        );
        return false;
      },
      child: Scaffold(
        appBar:  AppBar(
          foregroundColor: Colors.white,
          title: Text(
            'Privacy Policy',
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
          backgroundColor: Colors.green,
          leading: IconButton(
            onPressed: (){
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_)=> const MainNavigationScreen())
              );
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined,size: 20,),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                'VOCA NOTE :',
                style: GoogleFonts.rubik(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'At VOCA NOTE, your privacy is our priority. This Privacy Policy outlines how we collect, use, and safeguard your personal information when you use our app to convert voice to text, take notes, record audio, and search through voice commands across different search engines. By using VOCA NOTE, you agree to the terms of this policy.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),

              _buildSectionTitle('1. Information We Collect'),
              _buildSubsectionTitle('1.1  Voice Data'),
              _buildParagraph(
                'When you use the app’s voice-to-text feature, record audio, or perform voice searches, we may collect and process your voice recordings. '
                    'Voice data is used only for converting speech to text or performing search functions and is not stored unless specifically required for the service (e.g., voice notes or recorded audio saved by the user).',
              ),
              _buildSubsectionTitle('1.2  Notes and Recordings'),
              _buildParagraph(
                'Any notes or audio recordings you create within the app are stored locally on your device or in the cloud (if you opt to save them to a cloud service). '
                    'We do not have access to your notes or recordings unless you explicitly share them with us for troubleshooting or feedback purposes.',
              ),
              _buildSubsectionTitle('1.3  Search Data'),
              _buildParagraph(
                'If you use voice search to access third-party search engines, we may collect data about your search queries to process the request. However, we do not store this data or track your search history. '
                    'When performing voice searches, the data may be transmitted to the search engine you select, which will have its own privacy policy governing the use of your data.',
              ),
              _buildSubsectionTitle('1.4  Device Information'),
              _buildParagraph(
                'We may collect information about the device you are using, such as its operating system, IP address, device ID, and other technical details, to improve app functionality and ensure security.',
              ),

              const SizedBox(height: 24),
              _buildSectionTitle('2. How We Use Your Information'),
              _buildParagraph(
                'We use the information we collect in the following ways:\n\n'
                    '- Voice-to-Text Conversion: To convert your voice input into text for note-taking or other purposes.\n'
                    '- Audio Recording: To allow you to create and manage voice recordings within the app.\n'
                    '- Voice Search: To enable voice-based searches through third-party search engines.\n'
                    '- App Improvements: To understand how the app is used and make improvements to user experience and functionality.\n\n'
                    'We do not sell, share, or distribute your personal data with third parties for commercial purposes.',
              ),

              const SizedBox(height: 24),
              _buildSectionTitle('3. Third-Party Services'),
              _buildParagraph(
                'Our app integrates with third-party services such as search engines. Please note that when you perform a voice search, your query will be sent to the selected search engine (e.g., Google, Bing), and those services will handle your data according to their respective privacy policies. We encourage you to review the privacy policies of these services before using the voice search feature.',
              ),

              const SizedBox(height: 24),
              _buildSectionTitle('4. Data Security'),
              _buildParagraph(
                'We take your privacy and data security seriously. We use industry-standard security measures, such as encryption and secure data transmission protocols, to protect your data from unauthorized access, alteration, disclosure, or destruction.\n\n'
                    'However, no method of transmission over the internet or electronic storage is 100% secure. While we strive to protect your personal data, we cannot guarantee its absolute security.',
              ),

              const SizedBox(height: 24),
              _buildSectionTitle('5. Data Retention'),
              _buildParagraph(
                'We only retain your voice recordings, notes, and other data for as long as it is necessary to provide the service or as required by law. You have the option to delete your notes or recordings at any time, and we encourage you to do so if they are no longer needed.',
              ),

              const SizedBox(height: 24),
              _buildSectionTitle('6. Your Choices and Rights'),
              _buildSubsectionTitle('6.1  Access and Control'),
              _buildParagraph(
                'You have control over your notes, recordings, and other personal data within the app. You can view, edit, or delete this data at any time.',
              ),
              _buildSubsectionTitle('6.2  Opt-Out of Voice Data Collection'),
              _buildParagraph(
                'If you prefer not to share your voice data, you can opt-out by disabling voice recognition features within the app settings.',
              ),
              _buildSubsectionTitle('6.3  Data Deletion Requests'),
              _buildParagraph(
                'If you wish to delete all your data, including voice recordings and notes, you can request this through the app or by contacting our support team at [Support Email].',
              ),

              const SizedBox(height: 24),
              _buildSectionTitle('7. Children\'s Privacy'),
              _buildParagraph(
                'Our app is not intended for use by children under the age of 13, and we do not knowingly collect personal information from children. If we become aware that a child under 13 has provided us with personal data, we will take steps to delete such information.',
              ),

              const SizedBox(height: 24),
              _buildSectionTitle('8. Changes to This Privacy Policy'),
              _buildParagraph(
                'We may update this Privacy Policy from time to time to reflect changes in our practices or for other operational, legal, or regulatory reasons. When we update the policy, we will notify you by revising the "Effective Date" at the top of the document. Please review this policy periodically to stay informed about how we protect your data.',
              ),

              const SizedBox(height: 24),
              _buildSectionTitle('9. Contact Us'),
              _buildParagraph(
                'If you have any questions or concerns regarding this Privacy Policy or your data privacy, please contact us at:\n\n'
                    'Email: [Support Email]\n\n'
                    'Thank you for using VOCA NOTE ! Your trust is important to us.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.rubik(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildSubsectionTitle(String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        subtitle,
          style: GoogleFonts.rubik(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
      ),
    );
  }

  Widget _buildParagraph(String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        content,
        style: const TextStyle(fontSize: 16, height: 1.5),
      ),
    );
  }
}
