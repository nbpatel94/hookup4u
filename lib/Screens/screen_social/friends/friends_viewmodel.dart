import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:hookup4u/Screens/screen_social/friends/friends_screen.dart';
import 'package:hookup4u/restapi/restapi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:flutter_facebook_login/flutter_facebook_login.dart';


class FriendsViewModel {

  FriendsScreenState state;
  FacebookLogin fbAuthManager = FacebookLogin();
  FriendsViewModel(FriendsScreenState state) {
    this.state = state;
  }

  loginWithFB() async {

    //EAADsZBqnZAWEwBAMpE9IxWPsAuRkHP6WmvRjHkC4OYY3FB0R6vsx4qO2euhrxdUwt8t5IOQ6Kcyy5i0R6ZBx3t4DdxN6w1fnNxUgWPibPiDd0HmuFcEKaBUoHaGT3k0Ua8eqrodU11EMo1qlRCffVOp0LX6AzZA9qnsL0oWxSXaAcbsvJpW9LjsovpFido7TZCrodifvAewZDZD

    final result = await fbAuthManager.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn :
        final token = result.accessToken.token;
        print("token $token");
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        // setState(() {
        //   userProfile = profile;
        //   _isLoggedIn = true;
        // });
        break;

      case FacebookLoginStatus.cancelledByUser:
        print("cancelledByUser");
        // setState(() => _isLoggedIn = false );
        break;
      case FacebookLoginStatus.error:
        print("error");
        // setState(() => _isLoggedIn = false );
        break;
    }

  }


}