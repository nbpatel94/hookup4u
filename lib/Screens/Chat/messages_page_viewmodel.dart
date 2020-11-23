import 'package:hookup4u/Screens/Chat/messages_page.dart';
import 'package:hookup4u/app.dart';
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

    for(int i=0;i<tempList.length;i++){
      if(tempList[i].threadId!=null){
        tempList[i].lastMessage = await lastMessage(int.parse(tempList[i].threadId));
      }
    }

    matchList = tempList;
    print(matchList.length);

    state.setState(() {
      state.isLoading = false;
    });
  }

  lastMessage(int th) async  {
    var las = await databaseHelper.getLastMessage(th);
    return las.isEmpty ? "": las[0].message.raw;
  }

}