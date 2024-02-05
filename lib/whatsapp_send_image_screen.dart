import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:testing_whatsapp_invitaion/sendInvitationList/send_vm.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

class WhatsAppSendImageScreen extends StatefulWidget {
  const WhatsAppSendImageScreen({super.key});

  @override
  State<WhatsAppSendImageScreen> createState() =>
      _WhatsAppSendImageScreenState();
}

class _WhatsAppSendImageScreenState extends State<WhatsAppSendImageScreen> {
  final _controller = ScreenshotController();
  File? _image;

  Future<void> share() async {
    await WhatsappShare.share(
      text: 'Example share text',
      linkUrl: 'https://flutter.dev/',
      phone: '923314257676',
    );
  }

  Future<void> shareFile() async {
    await getImage();
    Directory? directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }
    // debugPrint('${directory?.path} / ${_image?.path}');

    await WhatsappShare.shareFile(
      phone: '923314257676',
      filePath: ["${_image?.path}"],
    );
  }

  Future<void> isInstalled() async {
    final val = await WhatsappShare.isInstalled(package: Package.whatsapp);
    debugPrint('Whatsapp is installed: $val');
  }

  Future<void> shareScreenShot() async {
    final sendVm = Provider.of<SendInvitation>(context, listen: false);
    Directory? directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    final String? localPath = await _controller.captureAndSave(directory!.path);

    await Future.delayed(const Duration(seconds: 1));
    if (localPath == null) {
      log("localPath is null");
    }

    sendVm.setInvitaion(localPath!);

    Fluttertoast.showToast(
        msg: "ScreenShot Captured",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    Navigator.of(context).pop();

    // await WhatsappShare.shareFile(
    //   phone: '923314257676',
    //   filePath: [localPath!],
    // );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Consumer<SendInvitation>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Whatsapp Share'),
            ),
            body: Center(
              child: Screenshot(
                controller: _controller,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Working in flutter 3.16.0',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: share,
                      child: const Text('Share text and link'),
                    ),
                    ElevatedButton(
                      onPressed: shareFile,
                      child: const Text('Share Image'),
                    ),
                    ElevatedButton(
                      onPressed: shareScreenShot,
                      child: const Text('Take screenshot'),
                    ),
                    ElevatedButton(
                      onPressed: isInstalled,
                      child: const Text('is Installed'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  ///Pick Image From gallery using image_picker plugin
  Future getImage() async {
    try {
      XFile? pickedFile =
          // ignore: deprecated_member_use
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {}
    } catch (er) {
      log(er.toString());
    }
  }
}
