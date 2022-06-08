import 'package:flutter/material.dart';
import 'package:timer/pages/timer_page.dart';

/// The Application routes class.
class Routes {
  /// The list of routes.
  static Map<String, Widget Function(BuildContext)> list =

      <String, WidgetBuilder>{
    '/timer': (_) => const TimerPage(),
  };

  /// The initial route.
  static String initial = '/timer';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
