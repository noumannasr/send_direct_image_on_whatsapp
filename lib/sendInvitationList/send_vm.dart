import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

class SendInvitation extends ChangeNotifier {
  List<Users> users = [
    Users(phone: '923314257676', name: 'Nouman'),
    Users(phone: '923345456942', name: 'Arslan'),
  ];

  String _invitation = '';

  String get invitation => _invitation;

  setInvitaion(String invi) {
    _invitation = invi;
    log("localPath is null ${_invitation}");
    notifyListeners();
  }

  Future<void> shareScreenShot(String phone) async {
    // Directory? directory;
    // if (Platform.isAndroid) {
    //   directory = await getExternalStorageDirectory();
    // } else {
    //   directory = await getApplicationDocumentsDirectory();
    // }
    //
    // final String? localPath = await _controller.captureAndSave(directory!.path);
    //
    // await Future.delayed(const Duration(seconds: 1));
    // if (localPath == null) {
    //   log("localPath is null");
    // }

    await WhatsappShare.shareFile(
      phone: phone.toString(),
      filePath: [_invitation],
    );
  }
}

class Users {
  final String phone;
  final String name;

  Users({required this.phone, required this.name});
}
