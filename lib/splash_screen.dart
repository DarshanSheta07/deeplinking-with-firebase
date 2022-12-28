import 'dart:developer';

import 'package:deep_linking/deep_linking_screen.dart';
import 'package:deep_linking/home_screen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getToNextRoute();
    retrieveDynamicLink();
  }

  void _getToNextRoute() async {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          HomeScreen()), (Route<dynamic> route) => false);
    });
  }

  Future<void> retrieveDynamicLink() async {
    try {
      final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
      log("data :${data}");
      final Uri? deepLink = data?.link;
      log("deepLink :${deepLink}");
      if (deepLink != null) {
        var meetingId = deepLink.queryParameters['getHome'];
        // var chatroomId = deepLink.queryParameters['chatroom'];
        if (meetingId?.isNotEmpty ?? false) {
          print('referralCode : $meetingId');
        }
      }

      FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
        log("dynamicLinkData :${dynamicLinkData.link}");
        var isReferralCode = dynamicLinkData.link.query.contains('getHome');
        // var isChatRoomId = dynamicLinkData.link.query.contains('chatroomId=');
        if (isReferralCode) {
          var getQuery = dynamicLinkData.link.query;
          var getData = getQuery.split('getHome=');
          print('getReferralCode $getData');
          if (getData.isNotEmpty) {
            print('getMeetingId: ${getData[1]}');
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DeepLinkingScreen(
                        deepLinkingText: getData[1],
                      )),
            );
          }
        }
      }).onError((error) {});
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
