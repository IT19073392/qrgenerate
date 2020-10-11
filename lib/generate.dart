// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:flutter/services.dart';
// import 'dart:async';
// import 'dart:typed_data';
// import 'dart:ui';
// import 'dart:io';
// import 'package:flutter/rendering.dart';
// import 'package:path_provider/path_provider.dart';

// class GenerateScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => GenerateScreenState();
// }

// class GenerateScreenState extends State<GenerateScreen> {
//   static const double _topSectionTopPadding = 50.0;
//   static const double _topSectionBottomPadding = 20.0;
//   static const double _topSectionHeight = 50.0;

//   GlobalKey globalKey = new GlobalKey();
//   String _dataString = "Hello from this QR";
//   String _inputErrorText;
//   final TextEditingController _textController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('QR Code Generator'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.share),
//             onPressed: _captureAndSharePng,
//           )
//         ],
//       ),
//       body: _contentWidget(),
//     );
//   }

//   Future<void> _captureAndSharePng() async {
//     try {
//       RenderRepaintBoundary boundary =
//           globalKey.currentContext.findRenderObject();
//       var image = await boundary.toImage();
//       ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
//       Uint8List pngBytes = byteData.buffer.asUint8List();

//       final tempDir = await getTemporaryDirectory();
//       final file = await new File('${tempDir.path}/image.png').create();
//       await file.writeAsBytes(pngBytes);

//       final channel = const MethodChannel('channel:me.alfian.share/share');
//       channel.invokeMethod('shareFile', 'image.png');
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   _contentWidget() {
//     final bodyHeight = MediaQuery.of(context).size.height -
//         MediaQuery.of(context).viewInsets.bottom;
//     return Container(
//       color: const Color(0xFFFFFFFF),
//       child: Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(
//               top: _topSectionTopPadding,
//               left: 20.0,
//               right: 10.0,
//               bottom: _topSectionBottomPadding,
//             ),
//             child: Container(
//               height: _topSectionHeight,
//               child: Row(
//                 mainAxisSize: MainAxisSize.max,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Expanded(
//                     child: TextField(
//                       controller: _textController,
//                       decoration: InputDecoration(
//                         hintText: "Enter a custom message",
//                         errorText: _inputErrorText,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10.0),
//                     child: FlatButton(
//                       child: Text("SUBMIT"),
//                       onPressed: () {
//                         setState(() {
//                           _dataString = _textController.text;
//                           _inputErrorText = null;
//                         });
//                       },
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: Center(
//               child: RepaintBoundary(
//                 key: globalKey,
//                 child: QrImage(
//                   data: _dataString,
//                   size: 0.5 * bodyHeight,
//                   onError: (ex) {
//                     print("[QR] ERROR - $ex");
//                     setState(() {
//                       _inputErrorText =
//                           "Error! Maybe your input value is too long?";
//                     });
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';

class GeneratePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GeneratePageState();
}

class GeneratePageState extends State<GeneratePage> {
  String qrData =
      "https://github.com/neon97"; // already generated qr code when the page opens

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImage(
              //plce where the QR Image will be shown
              data: qrData,
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              "New QR Link Generator",
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
              controller: qrdataFeed,
              decoration: InputDecoration(
                hintText: "Input your link or data",
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
              child: FlatButton(
                padding: EdgeInsets.all(15.0),
                onPressed: () async {
                  if (qrdataFeed.text.isEmpty) {
                    //a little validation for the textfield
                    setState(() {
                      qrData = "";
                    });
                  } else {
                    setState(() {
                      qrData = qrdataFeed.text;
                    });
                  }
                },
                child: Text(
                  "Generate QR",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blue, width: 3.0),
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            )
          ],
        ),
      ),
    );
  }

  final qrdataFeed = TextEditingController();
}
