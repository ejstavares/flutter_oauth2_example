import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 50.0,
              width: double.infinity,
              // margin: const EdgeInsets.only(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: const FlutterLogo(style: FlutterLogoStyle.horizontal),
            ),
            const Text('OAuth 2.0 LOGIN'),
            const SizedBox(height: 20),
            const Text(
              'Demo with:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Image.asset("assets/images/logo.png", height: 40),
            const SizedBox(
              height: 30,
              child: Text('OR'),
            ),
            Image.asset(
              "assets/images/autentika.png",
              height: 30,
            ),
            SizedBox(height: 40,),
            const Text(
                'This APP demo aims to help in testing the configuration in the integration with Auth0 platform, such as KEYCLOAK or AUTENTIKA.GOV.CV.'),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'If this APP was useful for you, leave a Star ★ in the GitHub repository:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _launchUrl,
              label: Text(
                'GitHub Repository',
                style: TextStyle(color: Colors.blue.shade900),
              ),
              icon: Image.asset("assets/images/github.png", height: 30),
              style: ButtonStyle(
                  elevation: const MaterialStatePropertyAll(0),
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.blue.shade50)),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Version 1.0.0+1 - © 2023')
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(
        Uri.parse('https://github.com/ejstavares/flutter_oauth2_example'),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Error GitHub Repository');
    }
  }
}
