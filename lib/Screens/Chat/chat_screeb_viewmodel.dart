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
    print("User Id: ${state.widget.userId}");
    print("Thread Id: ${state.widget.threadId}");
    print("Sender: ${state.widget.sender.name}");
  }

  getChatDetails() async {
    if(state.widget.threadId!=null){
      List temp = await databaseHelper.checkThreadDatabase(int.parse(state.widget.threadId));
      print('--- ${temp.length} ---');
      if( temp.isNotEmpty){
        print("Contain Messages");
        messageElement = MessageElement();
        messageElement.messages = List();
       messageElement.messages = await databaseHelper.getSingleUserMessages(int.parse(state.widget.threadId));
       await Future.delayed(Duration(seconds: 1));

        messageElement.messages = messageElement.messages.reversed.toList();
        state.setState(() {
          state.isLoading = false;
        });

        messageElement = await RestApi.getThreadMessages(state.widget.threadId);

        await databaseHelper.clearThreadMessageDatabase(int.parse(state.widget.threadId));

        for(int i = 0; i<messageElement.messages.length ; i++){
          await databaseHelper.insert(messageElement.messages[i]);
        }

        messageElement.messages = messageElement.messages.reversed.toList();
        state.setState(() {});

      }else{
        print("Not Contain Messages");
        messageElement = await RestApi.getThreadMessages(state.widget.threadId);

        await databaseHelper.clearThreadMessageDatabase(int.parse(state.widget.threadId));

        for(int i = 0; i<messageElement.messages.length ; i++){
          await databaseHelper.insert(messageElement.messages[i]);
        }

        messageElement.messages = messageElement.messages.reversed.toList();
        state.setState(() {
          state.isLoading = false;
        });
      }
    }else{
      state.setState(() {
        state.isLoading = false;
      });
    }
  }

  sendMessage(String message) async {
    ThreadModel temp = ThreadModel(senderId: appState.id,message: MessageMessage(raw: message),dateSent: DateTime.now());
    if(state.widget.threadId!=null){
      state.setState(() {
        messageElement.messages.insert(0,temp);
        databaseHelper.insert(temp);
      });
      await RestApi.sendThreadMessage(state.widget.userId, message,state.widget.threadId);
    }else{
      state.setState(() {
        messageElement.messages.insert(0,temp);
        databaseHelper.insert(temp);
      });
      await RestApi.createThreadMessage(state.widget.userId, message,state.widget.matchId);
    }
  }
}