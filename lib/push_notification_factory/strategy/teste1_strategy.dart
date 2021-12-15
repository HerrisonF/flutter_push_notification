import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notification/push_notification_factory/strategy/i_push_strategy.dart';

import '../../navigationService.dart';

class Teste1Strategy implements IPushStrategy{
  @override
  void execute(Map<String, dynamic> pushPayload) {
    //Navigate
    NavigationService.instance.navigateTo("second",pushPayload);
  }

}