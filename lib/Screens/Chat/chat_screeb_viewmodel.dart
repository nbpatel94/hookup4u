import 'package:hookup4u/Screens/Chat/chat_screen.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/models/thread_model.dart';
import 'package:hookup4u/restapi/restapi.dart';

class ChatScreenViewModel{
  ChatScreenState state;
  MessageElement messageElement;

  ChatScreenViewModel(this.state){
    printUserData();
    getChatDetails();
  }

  printUserData(){
    print(state.widget.userId);
    print(state.widget.threadId);
    print(state.widget.sender.name);
  }

  getChatDetails() async {
    if(state.widget.threadId!=null){
      messageElement = await RestApi.getThreadMessages(state.widget.threadId);
      messageElement.messages = messageElement.messages.reversed.toList();
      state.setState(() {
        state.isLoading = false;
      });
    }
  }

  sendMessage(String message) async {
    if(state.widget.threadId!=null){
      state.setState(() {
        messageElement.messages.insert(0,ThreadModel(senderId: appState.id,message: MessageMessage(raw: message),dateSent: DateTime.now()));
      });
      await RestApi.sendThreadMessage(state.widget.userId, message,state.widget.threadId);
    }else{
      state.setState(() {
        messageElement.messages.insert(0,ThreadModel(senderId: appState.id,message: MessageMessage(raw: message),dateSent: DateTime.now()));
      });
      await RestApi.createThreadMessage(state.widget.userId, message,state.widget.matchId);
    }
  }
}