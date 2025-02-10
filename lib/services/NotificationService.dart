import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print("🔔 Notification Clicked: ${response.payload}");
      },
    );
  }

  static Future<void> scheduleNotification(
      int hour, int minute, String drugName) async {
    final tz.TZDateTime scheduledDate = _nextInstanceOfTime(hour, minute);

    final int notificationId =
        DateTime.now().millisecondsSinceEpoch.remainder(100000);
    print("🔔 Scheduling Notification for $drugName at $hour:$minute");
    // print(
    //     "🕒 Scheduled DateTime: $scheduledDate (Now: ${tz.TZDateTime.now(tz.local)})");
    // print("📌 Current Timezone: ${tz.local.name}");
    // print("🕒 Current Local Time: ${tz.TZDateTime.now(tz.local)}");

    await _notificationsPlugin.zonedSchedule(
      notificationId,
      "Reminder",
      "Take your $drugName now",
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'medication_channel',
          'Medication Reminders',
          channelDescription: 'Reminds you to take your medicine',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          threadIdentifier: 'reminder_notifications',
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );

    print("✅ Notification Scheduled Successfully!");


    await checkPendingNotifications();
  }

static tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    tz.initializeTimeZones(); 

    final String timeZoneName = "Asia/Bangkok"; // 🕒 กำหนดตรงนี้ไปเลย
    final tz.Location location = tz.getLocation(timeZoneName); // ✅ ดึง Location

    final tz.TZDateTime now = tz.TZDateTime.now(location); // ✅ ใช้ location

    tz.TZDateTime scheduledDate =
        tz.TZDateTime(location, now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    print("📌 Current Timezone: $timeZoneName");
    print("🕒 Current Local Time: ${tz.TZDateTime.now(location)}");
    print("📅 Scheduled Notification Time: $scheduledDate");

    return scheduledDate;
}


  // ตรวจสอบรายการแจ้งเตือนที่ถูกตั้งค่าไว้ทั้งหมด
  static Future<void> checkPendingNotifications() async {
    final pendingNotifications =
        await _notificationsPlugin.pendingNotificationRequests();
    print("🔎 Pending Notifications: ${pendingNotifications.length}");
  }
}
