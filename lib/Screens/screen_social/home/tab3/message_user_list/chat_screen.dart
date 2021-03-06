import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/Chat/chat_viewmodel.dart';
import 'package:hookup4u/app.dart';
import 'package:hookup4u/models/match_model.dart';
import 'package:hookup4u/models/thread_model.dart';
import 'package:hookup4u/restapi/restapi.dart';
import 'package:hookup4u/util/color.dart';
import 'package:lottie/lottie.dart';

import 'chat_viewmodel.dart';

class SocialChatScreen extends StatefulWidget {
  // final User sender;
  final Meta sender;
  final String userId;
  final String matchId;
  String threadId;

  SocialChatScreen({this.sender, this.userId, this.threadId, this.matchId});

  @override
  SocialChatScreenState createState() => SocialChatScreenState();
}

final TextEditingController _saveMsg = new TextEditingController();

class SocialChatScreenState extends State<SocialChatScreen> {

  SocialChatScreenViewModel model;
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
                    fontSize: 16.0,height: 1.1,
                    fontFamily: 'NeueFrutigerWorld',
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
                ? CachedNetworkImage(
                    imageUrl: widget.sender.media[0],
                    placeholder: (context, url) => Image.asset(
                          'asset/Icon/placeholder.png',
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover)
                : Image.asset(
                    'asset/Icon/placeholder.png',
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
      height: 60.0,
      color: ColorRes.darkButton,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextField(
                controller: _saveMsg,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (value) {},
                maxLines: 500,
                minLines: 1,
                style: TextStyle(color: ColorRes.textColor,fontFamily: 'NeueFrutigerWorld',),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: ColorRes.textColor,fontFamily: 'NeueFrutigerWorld',),
                  hintText: 'Type a message...',
                ),
              ),
            ),
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'asset/Icon/photo.png',
                height: 25,
                color: ColorRes.textColor,
              ),
            ),
            onTap: () {},
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon (
                Icons.send,
                color: ColorRes.textColor,
                size: 25,
              ),
            ),
            onTap: () async {
              if (_saveMsg.text.isEmpty) return;
              FocusScope.of(context).unfocus();
              setState(() {
                model.sendMessage(_saveMsg.text.trim());
              });
              _saveMsg.clear();
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = SocialChatScreenViewModel(this);
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, 'No');
        return false;
      },
      child: Scaffold(
          backgroundColor: ColorRes.primaryColor,
          appBar: AppBar(
            elevation: 0,
            title: Text(
              "${widget.sender.name}",
              style: TextStyle(color: Colors.white,fontFamily: 'NeueFrutigerWorld',fontWeight: FontWeight.w700),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () => Navigator.pop(context, 'No'),
            ),
            backgroundColor: ColorRes.primaryColor,
            actions: <Widget>[
              PopupMenuButton(
                  color: ColorRes.darkButton,
                  onSelected: (index) async {
                    var res = await source();
                    if (res != null) {
                      setState(() {
                        isLoading = true;
                      });
                      String check = await RestApi.matchReject(widget.matchId);
                      if (check == 'success') {
                        Navigator.pop(context, 'Yes');
                      }
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        height: 20,
                        value: 1,
                        child: Text(
                          "Block user",
                          style: TextStyle(color: ColorRes.white,fontFamily: 'NeueFrutigerWorld',),
                        ),
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
                                  final bool isMe =
                                      message.senderId == appState.id;
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
                                  "Send message to ${widget.sender.name}",
                                  style: TextStyle(
                                      color: ColorRes.textColor, fontSize: 16),
                                ),
                              ),
                            ),
                      _buildMessageComposer(),
                    ],
                  ),
                )),
    );
  }

  source() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(
              "Once you will block ${widget.sender.name} then you will unable to see ${widget.sender.gender == 'man' ? 'him' : 'her'} in your matches \nAre you sure want to block?",
            ),
            insetAnimationCurve: Curves.decelerate,
            actions: <Widget>[
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context, "Delete");
                },
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  color: ColorRes.redButton,
                  child: Text(
                    "YES",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: ColorRes.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  color: ColorRes.darkButton,
                  child: Text(
                    "NO",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: ColorRes.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
