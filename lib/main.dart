import 'package:flutter/material.dart';
import 'package:pill_reminder/Screens/Categories_Screen.dart';
import 'package:pill_reminder/Screens/home_Screen.dart';
import 'package:pill_reminder/Screens/login_Screen.dart';
import 'package:pill_reminder/Screens/register_Screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
  HttpOverrides.global = new MyHttpOverrides();
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
      home: Register(),
      routes: {
        'register': (context) => Register(),
        'home': (context) => HomePage(),
        'login': (context) => login(),
        'categories': (context) => Categories(),
      }
    );
  }
}


