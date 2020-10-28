import 'package:flutter/material.dart';
import 'package:hookup4u/models/data_model.dart';
import 'package:hookup4u/models/user_model.dart';
import 'package:hookup4u/util/color.dart';

class ChatScreen extends StatefulWidget {
  final User sender;

  ChatScreen({this.sender});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

final TextEditingController _saveMsg = new TextEditingController();

class _ChatScreenState extends State<ChatScreen> {
  _buildMessage(Message message, bool isMe, bool isUnread) {
    final Container msg = Container(
      margin: isMe
          ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0, right: 10)
          : EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
          color: isMe
              ? primaryColor.withOpacity(.1)
              : secondryColor.withOpacity(.3),
          borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Container(
                child: Text(
                  message.text,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  message.time,
                  style: TextStyle(
                    color: secondryColor,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                isMe
                    ? isUnread
                        ? Icon(
                            Icons.done,
                            color: secondryColor,
                            size: 15,
                          )
                        : Icon(
                            Icons.done_all,
                            color: primaryColor,
                            size: 15,
                          )
                    : Text("")
              ],
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
          child: CircleAvatar(
            backgroundColor: secondryColor,
            radius: 25,
            backgroundImage: AssetImage("${widget.sender.imageUrl[0]}"),
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
                  messages.insert(
                      0,
                      Message(
                          text: _saveMsg.text,
                          unread: true,
                          time: TimeOfDay(
                                  hour: DateTime.now().hour,
                                  minute: DateTime.now().minute)
                              .format(context)
                              .toString(),
                          sender: currentUser));
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                    color: Colors.white),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                  child: ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.only(top: 15.0),
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Message message = messages[index];
                      final bool isMe = message.sender.id == currentUser.id;
                      final bool isUnread = message.unread;
                      return _buildMessage(
                        message,
                        isMe,
                        isUnread,
                      );
                    },
                  ),
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
