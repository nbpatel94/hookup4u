import 'package:hookup4u/models/match_model.dart';
import 'package:hookup4u/restapi/restapi.dart';

import 'my_matches.dart';
import 'package:hookup4u/app.dart';

class MyMatchViewModel {
  MyMatchesPageState state;

  List<MatchModel> matchList = List();

  MyMatchViewModel(this.state){
    getMyMatch();
  }

  getMyMatch() async {
    List<MatchModel> tempList = await RestApi.myMatchApi();

    matchList = tempList;

    print("Match length -> ${matchList.length}");

    state.setState(() {
      state.isLoading = false;
    });
  }

  sendMatch(int index, String matchId) async {
    state.setState(() {
      matchList[index].mutualMatch = "true";
    });
    String check = await RestApi.sendMatch(matchId);
  }
  deleteMatch(int index, String matchId) async {
    state.setState(() {
      matchList.removeAt(index);
    });
    await RestApi.matchReject(matchId);
  }
}
