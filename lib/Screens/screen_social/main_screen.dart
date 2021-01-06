import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/screen_social/home/tab1/home_screen.dart';
import 'package:hookup4u/Screens/screen_social/home/tab4/user_profile_screen.dart';
import 'package:hookup4u/util/color.dart';

class SocialMainPage extends StatefulWidget {
  @override
  _SocialMainPageState createState() => _SocialMainPageState();
}

class _SocialMainPageState extends State<SocialMainPage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorRes.primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorRes.primaryColor,
        /*  appBar: new AppBar(
            title: new Text("Social app"),
            *//*bottom: TabBar(
              unselectedLabelColor: Colors.white,

              labelColor: Colors.amber,
              tabs: [
                Tab(icon: new Icon(Icons.home)),
                Tab(icon: new Icon(Icons.people)),
                Tab(icon: new Icon(Icons.notifications)),
                Tab(icon: new Icon(Icons.person))
              ],
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            bottomOpacity: 1,*//*
          ),*/
          bottomNavigationBar:  Container(
            color: ColorRes.primaryColor,
            child: TabBar(
              unselectedLabelColor: ColorRes.greyBg,
              labelColor: ColorRes.primaryRed,
              tabs: [
                Tab(icon: new Icon(Icons.home), text: "Home"),
                Tab(icon: new Icon(Icons.stream), text: "Streams"),
                Tab(icon: new Icon(Icons.message), text: "Messages"),
                Tab(icon: new Icon(Icons.notification_important), text: "Notifications"),
                Tab(icon: new Icon(Icons.person), text: "Profiles")
              ],
              controller: _tabController,
              indicatorColor: ColorRes.primaryRed,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [

              SocialHomePage(tabController: _tabController),
              Center(child: new Text("Comming Soon Stream ....", style: TextStyle(color: ColorRes.white, fontSize: 20), overflow: TextOverflow.ellipsis)),
              Center(child: new Text("Comming Soon Message ....", style: TextStyle(color: ColorRes.white, fontSize: 20), overflow: TextOverflow.ellipsis)),
              Center(child: new Text("Comming Soon Notification ....", style: TextStyle(color: ColorRes.white, fontSize: 20), overflow: TextOverflow.ellipsis)),
              Center(child: new Text("Comming Soon Profile ....", style: TextStyle(color: ColorRes.white, fontSize: 20), overflow: TextOverflow.ellipsis)),
              // UserProfileScreen()
            ],
            controller: _tabController,
          ),
        ),
      ),
    );
  }
}
