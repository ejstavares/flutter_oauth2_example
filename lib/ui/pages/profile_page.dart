import 'package:flutter/material.dart';
import 'package:oauth2example/model/user_profile_model.dart';

class ProfilePage extends StatelessWidget {
  final Future<void> Function() logoutAction;
  final UserProfileModel? user;
  const ProfilePage(
      {super.key, required this.user, required this.logoutAction});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 200),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2),
            shape: BoxShape.circle,
            /*image: DecorationImage(
              fit: BoxFit.fill,
              //image: NetworkImage(user?.pictureUrl.toString() ?? ''),
            ),*/
          ),
          child: CircleAvatar(
              child: Text(user?.name!.substring(0, 2).toUpperCase() ?? '',
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold))),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_outline, color: Colors.grey.shade400,),
            SizedBox(width: 8,),
            Text(user?.name ?? '')
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mail_outline, color: Colors.grey.shade400,),
            SizedBox(width: 8,),
            Text(user?.email ?? '')
          ],
        ),
        const SizedBox(height: 48),
        ElevatedButton.icon(
          onPressed: () async {
            await logoutAction();
          },
          icon: const Icon(Icons.exit_to_app),
          label: const Text('Logout'),
        ),
      ],
    );
  }
}
