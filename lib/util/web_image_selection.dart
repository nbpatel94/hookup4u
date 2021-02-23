// import 'dart:convert';
// import 'dart:html' as html;
// import 'dart:async';
//
// class WebImageSelection {
//
//   Future<List<int>> selectImageWeb() async {
//     final completer = Completer<List<String>>();
//     final html.InputElement input = html.document.createElement('input');
//     input
//       ..type = 'file'
//       ..multiple = false
//       ..accept = 'image/*';
//     input.click();
//     // onChange doesn't work on mobile safari
//     input.addEventListener('change', (e) async {
//       final List<html.File> files = input.files;
//
//       Iterable<Future<String>> resultsFutures = files.map((file) {
//         final reader = html.FileReader();
//         reader.readAsDataUrl(file);
//         reader.onError.listen((error) => completer.completeError(error));
//         return reader.onLoad.first.then((_) => reader.result as String);
//       });
//       final results = await Future.wait(resultsFutures);
//       completer.complete(results);
//     });
//     // need to append on mobile safari
//     html.document.body.append(input);
//     // input.click(); can be here
//
//     // String image = completer.
//
//     final List<String> images = await completer.future;
//     String imageBase64 = images[0];
//
//     print(images);
//
//     List<int> uploadedImage = base64Decode(imageBase64);
//     print("Hello1 $uploadedImage");
//
//     return uploadedImage;
//     // List<int> _imageBytesDecoded = base64.decode(imageBase64);
//     // print(_imageBytesDecoded);
//       // _uploadedImages = images;
//
//     // model.imageUpload(image);
//
//     input.remove();
//   }
// }
