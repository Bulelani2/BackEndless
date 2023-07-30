/**
 * This code is the main function of a Flutter app.
 * It creates a MultiProvider to provide services to the app, such as UserService, ReflectionViewModel, and ReflectionService.
 * It also sets the initial route of the app to the loading page and sets the route generator.
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reflections_app/liftecycle.dart';
import 'package:reflections_app/models/reflection_model.dart';
import 'package:reflections_app/routes/routes.dart';
import 'package:reflections_app/service/reflection_service.dart';
import 'package:reflections_app/service/user_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserService(),
        ),
        ChangeNotifierProvider(
          create: (context) => ReflectionViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ReflectionService(),
        )
      ],
      child: const LifeCycle(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RouteManager.loadingPage,
          onGenerateRoute: RouteManager.generateRoute,
        ),
      ),
    );
  }
}
