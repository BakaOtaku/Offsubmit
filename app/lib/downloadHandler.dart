import 'package:app/pathHandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class DownloadHandler extends StatelessWidget {
  final TextEditingController _downloadLink = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Download Question"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _downloadLink,
            decoration: InputDecoration(
              labelText: "Link",
            ),
          ),
          RaisedButton(
            child: Text("Download"),
            onPressed: () async {
              final taskId = await FlutterDownloader.enqueue(
                url: _downloadLink.text,
                savedDir: await PathHandler.getPath(),
                showNotification: true,
                openFileFromNotification: true,
              );
              print("Task - Downloading file task ID: $taskId");
            },
          ),
        ],
      ),
    );
  }
}
