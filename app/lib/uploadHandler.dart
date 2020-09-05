import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UploadHandler extends StatefulWidget {
  @override
  _UploadHandlerState createState() => _UploadHandlerState();
}

class _UploadHandlerState extends State<UploadHandler> {
  File file;

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
            RaisedButton(
              child: Text("Choose File"),
              onPressed: () async {
                file = await FilePicker.getFile(type: FileType.any);
                print("File path: ${file.absolute}");
              },
            ),
            RaisedButton(
              child: Text("Upload"),
              onPressed: () async {
                var uri =
                    Uri.parse('https://tokensprtify.herokuapp.com/ipfsStore');
                var request = http.MultipartRequest('POST', uri)
                  ..fields['user'] = 'private key'
                  ..files.add(
                    await http.MultipartFile.fromPath(
                      'package',
                      file.path,
                      // contentType: MediaType('application', 'x-tar'),
                    ),
                  );
                var response = await request.send();
                if (response.statusCode == 200) print('Uploaded!');

                // http.Response response = await http.post(
                //   'https://tokensprtify.herokuapp.com/ipfsStore',
                //   body: {
                //     'file': file.readAsBytesSync().toString(),
                //   },
                // );
                // print("Upload Response: ${response.body}");
              },
            ),
          ],
        ),
      ),
    );
  }
}
