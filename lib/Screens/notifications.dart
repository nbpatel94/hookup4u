import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/Information.dart';
import 'package:hookup4u/models/data_model.dart';
import 'package:hookup4u/util/color.dart';

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Notifications',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          elevation: 0,
        ),
        backgroundColor: primaryColor,
        body: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              color: Colors.white),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'this week',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      child: notifications.length > 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: notifications.length,
                              itemBuilder: (BuildContext context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: notifications[index].unread
                                            ? primaryColor.withOpacity(.15)
                                            : Colors.white),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.all(5),
                                      leading: CircleAvatar(
                                          radius: 25,
                                          backgroundColor: secondryColor,
                                          backgroundImage: AssetImage(
                                            notifications[index]
                                                .sender
                                                .imageUrl[0],
                                          )),
                                      title: Text(
                                          "${notifications[index].sender.name} is liked your profile"),
                                      subtitle: Text(
                                          "if you want to match your profile with ${notifications[index].sender.name} just like ${notifications[index].sender.name}'s profile"),
                                      trailing: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Text(
                                                "${notifications[index].time}"),
                                            notifications[index].unread
                                                ? Container(
                                                    width: 40.0,
                                                    height: 20.0,
                                                    decoration: BoxDecoration(
                                                      color: primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      'NEW',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  )
                                                : Text(""),
                                          ],
                                        ),
                                      ),
                                      onTap: () => showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return Info(
                                                notifications[index].sender);
                                          }),
                                    ),
                                  ),
                                );
                              })
                          : Center(
                              child: Text(
                              "No Notification",
                              style:
                                  TextStyle(color: secondryColor, fontSize: 16),
                            ))),
                ),
              ],
            ),
          ),
        ));
  }
}
