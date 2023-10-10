import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Env {
  static String CLIENT_ID = dotenv.get('CLIENT_ID');
  static String CLIENT_SECRET = dotenv.get('CLIENT_SECRET');
  static String REDIRECT_URL = dotenv.get('REDIRECT_URL');
  static String DISCOVER_URL = dotenv.get('DISCOVER_URL');
  static String USERINFO_ENDPOINT = dotenv.get('USERINFO_ENDPOINT');

  static String AUTHORIZATION_ENDPOINT = dotenv.get('AUTHORIZATION_ENDPOINT');
  static String TOKEN_ENDPOINT = dotenv.get('TOKEN_ENDPOINT');
  static String END_SESSION_ENDPOINT = dotenv.get('END_SESSION_ENDPOINT');
}