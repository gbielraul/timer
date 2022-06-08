import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/global/common/notification_service.dart';
import 'package:timer/global/common/routes.dart';

void main() {
  runApp(
    // Provides the NotificationService
    MultiProvider(
    providers: [
      Provider<NotificationService>(create: (context) => NotificationService())
    ],
    child: const MyApp(),
  ));
}

// Root class
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Disable debug banner
      debugShowCheckedModeBanner: false,
      title: 'Timer',
      // App theme
      theme: ThemeData(
        // Turn on Material 3
        useMaterial3: true,
        // Set the app font family to Shree Devanagari
        fontFamily: 'Shree Devanagari',
      ),
      // The page routes of the app
      routes: Routes.list,
      // The initial page from routes
      initialRoute: Routes.initial,
      // The routes NavigatorKey
      navigatorKey: Routes.navigatorKey,
    );
  }
}
