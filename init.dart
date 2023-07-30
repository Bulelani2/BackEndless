/**
 * This code initializes the Backendless SDK and checks if the user is logged in.
 * If the user is logged in, it will get the reflections and navigate to the reflection page.
 * If the user is not logged in, it will navigate to the login page.
 */
// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:reflections_app/routes/routes.dart';
import 'package:reflections_app/service/reflection_service.dart';
import 'package:reflections_app/service/user_service.dart';
//import 'models/reflection_model.dart';

class InitApp {
  static const String apiKeyAndroid = '';
  static const String apiKeyiOS = '';
  static const String appID = '';

  static void initializeApp(BuildContext context) async {
    await Backendless.initApp(
        applicationId: appID,
        iosApiKey: apiKeyiOS,
        androidApiKey: apiKeyAndroid);
    String result = await context.read<UserService>().checkIfUserLoggedIn();
    if (result == 'OK') {
      context
          .read<ReflectionService>()
          .getReflections(context.read<UserService>().currentUser!.email);
      Navigator.popAndPushNamed(context, RouteManager.reflectionPage);
    } else {
      Navigator.popAndPushNamed(context, RouteManager.loginPage);
    }
  }
}
