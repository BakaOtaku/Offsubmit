import 'dart:io';

import 'package:app/decryptHandler.dart';
import 'package:app/downloadHandler.dart';
import 'package:app/uploadHandler.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _subId = TextEditingController();
  File file;
  // TextEditingController _controller = TextEditingController();
  // TextEditingController _controller = TextEditingController();
  // TextEditingController _controller = TextEditingController();

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Download
              DownloadHandler(),
              SizedBox(height: 20),
              Decrypthandler(),
              SizedBox(height: 20),
              // Upload
              UploadHandler(),
            ],
          ),
        ),
      ),
    );
  }
}
