import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hookup4u/models/socialPostShowModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'edit_viewmodel.dart';

class EditDataScreen extends StatefulWidget {

  final bool isShare;
  final SocialPostShowData socialPostShowData;
  const EditDataScreen({Key key, this.socialPostShowData, this.isShare}) : super(key: key);

  @override
  EditDataScreenState createState() => EditDataScreenState();
}

class EditDataScreenState extends State<EditDataScreen> {

  File image;
  EditDataViewModel model;
  String dropdownValue = 'Public';
  List<Asset> images = List<Asset>();
  TextEditingController containController = TextEditingController();
  String imageShow = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.socialPostShowData.content != null) {
      containController.text = widget.socialPostShowData.content;
    }

    print(widget.socialPostShowData.media.length);

    if(widget.isShare) {
      Future.delayed(const Duration(seconds: 1), () {
        if(widget.socialPostShowData.parentPost.media != null && widget.socialPostShowData.parentPost.media.isNotEmpty) {
          setState(() {
            model.imagesList.addAll(widget.socialPostShowData.parentPost.media);
          });
        }
        if(widget.socialPostShowData.visibility != null) {
          dropdownValue = widget.socialPostShowData.visibility;
          print("hello  $dropdownValue");
        }
      });
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        if(widget.socialPostShowData.media != null && widget.socialPostShowData.media.isNotEmpty) {
          setState(() {
            model.imagesList.addAll(widget.socialPostShowData.media);
          });
        }
        if(widget.socialPostShowData.visibility != null) {
          dropdownValue = widget.socialPostShowData.visibility;
          print("hello  $dropdownValue");
        }
      });
    }
    print(dropdownValue);

    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    model ?? (model = EditDataViewModel(this));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit upload"),
          actions: [
            IconButton(
                icon: Icon(Icons.post_add, color: Colors.white), onPressed: () {
              print("tap");
              model.editPostApi(widget.socialPostShowData.id);
            })
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [

              containData(),

              visibility(),

              widget.isShare ? Container() : InkResponse(
                onTap: () {
                  source(context);
                },
                child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 4,
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

              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: model.imagesList != null && model.imagesList.isNotEmpty ?  model.imagesList.length: 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                  return Stack(
                    children: [

                      widget.isShare ?  Container() : Container(
                        height: 100,
                        width: 100,
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: imageShow1(index),
                      ) ,


                      widget.isShare ? Container() : Positioned(
                          right: 0,
                          child: IconButton(icon: Icon(Icons.close, color: Colors.black, size: 30), onPressed: () {
                            model.imagesList.removeAt(index);
                            setState(() {});
                          })
                      ),
                    ],
                  );
                }),
              )

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
                  FocusScope.of(context).requestFocus(new FocusNode());
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

  imageShow1(int index) {
    if(model.imagesList != null && model.imagesList.isNotEmpty) {
      return   CachedNetworkImage(
          imageUrl: model.imagesList != null && model.imagesList.isNotEmpty ?  model.imagesList[index] : 0,
          placeholder: (context, url) => Image.asset(
              'asset/Icon/placeholder.png',
              height: 120,
              width: 120,
              fit: BoxFit.cover),
          height: 120,
          width: 120,
          fit: BoxFit.cover);
    } /*else if(widget.socialPostShowData.media != null && widget.socialPostShowData.media.length != 0) {
      return CachedNetworkImage(
          imageUrl: model.imagesList != null && model.imagesList.isNotEmpty ?  model.imagesList[index] : 0,
          placeholder: (context, url) => Image.asset(
              'asset/Icon/placeholder.png',
              height: 120,
              width: 120,
              fit: BoxFit.cover),
          height: 120,
          width: 120,
          fit: BoxFit.cover);
    }*/ else {
      return Image.asset(
          'asset/Icon/placeholder.png',
          height: 120,
          width: 120,
          fit: BoxFit.cover
      );
    }
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


