import 'dart:io';

import 'package:downloads_path_provider/downloads_path_provider.dart';

class PathHandler {
  static Future<String> getDownloadDir() async {
    Directory downloadsDirectory =
        await DownloadsPathProvider.downloadsDirectory;
    print("Download path: ${downloadsDirectory.path}");
    return downloadsDirectory.path;
  }

  static Future<String> getOutputDir() async {
    Directory downloadsDirectory =
        await DownloadsPathProvider.downloadsDirectory;
    print("Download path: ${downloadsDirectory.path}");
    return downloadsDirectory.path + "/manual.pdf";
  }
}
