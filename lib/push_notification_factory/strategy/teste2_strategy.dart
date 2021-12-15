import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notification/push_notification_factory/strategy/i_push_strategy.dart';

import '../../navigationService.dart';

class Teste2Strategy implements IPushStrategy {
  @override
  void execute(Map<String, dynamic> pushPayload) {
    NavigationService.instance.navigateTo("third", pushPayload);
  }

}