import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hookup4u/util/color.dart';
import 'package:hookup4u/util/web_image_selection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'post_data_viewmodel.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;
// import 'dart:html' as html;

class PostDataScreen extends StatefulWidget {

  final bool isEdit;
  final String postId;

  const PostDataScreen({Key key, this.isEdit, this.postId}) : super(key: key);

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
    return Scaffold(
      backgroundColor: ColorRes.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          InkWell(
              onTap: () {
                if(containController.text.trim() != null && containController.text.trim().isNotEmpty) {
                  model.addPostApi(widget.postId);
                }
              },
              child: Center(
                  child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text("Done", style: TextStyle(color: ColorRes.primaryRed))))
          )
        ],
      ),
      body: SafeArea (
        child: SingleChildScrollView (
          child: Column (
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding (
                  padding: EdgeInsets.only (left: 10),
                  child: Text(widget.isEdit ? "Share post" : "Create a post", style: TextStyle(color: ColorRes.white, fontSize: 30))),

              SizedBox(height: 10),
              containData(),
              SizedBox(height: 10),
              visibility(),
              widget.isEdit ? Container() : InkResponse(
                onTap: () {
                  if(!kIsWeb) {
                    source(context);
                  } else {
                    // FocusScope.of(context).unfocus();
                    print("click web image");
                    // loadAssets();
                    // _selectImage();


                    // _startFilePicker();

                  }
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                      width: MediaQuery.of(context).size.height / 4,
                      height: MediaQuery.of(context).size.height / 4,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          color: ColorRes.white,
                          border: Border.all(color: Colors.black12, width: 1),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      // child: image == null || image.length == 0 ? Icon (
                      //     Icons.image, color: Colors.black
                      // ) :
                      // AssetThumb(
                      //   asset: images[0],
                      //   width: 300,
                      //   height: 300,
                      // )
                      // Image(image: AssetImage(image.path)),

                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Icon (Icons.image, color: Colors.black),
                      Text("Add Image", style: TextStyle(color: ColorRes.black))
                    ])
                  ),
                ),
              ),

              selectedImageShow()

            ],
          ),
        ),
      ),
    );
  }


  selectedImageShow() {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: model.imagesList != null && model.imagesList.isNotEmpty ?  model.imagesList.length: 0,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                !kIsWeb ? Container(
                  height: 120,
                  width: 120,
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: model.imagesList != null && model.imagesList.isNotEmpty
                      ? CachedNetworkImage(
                      imageUrl: model.imagesList != null && model.imagesList.isNotEmpty ?  model.imagesList[index] : 0,
                      placeholder: (context, url) => Image.asset(
                          'asset/Icon/placeholder.png',
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover),
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover)
                      : Image.asset(
                      'asset/Icon/placeholder.png',
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover
                  ),
                ) : Container(
                  height: 120,
                  width: 120,
                  margin: EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: model.imagesList != null && model.imagesList.isNotEmpty
                      ? CachedNetworkImage(
                      imageUrl: model.imagesList != null && model.imagesList.isNotEmpty ?  model.imagesList[index] : 0,
                      placeholder: (context, url) => Image.asset(
                          'asset/Icon/placeholder.png',
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover),
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover)
                      : Image.asset(
                      'asset/Icon/placeholder.png',
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover
                  ),
                ),


                widget.isEdit ? Container() : Positioned (
                    right: 0,
                    child: IconButton(icon: Icon(Icons.close, color: Colors.black, size: 30), onPressed: () {
                      model.imagesList.removeAt(index);
                      setState(() {});
                    })
                ) ,
              ],
            );
          }),
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
                  File _image = await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50);
                  if (_image != null) {
                    image = _image;
                    print("Image ${image.absolute.path}");
                    print(image.readAsBytesSync());
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




  // Future<void> _selectImage() async {
  //   final completer = Completer<List<String>>();
  //   final html.InputElement input = html.document.createElement('input');
  //   input
  //     ..type = 'file'
  //     ..multiple = false
  //     ..accept = 'image/*';
  //   input.click();
  //   // onChange doesn't work on mobile safari
  //   input.addEventListener('change', (e) async {
  //     final List<html.File> files = input.files;
  //
  //     Iterable<Future<String>> resultsFutures = files.map((file) {
  //       final reader = html.FileReader();
  //       reader.readAsDataUrl(file);
  //       reader.onError.listen((error) => completer.completeError(error));
  //       return reader.onLoad.first.then((_) => reader.result as String);
  //     });
  //     final results = await Future.wait(resultsFutures);
  //     completer.complete(results);
  //   });
  //   // need to append on mobile safari
  //   html.document.body.append(input);
  //   // input.click(); can be here
  //
  //   // String image = completer.
  //
  //   final List<String> images = await completer.future;
  //   String imageBase64 = images[0];
  //
  //   Uint8List data = base64.decode(imageBase64);
  //
  //   print("unit 8 data $data");
  //   // List<int> _imageBytesDecoded = base64Decode(imageBase64);
  //
  //   // uploadedImage = base64Decode(imageBase64);
  //   // List<int> _imageBytesDecoded = base64.decode(imageBase64);
  //
  //   // print(images);
  //   // print("List int data $_imageBytesDecoded");
  //
  //   // _uploadedImages = images;
  //
  //   // setState(() {});
  //
  //   // model.imageUpload(images);
  //
  //   // _con.imageUploadApi(imageBase64);
  //   input.remove();
  // }

  Uint8List uploadedImage;

  // _startFilePicker() async {
  //   html.InputElement uploadInput = html.FileUploadInputElement();
  //   uploadInput.click();
  //
  //   uploadInput.onChange.listen((e) {
  //
  //     // read file content as dataURL
  //
  //     final files = uploadInput.files;
  //     if (files.length == 1) {
  //
  //       final file = files[0];
  //       html.FileReader reader =  html.FileReader();
  //
  //       reader.onLoadEnd.listen((e) {
  //         setState(() {
  //           uploadedImage = reader.result;
  //           // print("Unit 8 list $uploadedImage");
  //           model.webImageUpload(uploadedImage);
  //
  //         });
  //       });
  //
  //       reader.onError.listen((fileEvent) {
  //         setState(() {
  //          String option1Text = "Some Error occured while reading the file";
  //         });
  //       });
  //
  //       reader.readAsArrayBuffer(file);
  //
  //     }
  //   });
  // }


  containData() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2.3,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        decoration: BoxDecoration(
            color: ColorRes.white,
            border: Border.all(width: 1, color: Colors.black12)),
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
          color: ColorRes.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: ColorRes.greyBg, blurRadius: 1)]
          // border: Border.all(color: Colors.black, width: 1)
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: dropdownValue,
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: <String>['Public', 'Private', 'Friends'].map<DropdownMenuItem<String>>((String value) {
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


