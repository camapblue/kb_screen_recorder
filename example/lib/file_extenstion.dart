import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

extension FileExtension on File {
  String get fileName {
    return path.split('/').last;
  }

  static Future<String?> getTempDirectory() async {
    var tempDir = await getExternalStorageDirectory();
    if (tempDir == null) {
      final directories =
          await getExternalStorageDirectories(type: StorageDirectory.downloads);
      tempDir = directories != null && directories.isNotEmpty
          ? directories.first
          : null;
    }
    final tempPath = tempDir?.path;
    return tempPath;
  }

  static Future<File> buildImageFile(Uint8List bytes) async {
    final tempDir = await getTemporaryDirectory();
    final file = await File(
            '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png')
        .create();
    file.writeAsBytesSync(bytes);

    return file;
  }
}
