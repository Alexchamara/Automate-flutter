import 'package:flutter/material.dart';

class MyMessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Messages'),
      ),
      body: Center(
        child: Text('My Messages Page'),
      ),
    );
  }
}