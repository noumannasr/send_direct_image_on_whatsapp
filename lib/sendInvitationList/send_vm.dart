import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:whatsapp/whatsapp.dart';
import 'package:http/http.dart' as http;

// import 'package:whatsapp_share/whatsapp_share.dart';

class SendInvitation extends ChangeNotifier {
  WhatsApp whatsapp = WhatsApp();
  List<Users> users = [
    Users(phone: '923314257676', name: 'Nouman'),
    Users(phone: '923345456942', name: 'Arslan'),
  ];
  String _invitation = '';
  int phoneNumber = 237572706102285;
  String accessToken =
      'EAAEnp6AvdP0BO2lnHXVFkBLqwCLm0eUwxOwe2GZBsYH2y3khwZBx117Ns0ItNnSrH4WS4pnpOiiRfVVJGaERFIN6H56kGruKt7MD2o3GH0gmsayXq3ZAZBCM8JZBZAFRDN2B8lOlXbN71sMIIYuGdZBfaimDnN5qUG9Pvns143dXMBPM5NtT9moZCW58eS4cUglEljqIFYwyrzdUJmdZCxUQZD';
  Map headers = {};

  String get invitation => _invitation;

  SendInvitation() {
    print('we are in setup');
    whatsapp.setup(accessToken: accessToken, fromNumberId: phoneNumber);
  }

  setup({accessToken, int? fromNumberId}) {
    // _accessToken = accessToken;
    // _fromNumberId = fromNumberId;
    headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };
  }

  Future messagesTemplate({int? to, String? templateName}) async {
    var url = 'https://graph.facebook.com/v14.0/$phoneNumber/messages';
    Uri uri = Uri.parse(url);

    Map data = {
      "messaging_product": "whatsapp",
      "to": 923314257676,
      "type": "template",
      "template": {
        "name": "hello_world",
        "language": {"code": "en_US"}
      }
    };

    var body = json.encode(data);

    var response = await http.post(uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
        body: body);
    try {
      print("we are in try " + response.body.toString());

      return json.decode(response.body);
    } catch (e) {
      print("we are in error " + e.toString());
      print(e.toString());
      return response.body;
    }
  }

  Future messagesText({
    int? to,
    String? message,
    bool? previewUrl,
  }) async {
    var url = 'https://graph.facebook.com/v14.0/$phoneNumber/messages';
    Uri uri = Uri.parse(url);

    Map data = {
      "messaging_product": "whatsapp",
      "to": 923314257676,
      "type": "text",
      "text": {"preview_url": "", "body": "how are you?"}
    };

    var body = json.encode(data);

    var response = await http.post(uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
        body: body);
    try {
      print("we are in try " + response.body.toString());

      return json.decode(response.body);
    } catch (e) {
      print("we are in error " + e.toString());

      return response.body;
    }
  }

  // sendMessageNow() async {
  //   curl -i -X POST `
  //   https://graph.facebook.com/v18.0/237572706102285/messages `
  //   -H 'Authorization: Bearer EAAEnp6AvdP0BO2lnHXVFkBLqwCLm0eUwxOwe2GZBsYH2y3khwZBx117Ns0ItNnSrH4WS4pnpOiiRfVVJGaERFIN6H56kGruKt7MD2o3GH0gmsayXq3ZAZBCM8JZBZAFRDN2B8lOlXbN71sMIIYuGdZBfaimDnN5qUG9Pvns143dXMBPM5NtT9moZCW58eS4cUglEljqIFYwyrzdUJmdZCxUQZD' `
  //   -H 'Content-Type: application/json' `
  //   -d '{ \"messaging_product\": \"whatsapp\", \"to\": \"923314257676\", \"type\": \"template\", \"template\": { \"name\": \"hello_world\", \"language\": { \"code\": \"en_US\" } } }'
  // }

  setInvitaion(String invi) {
    _invitation = invi;
    log("localPath is null ${_invitation}");
    notifyListeners();
  }

//.messagesTemplate(to: 923314257676, templateName: "hello_world")
  sendMessageNow() async {
    try {
      await whatsapp
          .messagesMediaByLink(
        to: 923314257676,
        mediaType: "image",
        mediaLink:
            "https://mastimorning.com/wp-content/uploads/2023/07/cool-whatsapp-dp-Photo-Download-Free.jpg",
      )
          .then((value) {
        print("set now $value");
      }).catchError((e) {
        print("e hello_world sent");
        print(e.toString());
      });
      //whatsapp.short(to: 923314257676, message: "Hey", compress: true);
    } catch (e) {
      print("error ${e.toString()}");
    }
    //     .then((value) {
    //   print("hello_world sent thenn");
    // }).catchError((e) {
    //   print("e hello_world sent");
    //   print(e.toString());
    // });
  }

  Future<void> shareScreenShot(String phone) async {
    print("we are here shareScreenShot");
    sendMessageNow();
    // await whatsapp
    //     .messagesTemplate(to: 923314257676, templateName: "hello_world")
    //     .then((value) {
    //   print("hello_world sent thenn");
    // }).catchError((e) {
    //   print("e hello_world sent");
    //   print(e.toString());
    // });
    // whatsapp.messagesTemplate(to: 923314257676, templateName: "hello_world");

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

    // await WhatsappShare.shareFile(
    //   phone: phone.toString(),
    //   filePath: [_invitation],
    // );
  }
}

class Users {
  final String phone;
  final String name;

  Users({required this.phone, required this.name});
}
