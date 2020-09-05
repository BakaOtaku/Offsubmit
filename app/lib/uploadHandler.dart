import 'package:flutter/material.dart';

class UploadHandler extends StatelessWidget {
  final TextEditingController _uploadLink = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _uploadLink,
            decoration: InputDecoration(
              labelText: "Link",
            ),
          ),
          RaisedButton(
            onPressed: () {},
            child: Text("Upload"),
          ),
        ],
      ),
    );
  }
}
