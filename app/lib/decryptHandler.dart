import 'dart:io';

import 'package:app/decrypt.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Decrypthandler extends StatefulWidget {
  @override
  _DecrypthandlerState createState() => _DecrypthandlerState();
}

class _DecrypthandlerState extends State<Decrypthandler> {
  TextEditingController _password = TextEditingController();
  File file;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RaisedButton(
          child: Text("Choose File"),
          onPressed: () async {
            file = await FilePicker.getFile(type: FileType.any);
          },
        ),
        TextFormField(
          controller: _password,
          decoration: InputDecoration(
            labelText: "Password",
          ),
        ),
        RaisedButton(
          child: Text("Decrypt"),
          onPressed: () async {
            // String plainText = 'PlainText is Me';
            // var encrypted = encryptAESCryptoJS(plainText, "password");
            // print(encrypted);
            var encrypted = file.readAsBytesSync().toString();
            var decrypted = decryptAESCryptoJS(encrypted, "4677011493423011");
            print(decrypted);
          },
        ),
      ],
    );
  }
}
