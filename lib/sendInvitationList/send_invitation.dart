import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_whatsapp_invitaion/sendInvitationList/send_vm.dart';
import 'package:testing_whatsapp_invitaion/whatsapp_send_image_screen.dart';

class SendInvitationScreen extends StatefulWidget {
  const SendInvitationScreen({super.key});

  @override
  State<SendInvitationScreen> createState() => _SendInvitationScreenState();
}

class _SendInvitationScreenState extends State<SendInvitationScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SendInvitation>(
      builder: (context, provider, child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WhatsAppSendImageScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Capture ScreenShot'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: provider.users.length,
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    final item = provider.users[index];
                    return Container(
                      color: Colors.amberAccent.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item.name.toString()),
                            Text(item.phone.toString()),
                            GestureDetector(
                              onTap: () {
                                provider.shareScreenShot(item.phone.toString());
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Colors.blue,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text('Send'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        );
      },
    );
  }
}
