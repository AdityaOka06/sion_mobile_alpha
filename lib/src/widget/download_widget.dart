import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

downloadWidget(context, String link, filename) async {
  final _status = await Permission.storage.request();
  if (_status.isGranted) {
    Fluttertoast.showToast(
        msg: "Downloading",
        backgroundColor: Theme.of(context).buttonColor,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG);
    final _anotherPath = await getExternalStorageDirectory();
    print("path $_anotherPath");
    var _download = await FlutterDownloader.enqueue(
      url: "$link",
      savedDir: _anotherPath.path,
      fileName: "$filename",
      showNotification: true,
      openFileFromNotification: true,
    );
    return _download;
  } else {
    print("Permission denied");
  }
}
