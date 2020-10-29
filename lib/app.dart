import 'package:hookup4u/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App{
  static const String baseUrl = 'https://door.iheartmuslims.com/wp-json/buddypress/v1/';
  static const String loginBase = 'https://door.iheartmuslims.com/wp-json/jwt-auth/v1/token';

  static const String signUp = 'signup';
  static const String activity = 'activity';
  static const String notifications = 'notifications';
}

SharedPreferences sharedPreferences;
AppState appState = AppState();