import 'package:hookup4u/Screens/Chat/messages_page.dart';
import 'package:hookup4u/models/match_model.dart';
import 'package:hookup4u/restapi/restapi.dart';

class MessagesPageViewModel{
  MessagesScreenState state;
  List<MatchModel> matchList = List();

  MessagesPageViewModel(this.state){
    getMyMatch();
  }

  getMyMatch() async {
    List<MatchModel> tempList = await RestApi.myMatchApi();

    if(tempList.isNotEmpty){
      tempList.removeWhere((element) => element.mutualMatch!='true');
    }

    matchList = tempList;
    print(matchList.length);

    state.setState(() {
      state.isLoading = false;
    });
  }

}