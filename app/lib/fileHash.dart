import 'dart:io';

import 'package:crypto/crypto.dart';

class FileHash {
  static getFileHash(File file) async {
    Hash hasher = sha256;
    var value = await hasher.bind(file.openRead()).first;
    print("Hash: $value");
    return value;
  }
}
