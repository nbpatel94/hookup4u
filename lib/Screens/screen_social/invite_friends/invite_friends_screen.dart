import 'package:flutter/material.dart';
import 'package:hookup4u/util/color.dart';

class InviteFriendsPage extends StatefulWidget {
  @override
  _InviteFriendsPageState createState() => _InviteFriendsPageState();
}

class _InviteFriendsPageState extends State<InviteFriendsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        leading: Container(),
        // leading: Icon(Icons.close, color: ColorRes.white, size: 20),
        // actions: [
        //   Center(child: Padding(
        //       padding: EdgeInsets.only(right: 10),
        //       child: Text("next", style: TextStyle(color: ColorRes.primaryRed))))
        // ],
      ),
      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Padding(
      //         padding: EdgeInsets.only(left: 10),
      //         child: Text("Invite Friends", style: TextStyle(color: ColorRes.white, fontSize: 30))),
      //     Expanded(child: ListView.separated(itemCount: 10, separatorBuilder: (context, index) {
      //       return Padding(
      //           padding: EdgeInsets.only(left: 20),
      //           child: Divider(height: 1, color: ColorRes.black));
      //     }, itemBuilder: (context, index) {
      //       return Container(
      //         height: 100,
      //         width: MediaQuery.of(context).size.width,
      //         child: Row(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: [
      //             Container(
      //               margin: EdgeInsets.only(left: 10),
      //               decoration: BoxDecoration(
      //                 shape: BoxShape.circle
      //               ),
      //               child: ClipRRect(
      //                 borderRadius: BorderRadius.circular(50),
      //                 child: Image(
      //                     height: 50,
      //                     width: 50,
      //                     image: AssetImage("asset/Icon/placeholder.png")),
      //               ),
      //             ),
      //             SizedBox(width: 10),
      //             Expanded(
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text("Caleb Klein", style: TextStyle(color: ColorRes.white)),
      //                   SizedBox(height: 5),
      //                   Text("You're friends on facebook", style: TextStyle(color: ColorRes.greyBg))
      //                 ],
      //               ),
      //             ),
      //             index.isOdd ? Container(
      //                 height: 25,
      //                 width: 25,
      //                 margin: EdgeInsets.only(right: 10),
      //                 decoration: BoxDecoration(
      //                     color: ColorRes.primaryRed,
      //                     borderRadius: BorderRadius.circular(10),
      //                     border: Border.all(width: 2, color: ColorRes.primaryRed)
      //                 ),
      //                 child: Icon(Icons.check, color: ColorRes.primaryColor, size: 20)
      //             ) :
      //             Container(
      //                 height: 25,
      //                 width: 25,
      //                 margin: EdgeInsets.only(right: 10),
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(8),
      //                   border: Border.all(width: 2, color: ColorRes.primaryRed)
      //                 ),
      //                 child: Icon(Icons.add, color: ColorRes.primaryRed, size: 20)
      //             )
      //           ],
      //         ),
      //       );
      //     }))
      //   ],
      // ),
      body: Center (
        child: Text("Coming soon...", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
