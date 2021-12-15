import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notification/push_notification_factory/push_notification_factory.dart';
import 'local_notify_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String? token = "";

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    localNotifyManager.setTokenOnReceiveToken(onReceiveToken);
    localNotifyManager.setOnNotificationReceive(onNotificationReceive);
    localNotifyManager.setOnNotificationClick(onNotificationClick);
  }

  onNotificationReceive(ReceivedNotification notification) {
    //NavigationService.instance.navigateTo("second");
  }

  onReceiveToken(String token){
    setState(() {
      this.token = token;
      _controller.text = token;
    });
  }

  onNotificationClick(String message) {
    final teste = json.decode(message);
    PushNotificationFactory.create(teste)..execute();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                await localNotifyManager.showNotification();
              },
              child: Text("Notificar"),
            ),
            Container(
              child: TextField(
                controller: _controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
