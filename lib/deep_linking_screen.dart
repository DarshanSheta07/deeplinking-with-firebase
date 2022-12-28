import 'package:flutter/material.dart';

class DeepLinkingScreen extends StatelessWidget {
  String? deepLinkingText;
  DeepLinkingScreen({Key? key, this.deepLinkingText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(deepLinkingText ?? '') ,),
    );
  }
}
