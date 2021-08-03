import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  static String second_screen = '/SecondScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(''),
          ],
        ),
      ),
    );
  }
}
