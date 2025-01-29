import 'package:flutter/material.dart';

import 'package:pill_reminder/Screens/Categories_Screen.dart';
import 'package:pill_reminder/Screens/home_Screen.dart';
import 'package:pill_reminder/Screens/login_Screen.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:pill_reminder/Screens/register_Screen.dart';
import 'package:pill_reminder/services/NotificationService.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pill_reminder/Screens/Add_drag_Screen.dart/Q_drug_model/model.dart'; // Import Drug model
import 'package:get/get.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized(); 

  tz.initializeTimeZones(); 
  
  NotificationService.init();
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        supportedLocales: [
          Locale('en', 'US'), // English, no country code
        ],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: HomePage(),
        routes: {
          'register': (context) => Register(),
          'home': (context) => HomePage(),
          'login': (context) => login(),
          'categories': (context) => Categories(),
        });
  }
}
