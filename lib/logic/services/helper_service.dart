import 'dart:io';
import 'package:filesize/filesize.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class HelperService {
  static Future<File> compressFile(File file) async {
    final String filePath = file.absolute.path;

    print(filePath);

    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: 25,
    );

    print(filesize(file.lengthSync()));
    print(filesize(result.lengthSync()));

    return result;
  }
}
