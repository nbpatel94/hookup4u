import 'package:hookup4u/app_state.dart';
import 'package:hookup4u/database/database_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App{
/*  static const String baseUrl = 'https://door.iheartmuslims.com/wp-json/buddypress/v1/';
  static const String baseUrl2 = 'https://door.iheartmuslims.com/wp-json/bdpwr/v1/';
  static const String baseUrlV2 = 'https://door.iheartmuslims.com/wp-json/wp/v2/';
  static const String baseUrlSA = 'https://door.iheartmuslims.com/wp-json/sa/v1/';
  static const String loginBase = 'https://door.iheartmuslims.com/wp-json/jwt-auth/v1/token';
*/

  // https://iheartmuslims.wp.apis.demographed.com/wp-json/

  static const String baseUrl = 'https://iheartmuslims.wp.apis.demographed.com/wp-json/buddypress/v1/';
  static const String baseUrl2 = 'https://iheartmuslims.wp.apis.demographed.com/wp-json/bdpwr/v1/';
  static const String baseUrlV2 = 'https://iheartmuslims.wp.apis.demographed.com/wp-json/wp/v2/';
  static const String baseUrlSA = 'https://iheartmuslims.wp.apis.demographed.com/wp-json/sa/v1/';
  static const String loginBase = 'https://iheartmuslims.wp.apis.demographed.com/wp-json/jwt-auth/v1/token';

  static const String adminToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZG9vci5paGVhcnRtdXNsaW1zLmNvbSIsImlhdCI6MTYwNDgzODU5MywibmJmIjoxNjA0ODM4NTkzLCJleHAiOjQ3NTg0Mzg1OTMsImRhdGEiOnsidXNlciI6eyJpZCI6NH19fQ.SW23tR-JgteoMmKaM-wzrRxRfI5AG8IDIjxvTTlciPw';

  static const String signUp = 'signup';
  static const String messages = 'messages';
  static const String activity = 'activity';
  static const String users = 'users/';
  static const String userList = 'userlist';
  static const String media = 'media';
  static const String match = 'match';
  static const String match_reject = 'match_reject';
  static const String user = 'user';
  static const String set_password = 'set-password';
  static const String i_like_you = 'i_like_you';
  static const String reset_password = 'reset-password';
  static const String validate_code = 'validate-code';
  static const String notifications = 'notifications';
  static const String getNotification = 'get_notification';
  static const String activeUser = 'activate_user';
  static const String reSendEmail = 'resend_mail';

  //social media app
  static const String wallPost = 'wallpost';
  static const String myWallPost = 'my_wallpost';
  static const String wallComment = 'wallpost/comment';
  static const String wallLike = 'wallpost/like';
  static const String searchUser = 'searchuser';
  static const String userProfile = 'user_profile';
  static const String follow = 'follow';
  static const String friends = 'friends';
  static const String friend_requests = 'get_friend_requests';
  static const String profile_media = 'profile_media';
  static const String followList = 'follow_list';
  static const String recent = 'recent';
  static const String changesPassword = 'change_password';
  static const String getThreads = 'get_threads';

}

SharedPreferences sharedPreferences;
AppState appState = AppState();
DatabaseHelper databaseHelper = DatabaseHelper();