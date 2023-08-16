import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Env {
  static String CLIENT_ID = dotenv.get('CLIENT_ID');
  static String CLIENT_SECRET = dotenv.get('CLIENT_SECRET');
  static String REDIRECT_URL = dotenv.get('REDIRECT_URL');
  static String DISCOVER_URL = dotenv.get('DISCOVER_URL');
  static String USERINFO_ENDPOINT = dotenv.get('USERINFO_ENDPOINT');
}