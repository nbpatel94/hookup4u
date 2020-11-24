import 'package:hookup4u/Screens/cardpage/card_pictures.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/models/activitymodel.dart';
import 'package:hookup4u/restapi/restapi.dart';
import 'package:queue/queue.dart';

class CardPictureViewModel{
  CardPicturesState state;
  // int usersIndex = 0;

  CardPictureViewModel(this.state){
    getUsers();
  }

  List<ActivityModel> list;
  // List<ActivityModel> list2;

  getUsers() async {
    state.setState(() {
      state.isLoading = true;
    });
    list = await RestApi.getActivity();

    list.removeWhere((element) => element.about=='' || element.dateOfBirth=='');

    if(list.isEmpty){
      state.setState(() {
        state.onEnd = true;
      });
    }else{
      if(appState.gender=='man'){
        list.removeWhere((element) => element.gender=='man');
      }else if(appState.gender=='woman'){
        list.removeWhere((element) => element.gender=='woman');
      }
      if(list.isEmpty){
        state.setState(() {
          state.onEnd = true;
        });
      }else{
        list2 = list;
        queue = Queue(parallel: list2.length);
        print("List length :${list.length}");
      }
    }
    state.setState(() {
      state.isLoading = false;
    });
  }
  Queue queue;

  giveLike(String targetId) async {
    await RestApi.likeButtonPress(targetId, 1);
  }

  giveDislike(String targetId) async {
    await RestApi.likeButtonPress(targetId, 2);
  }
}