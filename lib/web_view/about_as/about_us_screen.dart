import 'package:flutter/material.dart';
import 'package:hookup4u/util/color.dart';
import 'package:hookup4u/util/utils.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: Container(
        width: Utils().getDeviceWidth(context),
        // height: Utils().getDeviceHeight(context),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                // margin: EdgeInsets.only(left: 20, right: 20),
                width: Utils().getDeviceWidth(context),
                height: Utils().getDeviceHeight(context) / 1.6,
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("asset/Icon/web_bg.jpg"), fit: BoxFit.fill)
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 150),
                    // titleText(),
                    Image(
                        height: 150,
                        width: 150,
                        image: AssetImage('asset/Icon/icon_dark.png')
                    ),
                  ],
                ),
              ),

              Container(
                // height: 250,
                width: Utils().getDeviceWidth(context) * .3,
                margin: EdgeInsets.only(left: Utils().getDeviceWidth(context) * .05, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 10),
                    Text("The Content title of this article", style: TextStyle(color: ColorRes.black, fontSize: 22)),
                    SizedBox(height: 10),
                    Text("The Content title of this article. The Content title of this article", style: TextStyle(color: ColorRes.black, fontSize: 18)),
                    SizedBox(height: 10),
                    Text("The Content title of this article. The Content title of this article The Content title of this article  "
                        "The Content title of this article", style: TextStyle(color: ColorRes.black, fontSize: 15)),

                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
