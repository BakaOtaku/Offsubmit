import 'dart:io';

import 'package:app/fileHash.dart';
import 'package:app/studentWallet.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_sms/flutter_sms.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms/sms.dart';

class SubmissionHandler extends StatefulWidget {
  @override
  _SubmissionHandlerState createState() => _SubmissionHandlerState();
}

class _SubmissionHandlerState extends State<SubmissionHandler> {
  final TextEditingController _subController = TextEditingController();

  bool _fileVisibility = false;
  File file;
  String data = '';
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Submissions"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                SizedBox(height: 30),
                TextFormField(
                  controller: _subController,
                  decoration: InputDecoration(
                    labelText: "Subject ID",
                  ),
                ),
                SizedBox(height: 20),
                RaisedButton(
                  child: Text("Generate"),
                  onPressed: () async {
                    String hash = await FileHash.getFileHash(file);
                    data = StudentWallet.privateKey +
                        ":" +
                        _subController.text +
                        ":" +
                        hash.substring(0, 45);
                    setState(() {
                      visible = true;
                    });
                  },
                ),
                SizedBox(height: 30),
                Visibility(
                  visible: visible,
                  child: Column(
                    children: [
                      SelectableText(data ?? ''),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(Icons.content_copy),
                            onPressed: () {
                              ClipboardManager.copyToClipBoard(data).then(
                                (result) {
                                  Fluttertoast.showToast(
                                    msg: "Copied to clipboard",
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
                          IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              final SmsSender sender = new SmsSender();
                              const String address = '+917268867761';

                              SmsMessage message =
                                  new SmsMessage(address, data);
                              message.onStateChanged.listen((state) {
                                if (state == SmsMessageState.Sent) {
                                  print("SMS is sent!");
                                  Fluttertoast.showToast(
                                    msg: "SMS is sent!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                } else if (state == SmsMessageState.Delivered) {
                                  print("SMS is delivered!");
                                  Fluttertoast.showToast(
                                    msg: "SMS is delivered!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                }
                              });
                              sender.sendSms(message);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Send an SMS to your course instructor",
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
