import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/screen_social/home/home_screen.dart';

class SocialMainPage extends StatefulWidget {
  @override
  _SocialMainPageState createState() => _SocialMainPageState();
}

class _SocialMainPageState extends State<SocialMainPage> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: new AppBar(
          title: new Text("Social app"),
          bottom: TabBar(
            unselectedLabelColor: Colors.white,
            labelColor: Colors.amber,
            tabs: [
              new Tab(icon: new Icon(Icons.home)),
              new Tab(
                icon: new Icon(Icons.people),
              ),
              new Tab(
                icon: new Icon(Icons.notifications),
              )
            ],
            controller: _tabController,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,),
          bottomOpacity: 1,
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            SocialHomePage(),
            Center(child: new Text("This is chat Tab View")),
            Center(child: new Text("This is notification Tab View")),
          ],
          controller: _tabController,),
      ),
    );
  }
}
