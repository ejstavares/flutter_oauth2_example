import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:oauth2example/helpers/engine.dart';
import 'package:oauth2example/helpers/env.dart';
import 'package:oauth2example/helpers/utils.dart';
import 'package:oauth2example/model/user_profile_model.dart';
import 'package:oauth2example/services/get_storage_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    required this.title,
    required this.callbackAction,
  });

  final String title;
  final void Function(UserProfileModel user) callbackAction;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 50.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: const FlutterLogo(style: FlutterLogoStyle.horizontal),
          ),
          const Text('OAuth 2.0 LOGIN'),
          SizedBox(
            height: 60,
            child: Container(
              padding: const EdgeInsets.all(11),
              height: 20,
              child: _isLoading
                  ? const CircularProgressIndicator.adaptive()
                  : Container(),
            ),
          ),
          Container(
            constraints: const BoxConstraints(maxHeight: 45),
            height: 50,
            width: 250,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: ElevatedButton(
              onPressed: () async {
                if (!_isLoading) {
                  await loginAsync();
                } else {
                  Engine.showSnackbar(context,
                      message:
                          'Login in progress... Please, wait for feedback!');
                }
              },
              child: Text('LOGIN'),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }

  final FlutterAppAuth _appAuth = const FlutterAppAuth();

  Future<void> loginAsync({bool pPreferEphemeralSession = false}) async {
    var _getConfig = GetStorageHelper.getConfiguration();

    if (_getConfig == null ||
        _getConfig.clientId!.isEmpty ||
        _getConfig.clientSecret!.isEmpty) {
      Engine.showSnackbar(context,
          message:
              'Please, go to Settings Page ⛭ and configure all OAuth 2.0 parameters.');
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      var _authTokenRequestData = AuthorizationTokenRequest(
        _getConfig.clientId ?? '',
        Env.REDIRECT_URL,
        clientSecret: _getConfig.clientSecret,
        discoveryUrl: _getConfig.discoverURL,
        //scopes: ['openid', 'profile', 'email', 'offline_access', 'api'],
        scopes: <String>[
          'openid',
          'profile',
          'email',
        ],
        preferEphemeralSession: pPreferEphemeralSession,
      );

      Utils.logger.i(
          "_authTokenRequestData.redirectUrl::::: ${_authTokenRequestData.redirectUrl}");
      // show that we can also explicitly specify the endpoints rather than getting from the details from the discovery document
      final AuthorizationTokenResponse? result =
          await _appAuth.authorizeAndExchangeCode(_authTokenRequestData);

      Utils.logger.i("token access::::: ${result?.accessToken}");

      var infoResponse = await getUserInfo(
          accessToken: result?.accessToken ?? '',
          idToken: result?.idToken ?? '');
      setState(() {
        _isLoading = false;
      });

      if (!infoResponse) {
        // ignore: use_build_context_synchronously
        Engine.showSnackbar(context,
            message:
                "We were unable to complete your authentication. Try later!");
      }
    } catch (_) {
      setState(() {
        _isLoading = false;
      });
      Utils.logger.i("AUTENTIKA ERROR::::: $_");
      Engine.showSnackbar(context, message: "Login error. Try later!");
    }
  }

  Future<bool> getUserInfo(
      {required String accessToken, required String idToken}) async {
    var url =
        // Uri.https('jsonplaceholder.typicode.com', '/users/6', {'q': '{http}'});
        Uri.parse(Env.USERINFO_ENDPOINT);

    var response =
        await http.get(url, headers: {"Authorization": "Bearer $accessToken"});
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;

      //var itemCount = jsonResponse['totalItems'];
      var userInfo = UserProfileModel.fromJson(jsonResponse);
      if (userInfo.name == null && userInfo.sub != null) {
        userInfo.name = userInfo.sub?.substring(0, userInfo.sub?.indexOf('@'));
      }

      userInfo.idToken = idToken; // add idToken to use on logout
      userInfo.token = accessToken;

      widget.callbackAction(userInfo);
      GetStorageHelper.addCurrentUser(user: userInfo);

      return true;
    } else {
      return false;
    }
  }
}
