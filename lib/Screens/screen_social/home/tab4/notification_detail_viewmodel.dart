import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookup4u/models/notification_data_model.dart';
import 'package:hookup4u/restapi/social_restapi.dart';
import 'package:hookup4u/util/utils.dart';
import 'notification_detail_screen.dart';

class NotificationListDataViewModel {

  NotificationDetailsScreenState state;

  List<NotificationDataModel> notificationData = [];

  NotificationListDataViewModel(NotificationDetailsScreenState state) {
    this.state = state;

    notificationListDataApi();

  }

  bool notificationDataEmpty = true;

  notificationListDataApi() {

      EasyLoading.show();
      // String imageJoint = imagesList.join(",");

      SocialRestApi.getNotificationData().then((response) {
        print(response);
        // Map<String, dynamic> mapData = jsonDecode(value.body);
        // if(mapData['code'] == 200 && mapData['status'] == "success") {
        notificationDataEmpty = false;
         if(response != null && response.statusCode == 200) {
           print(response);
           List mapData = jsonDecode(response.body)['data'];
           mapData.forEach((element) {
             NotificationDataModel notificationDataModel = NotificationDataModel.fromJson(element);
             notificationData.add(notificationDataModel);
             print(notificationDataModel);
           });
           state.setState(() {});
        // } else if(response['status'] == "error") {
        //   Utils().showToast(response['message']);
        } else {
          Utils().showToast("something wrong");
        }
      });

  }


}
