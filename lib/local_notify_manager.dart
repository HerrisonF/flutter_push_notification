import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notification/push_notification_factory/push_notification_factory.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

import 'navigationService.dart';

class LocalNotifyManager {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();


  BehaviorSubject<ReceivedNotification>
      get didReceiveLocalNotificationSubject =>
          BehaviorSubject<ReceivedNotification>();

  var initSetting;

  LocalNotifyManager.init() {
    initializeFirebaseListeners();
    initializePlatform();
  }

  initializeFirebaseListeners() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _processMessage(message);
    });
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if(message!= null) {
        PushNotificationFactory.create(jsonDecode(jsonEncode({"title":"titulo","algo":"1234"})))..execute();
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        NavigationService.instance.navigateTo("second", jsonDecode(jsonEncode({"title":"titulo","algo":"123"}).toString()));
    });
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  setTokenOnReceiveToken(Function onReceiveToken) async{
    onReceiveToken(await FirebaseMessaging.instance.getToken());
  }

  ////cadastro do canal////
  static const androidChannelBack = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
    //icon: 'images/icon_launcher.png',
  );

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    var teste = FlutterLocalNotificationsPlugin();
    teste.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(androidChannelBack);

  }
  ////cadastro do canal////

  initializePlatform() {
    var initSettingAndroid = AndroidInitializationSettings('notification_icon');
    initSetting = InitializationSettings(android: initSettingAndroid);
  }

  static _processMessage(RemoteMessage message) {
    _flutterLocalNotificationShow(message);
  }

  static _flutterLocalNotificationShow(RemoteMessage message) async {
    //tocar o som, ou pelo método, ou pelo atributo, caso dê certo
    const androidChannel = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      channelDescription: 'CHANNEL_DESCRIPTION',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      //icon: 'images/icon_launcher.png',
    );
    var platformChannel = const NotificationDetails(android: androidChannel);
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification!.title ?? "",
      message.notification!.body ?? "",
      platformChannel,
      payload: jsonEncode(message.data),
    );
  }

  setOnNotificationReceive(Function onNotificationReceive) {
    didReceiveLocalNotificationSubject.listen((notification) {
      onNotificationReceive(notification);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification: (payload) async {
      onNotificationClick(payload);
    });
  }

  Future<void> showNotification() async {
    const androidChannel = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      channelDescription: 'CHANNEL_DESCRIPTION',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      //icon: 'images/icon_launcher.png',
    );
    var platformChannel = const NotificationDetails(android: androidChannel);
    await flutterLocalNotificationsPlugin.show(
      0,
      "TESTE CLICK",
      "CLICOU",
      platformChannel,
      payload: jsonEncode({"title":"titulo","algo":"1234"}).toString(),
    );
  }
}

LocalNotifyManager localNotifyManager = LocalNotifyManager.init();

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification(
      {required this.id,
      required this.title,
      required this.body,
      required this.payload});
}
