import 'dart:io';

import 'package:downloads_path_provider/downloads_path_provider.dart';

class PathHandler {
  static Future<String> getPath() async {
    Directory downloadsDirectory =
        await DownloadsPathProvider.downloadsDirectory;
    print("Download path: ${downloadsDirectory.path}");
    // String filePath = "";
    // try {
    //   filePath = await StoragePath.filePath;
    //   var response = jsonDecode(filePath);
    //   print(response);
    // } on PlatformException {
    //   print("Error pathhandler.dart: Could not get path");
    //   filePath = 'Failed to get path';
    // }
    return downloadsDirectory.path + "/manual.pdf";
  }
}
