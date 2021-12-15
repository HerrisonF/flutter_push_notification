import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notification/local_notify_manager.dart';
import 'package:flutter_local_notification/secondPage.dart';
import 'ThirdPage.dart';
import 'firebase_options.dart';

import 'home_page.dart';
import 'navigationService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  //tina que ficar aqui fora, antes de qualquer inicialização
  FirebaseMessaging.onBackgroundMessage(
      LocalNotifyManager.firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.instance.navigationKey,
      initialRoute: 'initial',
      routes: {
        'initial': (context) => HomePage(),
        'second': (context) => SecondPage(),
        'third': (context) => ThirdPage()
      },
    );
  }
}
