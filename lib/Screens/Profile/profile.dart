import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hookup4u/Screens/Information.dart';
import 'package:hookup4u/Screens/Profile/EditProfile.dart';
import 'package:hookup4u/Screens/Profile/settings.dart';
import 'package:hookup4u/models/data_model.dart';
import 'package:hookup4u/util/color.dart';

List adds = [
  {
    'icon': Icons.whatshot,
    'color': Colors.indigo,
    'title': "Get matches faster",
    'subtitle': "Boost your profile once a month",
  },
  {
    'icon': Icons.favorite,
    'color': Colors.lightBlueAccent,
    'title': "more likes",
    'subtitle': "Get free rewindes",
  },
  {
    'icon': Icons.star_half,
    'color': Colors.amber,
    'title': "Increase your chances",
    'subtitle': "Get unlimited free likes",
  },
  {
    'icon': Icons.location_on,
    'color': Colors.purple,
    'title': "Swipe around the world",
    'subtitle': "Passport to anywhere with hookup4u",
  },
  {
    'icon': Icons.vpn_key,
    'color': Colors.orange,
    'title': "Control your profile",
    'subtitle': "highly secured",
  }
];

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            color: Colors.white),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 5),
              child: InkWell(
                onTap: () => showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Info(currentUser);
                    }),
                child: CircleAvatar(
                  backgroundColor: secondryColor,
                  radius: 90,
                  backgroundImage: currentUser.imageUrl.length > 0
                      ? AssetImage(currentUser.imageUrl[0])
                      : null,
                ),
              ),
            ),
            Text(
              "${currentUser.name}, ${currentUser.age}",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            ),
            Text(
              "University of New York",
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height * .5,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 70,
                            width: 70,
                            child: FloatingActionButton(
                                heroTag: UniqueKey(),
                                splashColor: secondryColor,
                                backgroundColor: primaryColor,
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.white,
                                  size: 32,
                                ),
                                onPressed: () {
                                  source(context);
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Add media",
                              style: TextStyle(color: secondryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 30, top: 30),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: <Widget>[
                            FloatingActionButton(
                                splashColor: secondryColor,
                                heroTag: UniqueKey(),
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.settings,
                                  color: secondryColor,
                                  size: 28,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Settings()));
                                }),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Settings",
                                style: TextStyle(color: secondryColor),
                              ),
                            )
                          ],
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(right: 30, top: 30),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          children: <Widget>[
                            FloatingActionButton(
                                heroTag: UniqueKey(),
                                splashColor: secondryColor,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.edit,
                                  color: secondryColor,
                                  size: 28,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditProfile()));
                                }),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Edit Info",
                                style: TextStyle(color: secondryColor),
                              ),
                            ),
                          ],
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 230),
                    child: Container(
                      height: 120,
                      child: CustomPaint(
                        painter: CurvePainter(),
                        size: Size.infinite,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        height: 100,
                        width: MediaQuery.of(context).size.width * .85,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Swiper(
                            key: UniqueKey(),
                            curve: Curves.linear,
                            autoplay: true,
                            physics: ScrollPhysics(),
                            itemBuilder: (BuildContext context, int index2) {
                              return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          adds[index2]["icon"],
                                          color: adds[index2]["color"],
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          adds[index2]["title"],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      adds[index2]["subtitle"],
                                      textAlign: TextAlign.center,
                                    ),
                                  ]);
                            },
                            itemCount: adds.length,
                            pagination: new SwiperPagination(
                                alignment: Alignment.bottomCenter,
                                builder: DotSwiperPaginationBuilder(
                                    activeSize: 10,
                                    color: secondryColor,
                                    activeColor: primaryColor)),
                            control: new SwiperControl(
                              size: 20,
                              color: primaryColor,
                              disableColor: secondryColor,
                            ),
                            loop: false,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.color = secondryColor.withOpacity(.4);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1.5;

    var startPoint = Offset(0, -size.height / 2);
    var controlPoint1 = Offset(size.width / 4, size.height / 3);
    var controlPoint2 = Offset(3 * size.width / 4, size.height / 3);
    var endPoint = Offset(size.width, -size.height / 2);

    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

source(context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            "Select source",
          ),
          insetAnimationCurve: Curves.decelerate,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.photo_camera,
                    size: 28,
                  ),
                  Text(
                    " Camera",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.photo_library,
                    size: 28,
                  ),
                  Text(
                    " Gallery",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                ],
              ),
            ),
          ],
        );
      });
}
