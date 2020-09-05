import 'dart:io';

import 'package:app/decryptHandler.dart';
import 'package:app/downloadHandler.dart';
import 'package:app/studentWallet.dart';
import 'package:app/submissionHandler.dart';
import 'package:app/uploadHandler.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File file;

  @override
  void initState() {
    super.initState();
    _getStoragePermission();
  }

  void _getStoragePermission() async {
    var status = await Permission.storage.status;
    print(status);
    if (status.isUndetermined) {
      print("Undetermined, requesting");
      status = await Permission.storage.request();
    }

    if (await Permission.storage.isGranted) {
      print("granted, returning");
      return;
    }

    if (await Permission.storage.isDenied) {
      print("denied, requesting");
      status = await Permission.storage.request();
    }

    if (await Permission.storage.isRestricted) {
      print("restricted, requesting");
      status = await Permission.storage.request();
    }

    if (await Permission.storage.isPermanentlyDenied) {
      print("permanently denied, open settings");
      var opened = await openAppSettings();
      _getStoragePermission();
      print("Rationale opened: $opened");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StudentWallet>(
      future: StudentWallet.newStudent(),
      builder: (BuildContext context, AsyncSnapshot<StudentWallet> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Dashboard"),
              actions: [
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext contxt) {
                        return AlertDialog(
                          title: Text("About"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SelectableText(
                                  "Private Key : ${snapshot.data.getPrivateKey}"),
                              SizedBox(height: 20),
                              SelectableText(
                                  "Credential Address : ${snapshot.data.getCredAddress}"),
                            ],
                          ),
                          actions: [
                            FlatButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text("Copy"),
                              onPressed: () {
                                ClipboardManager.copyToClipBoard(
                                        "Private Key : ${snapshot.data.getPrivateKey} Credential Address : ${snapshot.data.getCredAddress}")
                                    .then(
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
                          ],
                        );
                      },
                    );
                  },
                )
              ],
            ),
            body: GridView.count(
              crossAxisCount: 2,
              children: <Widget>[
                dispCard("Download", DownloadHandler()),
                dispCard("Decrypt", Decrypthandler()),
                dispCard("Submit", SubmissionHandler()),
                dispCard("Upload", UploadHandler()),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text("Getting student wallet")
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget dispCard(String name, Widget page) {
    return Card(
      child: Center(
        child: ListTile(
          title: Text(
            name,
            textAlign: TextAlign.center,
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return page;
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
