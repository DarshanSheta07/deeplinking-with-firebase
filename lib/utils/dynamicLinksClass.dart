import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class CreateDynamicLinks {
  Future<String> createDynamicLink(String getData) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://sheta.page.link',
      link: Uri.parse('https://firebaseauth.com?getHome=$getData'),
      androidParameters: const AndroidParameters(
        packageName: 'com.firebaseauth.firebaseauth',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.freibr',
        minimumVersion: '1',
        // appStoreId: '1608481261',
      ),
    );

    final link = await FirebaseDynamicLinks.instance.buildLink(parameters);
    final unguessableDynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(
      parameters,
      shortLinkType: ShortDynamicLinkType.unguessable,
    );
    log('dynamicUrl : unguessableDynamicLink :${unguessableDynamicLink.shortUrl}');
    log('dynamicUrl link :$link');
    String appUrl = link.toString();
    String decodeUrl = Uri.decodeFull(appUrl);
    return decodeUrl;
  }
}
