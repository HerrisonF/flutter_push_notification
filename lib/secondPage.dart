import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  //final String? payload;

  SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      body: Container(child: Text('Segunda página - ${args}')),
    );
  }
}
