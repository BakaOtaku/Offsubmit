import 'package:app/pathHandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DownloadHandler extends StatefulWidget {
  @override
  _DownloadHandlerState createState() => _DownloadHandlerState();
}

class _DownloadHandlerState extends State<DownloadHandler> {
  final TextEditingController _downloadLink = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Download Question"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _downloadLink,
              decoration: InputDecoration(
                labelText: "Link",
              ),
            ),
            SizedBox(height: 20),
            RaisedButton(
              child: Text("Download"),
              onPressed: () async {
                final taskId = await FlutterDownloader.enqueue(
                  url: _downloadLink.text,
                  savedDir: await PathHandler.getDownloadDir(),
                  showNotification: true,
                  openFileFromNotification: true,
                );
                print("Task - Downloading file task ID: $taskId");
                setState(() {
                  _downloadLink.clear();
                });
                Fluttertoast.showToast(
                  msg: "Check notification for download status",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
