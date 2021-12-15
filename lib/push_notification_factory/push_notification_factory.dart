import 'package:flutter_local_notification/push_notification_factory/strategy/i_push_strategy.dart';
import 'package:flutter_local_notification/push_notification_factory/strategy/teste1_strategy.dart';

import 'strategy/teste2_strategy.dart';

class PushNotificationFactory{
  Map<String, dynamic> payload;
  late IPushStrategy strategy;

  PushNotificationFactory.create(this.payload){
    switch(payload['algo']){
      case '123':
        strategy = Teste1Strategy();
        break;
      case '1234':
        strategy = Teste2Strategy();
        break;
      default:
        throw Exception("Notificação inexistente");
    }
  }

  void execute(){
    strategy.execute(payload);
  }

}