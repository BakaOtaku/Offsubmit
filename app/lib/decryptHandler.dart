import 'dart:io';

import 'package:app/pathHandler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Decrypthandler extends StatefulWidget {
  @override
  _DecrypthandlerState createState() => _DecrypthandlerState();
}

class _DecrypthandlerState extends State<Decrypthandler> {
  TextEditingController _password = TextEditingController();
  var platformChannel = MethodChannel("exam");
  File file;
  bool _fileVisibility = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Decrypt"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
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
            SizedBox(height: 30),
            TextFormField(
              controller: _password,
              decoration: InputDecoration(
                labelText: "Password",
              ),
            ),
            SizedBox(height: 20),
            RaisedButton(
              child: Text("Decrypt"),
              onPressed: () async {
                // Directory dir = await DownloadsPathProvider.downloadsDirectory;
                Map<String, dynamic> arguments = {
                  'password': _password.text,
                  'inputPath': file.path,
                  'outputPath': await PathHandler.getOutputDir(),
                };
                try {
                  await platformChannel.invokeMethod("decrypt-AES", arguments);
                } catch (e) {
                  print("Caught exception andoid native: $e");
                }
                // String plainText = 'PlainText is Me';
                // var encrypted = encryptAESCryptoJS(plainText, "password");
                // print(encrypted);
                // var encrypted = await file.readAsBytes();
                // var decrypted = decryptAESCryptoJS(encrypted, "4677011493423011");
                // print(decrypted);
              },
            ),
          ],
        ),
      ),
    );
  }
}
