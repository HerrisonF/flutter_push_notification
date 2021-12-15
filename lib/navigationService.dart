import 'package:flutter/material.dart';

class NavigationService{
  late GlobalKey<NavigatorState> navigationKey;

  static NavigationService instance = NavigationService();

  NavigationService(){
    navigationKey = GlobalKey<NavigatorState>();
  }

  Future<dynamic> navigateToReplacement(String _rn, Map<String, dynamic> payload){
    return navigationKey.currentState!.pushReplacementNamed(_rn, arguments: payload);
  }
  Future<dynamic> navigateTo(String _rn, Map<String, dynamic> payload){
    return navigationKey.currentState!.pushNamed(_rn, arguments: payload);
  }
  Future<dynamic> navigateToRoute(MaterialPageRoute _rn){
    return navigationKey.currentState!.push(_rn);
  }

  goback(){
    return navigationKey.currentState!.pop();

  }
}