import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hookup4u/Screens/screen_social/home/post_data/post_data_viewmodel.dart';
import 'package:hookup4u/restapi/social_restapi.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PostDataScreen extends StatefulWidget {
  @override
  PostDataScreenState createState() => PostDataScreenState();
}

class PostDataScreenState extends State<PostDataScreen> {

  File image;
  PostDataViewModel model;

  String dropdownValue = 'Public';

  List<Asset> images = List<Asset>();

  TextEditingController containController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    model ?? (model = PostDataViewModel(this));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Post upload"),
          actions: [
            IconButton(
                icon: Icon(Icons.post_add, color: Colors.white), onPressed: () {
              print("tap");
              model.addPostApi();
            })
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [

              containData(),

              visibility(),

              InkResponse(
                onTap: () {
                  source(context);
                },
                child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 2,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: image == null || image.length == 0 ? Icon(
                        Icons.image, color: Colors.black) :
                    // AssetThumb(
                    //   asset: images[0],
                    //   width: 300,
                    //   height: 300,
                    // )

                  Image(image: AssetImage(image.path))
                ),
              ),

            ],
          ),
        ),
      ),
    );
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
              GestureDetector(
                onTap: () async {
                  var _image = await ImagePicker.pickImage(
                      source: ImageSource.camera);
                  if (_image != null) {
                    image = _image;
                    print("Image ${image.absolute.path}");
                    // model.uploadUseMedia();
                    setState(() {});
                    Navigator.pop(context);
                  }
                },
                child: Padding(
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
              ),
              GestureDetector(
                onTap: () async {
                  // loadAssets();

                  File _image = await ImagePicker.pickImage(source: ImageSource.gallery);
                  if (_image != null) {
                    image = _image;
                    print("Image ${image.absolute.path}");
                    // model.uploadUseMedia();
                    setState(() {});
                    model.imageUpload(image);
                    Navigator.pop(context);
                  }
                },
                child: Padding(
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
              ),
            ],
          );
        });
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }


    Navigator.pop(context);
    if (!mounted) return;


    setState(() {
      // image = resultList;
      images = resultList;
      print(images[0].name);
      // _error = error;
    });


    // List<ByteData> byteDataList = await Future.wait(images.map((Asset image) => image.getByteData()));

    for(int i = 0; i < images.length; i++) {
      ByteData byteData = await images[i].getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      print("hello ${images[i].getByteData().toString()}");
      // await model.imageUpload(imageData, images[i].name);
    }




    setState(() {});

  }

  containData() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2.3,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: EdgeInsets.all(5),
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
        child: TextField(
          maxLines: 13,
          controller: containController,
          // keyboardType: TextInputType.text,
          textInputAction: TextInputAction.newline,
          decoration: new InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              hintText: "Hint here"),
        ));
  }

  visibility() {
    return Container(
      height: 50,
      width: MediaQuery
          .of(context)
          .size
          .width,
      margin: EdgeInsets.only(left: 8, right: 8),
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1)
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: dropdownValue,
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: <String>['Public', 'Private', 'Friends']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          })
              .toList(),
        ),
      ),
    );
  }


  /*void getFileList() async {
    listFile.clear();
    for (int i = 0; i < images.length; i++) {
      var path = await images[i].filePath;
      print(path);
      var file = await getImageFileFromAsset(path);
      print(file);
      listFile.add(file);
    }
  }


  Future<File> getImageFileFromAsset(String path) async {
    final file = File(path);
    return file;
  }

  List<File> listFile = List<File>();*/

}


