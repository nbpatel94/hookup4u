import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookup4u/Screens/Profile/EditProfile.dart';
import 'package:hookup4u/models/mediamodel.dart';
import 'package:hookup4u/restapi/restapi.dart';
import 'package:hookup4u/app.dart';

class EditProfileViewModel{
  EditProfileState state;
  // List<MediaModel> medialList;
  EditProfileViewModel(this.state){
    // getUserMedia();
  }

  // getUserMedia() async {
  //   EasyLoading.show();
  //   medialList = await RestApi.getSingleUserMedia();
  //   state.setState(() {
  //     state.isLoading = false;
  //     EasyLoading.dismiss();
  //   });
  // }

  uploadUseMedia() async {
    EasyLoading.show();

    MediaModel model = await RestApi.uploadUserMedia(state.image);
    if(model!=null){
      state.setState(() {
        appState.medialList.add(model);
      });
    }else{
      state.snackbar('Server issue! Try later');
    }
    EasyLoading.dismiss();
  }
}