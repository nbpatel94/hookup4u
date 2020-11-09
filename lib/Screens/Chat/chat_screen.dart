import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/Chat/chat_screeb_viewmodel.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/models/data_model.dart';
import 'package:hookup4u/models/match_model.dart';
import 'package:hookup4u/models/thread_model.dart';
import 'package:hookup4u/models/user_model.dart';
import 'package:hookup4u/util/color.dart';
import 'package:lottie/lottie.dart';

class ChatScreen extends StatefulWidget {
  // final User sender;
  final Meta sender;
  final String userId;
  final String matchId;
  final String threadId;

  ChatScreen({this.sender, this.userId, this.threadId, this.matchId});

  @override
  ChatScreenState createState() => ChatScreenState();
}

final TextEditingController _saveMsg = new TextEditingController();

class ChatScreenState extends State<ChatScreen> {
  ChatScreenViewModel model;
  bool isLoading = true;

  _buildMessage(ThreadModel message, bool isMe) {
    final Container msg = Container(
      margin: isMe
          ? EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: MediaQuery.of(context).size.width * 0.4,
              right: 10)
          : EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
          color: ColorRes.darkButton, borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Container(
                child: Text(
                  message.message.raw,
                  style: TextStyle(
                    color: ColorRes.textColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(80),
            child: widget.sender.media.isNotEmpty
                ? Image.network(
                    widget.sender.media[0],
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'asset/userPictures/otherUsers/bunny1.jpeg',
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        msg,
      ],
    );
  }

  _buildMessageComposer() {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25.0,
            color: secondryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: _saveMsg,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              maxLines: 500,
              minLines: 1,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: 'Type a message...',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.send,
                color: primaryColor,
                size: 25,
              ),
              onPressed: () async {
                if (_saveMsg.text.isEmpty) return;
                FocusScope.of(context).unfocus();
                setState(() {
                  model.sendMessage(_saveMsg.text.trim());
                });
                _saveMsg.clear();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    model ?? (model = ChatScreenViewModel(this));

    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "${widget.sender.name}",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: primaryColor,
          actions: <Widget>[
            PopupMenuButton(itemBuilder: (context) {
              return [
                PopupMenuItem(
                  height: 20,
                  value: 1,
                  child: Text("Block user"),
                )
              ];
            }),
          ],
        ),
        body: isLoading
            ? Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Lottie.asset('asset/Icon/getting_message.json',
                height: MediaQuery.of(context).size.width / 3,
                width: MediaQuery.of(context).size.width / 3),
          ),
        )
            : GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: <Widget>[
              model.messageElement != null
                  ? Expanded(
                      child: ListView.builder(
                        reverse: true,
                        padding: EdgeInsets.only(top: 15.0),
                        itemCount: model.messageElement.messages.length,
                        itemBuilder: (BuildContext context, int index) {
                          final ThreadModel message =
                              model.messageElement.messages[index];
                          final bool isMe = message.senderId == appState.id;
                          // final bool isUnread = message.unread;
                          return _buildMessage(
                            message,
                            isMe,
                          );
                        },
                      ),
                    )
                  : Expanded(
                      child: Center(
                        child: Text(
                          "No Matches",
                          style: TextStyle(color: secondryColor, fontSize: 16),
                        ),
                      ),
                    ),
              _buildMessageComposer(),
            ],
          ),
        ));
  }
}
