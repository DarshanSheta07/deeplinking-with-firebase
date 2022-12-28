import 'package:deep_linking/utils/dynamicLinksClass.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            CreateDynamicLinks().createDynamicLink('Darshan Sheta');
          },
          child: Text('HomeScreen'),
        ),
      ),
    );
  }
}
