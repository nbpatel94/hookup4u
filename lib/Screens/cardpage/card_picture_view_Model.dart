import 'package:hookup4u/Screens/cardpage/card_pictures.dart';
import 'package:hookup4u/models/activitymodel.dart';
import 'package:hookup4u/restapi/restapi.dart';

class CardPictureViewModel{
  CardPicturesState state;

  CardPictureViewModel(this.state){
    getUsers();
  }

  List<ActivityModel> list;

  getUsers() async {
    list = await RestApi.getActivity();

    print(list.length);

    state.setState(() {
      state.isLoading = false;
    });
  }
}