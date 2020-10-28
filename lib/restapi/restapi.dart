import 'package:hookup4u/restapi/app.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class RestApi{
  static Future<bool> signUpApi(String loginId, String name,String email, String password) async{
    String url = App.baseUrl + App.signUp;

    var bodyData = {
      'user_login': 'testuser',
      'user_email': 'test@user.mail',
      'user_name': 'test@user.mail',
      'password': 'test123'
    };

    print(url);
    print(bodyData);

    try{
      Response response = await http.post(url,body: bodyData);
      print(response.statusCode);
      if(response.statusCode==200){
        print(response.body);
        return true;
      }else{
        return true;
      }
    }catch(e){
      print(e);
      return false;
    }
  }

  static Future getActivity() async {
    String url = App.baseUrl + App.activity;

    print(url);

    try{
      Response response = await http.get(url);
      print(response.statusCode);
      if(response.statusCode==200){
        print(response.body);
        if(response.body.toString()=='[]'){
          return null;
        }else{
          return response.body;
        }
      }else{
        return null;
      }
    }catch(e){
      print(e);
      return null;
    }
  }

  static Future getNotifications() async {
    String url = App.baseUrl + App.notifications;

    print(url);

    try{
      Response response = await http.get(url);
      print(response.statusCode);
      if(response.statusCode==200){
        print(response.body);
        if(response.body.toString()=='[]'){
          return null;
        }else{
          return response.body;
        }
      }else{
        return null;
      }
    }catch(e){
      print(e);
      return null;
    }
  }
}