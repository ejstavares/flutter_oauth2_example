import 'package:flutter/material.dart';
import 'package:oauth2example/services/get_storage_helper.dart';
import 'package:oauth2example/ui/pages/about_page.dart';
import 'package:oauth2example/ui/pages/login_page.dart';
import 'package:oauth2example/model/user_profile_model.dart';
import 'package:oauth2example/ui/pages/profile_page.dart';
import 'package:oauth2example/ui/pages/settings_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userData = UserProfileModel();

  ///////
  int _selectedIndex = 0;
  final _navBarColor = [
    Colors.orange[100],
    Colors.purple[100],
    Colors.blue[100],
  ];
  final _navBarTextColor = [
    Colors.orange[900],
    Colors.purple[900],
    Colors.blue[900],
  ];

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  ///////
  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      firstPage(),
      const SettingsPage(),
      const AboutPage(),
    ];
    return Scaffold(
      /*appBar: AppBar(
        elevation: 20,
        backgroundColor: _navBarColor[_selectedIndex],
        foregroundColor: _navBarTextColor[_selectedIndex],
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold),),
      ),*/
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.orange[200]!,
              hoverColor: Colors.orange[100]!,
              gap: 8,
              activeColor: Colors.orange[900],
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.orange[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: Icons.person,
                  text: userData.name == null ? 'Login' : 'My Account',
                  iconColor: Colors.orange[900],
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Settings',
                  iconColor: Colors.purple[900],
                  backgroundColor: Colors.purple[100]!,
                  iconActiveColor: Colors.purple[900],
                  textColor: Colors.purple[900],
                ),
                GButton(
                  icon: Icons.info,
                  text: 'About',
                  iconColor: Colors.blue[900],
                  backgroundColor: Colors.blue[100]!,
                  iconActiveColor: Colors.blue[900],
                  textColor: Colors.blue[900],
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> logoutAction() async {
    //await auth0.webAuthentication(scheme: appScheme).logout();

    GetStorageHelper.removeCurrentUser();

    setState(() {
      userData = UserProfileModel();
    });
  }

  Widget firstPage() {
    if (userData.name == null) {
      userData = GetStorageHelper.getCurrentUser() ?? UserProfileModel();
    }
    if (userData.name == null) {
      return LoginPage(
        title: 'title',
        callbackAction: (user) {
          setState(() {
            userData = user;
          });
        },
      );
    } else {
      return ProfilePage(
        logoutAction: logoutAction,
        user: userData,
      );
    }
  }
}
