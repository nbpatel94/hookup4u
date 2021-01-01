import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/screen_social/home/post_data/post_data_screen.dart';

import 'home_viewmodel.dart';

class SocialHomePage extends StatefulWidget {
  @override
  SocialHomePageState createState() => SocialHomePageState();
}

class SocialHomePageState extends State<SocialHomePage> {

  bool isRef = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  
  SocialHomeViewModel model;
  
  @override
  Widget build(BuildContext context) {
    model ?? (model = SocialHomeViewModel(this));
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
              headerView(),
              showUserData()
          ],
        ),
      ),
    );
  }

  headerView() {
    return InkResponse(
      onTap: () async {
        print("hello");
        isRef = await Navigator.push(context, MaterialPageRoute(builder: (context) => PostDataScreen()));
        if(isRef) {
          model.showPostApi();
        }},
      child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(50)
          ),
      child: Text("What's on your mind?"),
        /*      child: TextField(
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: ""
            ),
          )*/
      ),
    );
  }

  showUserData() {
    return ListView.builder(
        itemCount: model.socialPostShowList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
      return showView(index);
    });
  }

  showView(int index) {
    return Container(
      // height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text(model.socialPostShowList[index].userName),
                InkResponse(
                    onTap: () {
                      model.showPostApi();
                    },
                    child: Icon(Icons.refresh, color: Colors.black, size: 30)),
                InkResponse(
                    onTap: () {
                      model.deletePostApi(model.socialPostShowList[index].id);
                    },
                    child: Icon(Icons.delete, color: Colors.black, size: 30))
              ],
            ),
          ), //appState.currentUserData

          Container(
            height: MediaQuery.of(context).size.height  - 400,
            width: MediaQuery.of(context).size.width,
            // color: Colors.black,
            child: PageView.builder(
                itemCount: model.socialPostShowList[index].media.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index1) {
              return Image(
                  height: MediaQuery.of(context).size.height - 150,
                  width: MediaQuery.of(context).size.width,
                  image: NetworkImage(model.socialPostShowList[index].media[index1].isEmpty ?
                  "https://door.iheartmuslims.com/wp-content/uploads/2021/01/user_image-14.png" :
                  model.socialPostShowList[index].media[index1]));
            }),
          ),

          /*Expanded(child: Image(
              height: MediaQuery.of(context).size.height - 150,
              width: MediaQuery.of(context).size.width,
              image: NetworkImage(model.socialPostShowList[index].media[0]))),*/
          Container(height: 50, color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Like"),
                Text("Comment"),
                Text("Share"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
