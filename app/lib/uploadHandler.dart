import 'dart:io';

import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class UploadHandler extends StatefulWidget {
  @override
  _UploadHandlerState createState() => _UploadHandlerState();
}

class _UploadHandlerState extends State<UploadHandler> {
  File file;
  bool _fileVisibility = false;
  String ipfshash = '';
  bool _visibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Uploading"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: _fileVisibility,
              child: Text(file?.path?.split("/")?.last ?? ''),
            ),
            SizedBox(height: 30),
            RaisedButton(
              child: Text("Choose File"),
              onPressed: () async {
                file = await FilePicker.getFile(type: FileType.any);
                print("File path: ${file.absolute}");
                setState(() {
                  if (file != null) {
                    _fileVisibility = true;
                  } else {
                    _fileVisibility = false;
                  }
                });
              },
            ),
            SizedBox(height: 20),
            RaisedButton(
              child: Text("Upload"),
              onPressed: () async {
                var uri =
                    Uri.parse('https://tokensprtify.herokuapp.com/ipfsStore');
                var request = http.MultipartRequest('POST', uri)
                  ..files.add(
                    http.MultipartFile.fromBytes(
                      'file',
                      file.readAsBytesSync(),
                      filename: 'manual.pdf',
                    ),
                  );
                var response = await request.send();
                print("Got streamed response");
                http.Response response2 =
                    await http.Response.fromStream(response);
                print("Result response2: ${response2.statusCode}");
                print("Body response2: ${response2.body}");
                // return response2.body;
                if (response2.statusCode == 200) {
                  print('Uploaded!');
                  setState(() {
                    ipfshash = response2.body;
                    if (file != null) {
                      _visibility = true;
                    } else {
                      _visibility = false;
                    }
                  });
                  Fluttertoast.showToast(
                    msg: "File Uploaded",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } else {
                  print("Error: ${response.statusCode}");
                  Fluttertoast.showToast(
                    msg: "Uploaded Failed ${response.statusCode}",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }

                // http.Response response = await http.post(
                //   'https://tokensprtify.herokuapp.com/ipfsStore',
                //   body: <String, dynamic>{
                //     'file': await http.MultipartFile.fromPath(
                //       'file',
                //       file.path,
                //       // contentType: MediaType('application', 'x-tar'),
                //     ),
                //   },
                // );
                // print("Upload Response: ${response.body}");
              },
            ),
            SizedBox(height: 30),
            Visibility(
              visible: _visibility,
              child: Column(
                children: [
                  SelectableText(ipfshash),
                  IconButton(
                    icon: Icon(Icons.content_copy),
                    onPressed: () {
                      ClipboardManager.copyToClipBoard(ipfshash).then(
                        (result) {
                          Fluttertoast.showToast(
                            msg: "Copied Hash to clipboard",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
