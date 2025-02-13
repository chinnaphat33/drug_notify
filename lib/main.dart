import 'dart:ui';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pill_reminder/Screens/Categories_Screen.dart';
import 'package:pill_reminder/Screens/home_Screen.dart';
import 'package:pill_reminder/Screens/login_Screen.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:pill_reminder/Controllers/ medication_controller.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(MedicationController());
  // โหลด timezone database
  tz.initializeTimeZones();

  // ดึงค่า timezone ของอุปกรณ์
  String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  print("📌 Detected Timezone: $timeZoneName");

  // กำหนดค่าโซนเวลาให้ตรงกับอุปกรณ์
  tz.setLocalLocation(tz.getLocation(timeZoneName));

  print("📌 Fixed Timezone: ${tz.local.name}");
  print("🕒 Current Local Time: ${tz.TZDateTime.now(tz.local)}");
  HttpOverrides.global = MyHttpOverrides();
  await NotificationService.init();
  runApp(const MyApp());
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void requestNotificationPermissions() async {
  final bool? result = await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(alert: true, badge: true, sound: true);

  print("Notification permission granted: $result");
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
