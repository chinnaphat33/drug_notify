import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final String timeZoneName = "Asia/Bangkok";

  static Future<void> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

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

    print("✅ Notification Service Initialized!");
  }

  /// ✅ ฟังก์ชันแจ้งเตือนปกติ (ครั้งเดียว)
  static Future<void> scheduleNotification(
      int hour, int minute, String drugName) async {
    final tz.TZDateTime scheduledDate = _nextInstanceOfTime(hour, minute);

    final int notificationId =
        DateTime.now().millisecondsSinceEpoch.remainder(100000);
    print("🔔 Scheduling Notification for $drugName at $hour:$minute");
    print("📅 Scheduled Notification Time: $scheduledDate");

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

  /// ✅ ฟังก์ชันแจ้งเตือนแบบซ้ำทุกวัน (สำหรับยาแบบ `Every day`)
  static Future<void> scheduleDailyNotification(
      int hour, int minute, String drugName) async {
    final int notificationId =
        DateTime.now().millisecondsSinceEpoch.remainder(100000);

    await _notificationsPlugin.zonedSchedule(
      notificationId,
      "Daily Reminder",
      "Take your $drugName now",
      _nextInstanceOfTime(hour, minute),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_channel',
          'Daily Medication Reminders',
          channelDescription: 'Reminds you to take your medicine daily',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          threadIdentifier: 'daily_reminder',
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );

    print("✅ Daily Notification Scheduled!");
  }

  /// ✅ ฟังก์ชันแจ้งเตือนเฉพาะวันที่เลือก (`Specific days of the week`)
  static Future<void> scheduleWeeklyNotification(
      int hour, int minute, List<int> days, String drugName) async {
    for (var day in days) {
      final tz.TZDateTime scheduledDate = _nextInstanceOfWeekday(hour, minute, day);

      final int notificationId =
          DateTime.now().millisecondsSinceEpoch.remainder(100000) + day;

      await _notificationsPlugin.zonedSchedule(
        notificationId,
        "Weekly Reminder",
        "Take your $drugName on ${_weekdayName(day)}",
        scheduledDate,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'weekly_channel',
            'Weekly Medication Reminders',
            channelDescription: 'Reminds you to take your medicine on selected days',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            threadIdentifier: 'weekly_reminder',
          ),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );

      print("✅ Weekly Notification Scheduled for ${_weekdayName(day)}!");
    }
  }

  /// ✅ ฟังก์ชันแจ้งเตือนทุก X วัน (`Every X days`)
  static Future<void> scheduleEveryXDaysNotification(
      int hour, int minute, int intervalDays, String drugName) async {
    final tz.TZDateTime scheduledDate =
        _nextInstanceOfTime(hour, minute).add(Duration(days: intervalDays));

    final int notificationId =
        DateTime.now().millisecondsSinceEpoch.remainder(100000);

    await _notificationsPlugin.periodicallyShow(
      notificationId,
      "Every $intervalDays Days Reminder",
      "Take your $drugName today",
      RepeatInterval.daily,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'every_x_days_channel',
          'Every X Days Medication Reminders',
          channelDescription: 'Reminds you to take your medicine every $intervalDays days',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        ),
      ),
      androidAllowWhileIdle: true,
    );

    print("✅ Every $intervalDays Days Notification Scheduled!");
  }

  static tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.Location location = tz.getLocation(timeZoneName);
    final tz.TZDateTime now = tz.TZDateTime.now(location);

    tz.TZDateTime scheduledDate =
        tz.TZDateTime(location, now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    print("📌 Current Timezone: $timeZoneName");
    print("📅 Scheduled Notification Time: $scheduledDate");

    return scheduledDate;
  }

  static tz.TZDateTime _nextInstanceOfWeekday(int hour, int minute, int weekday) {
    final tz.Location location = tz.getLocation(timeZoneName);
    final tz.TZDateTime now = tz.TZDateTime.now(location);
    
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(location, now.year, now.month, now.day, hour, minute);

    while (scheduledDate.weekday != weekday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  static String _weekdayName(int weekday) {
    List<String> weekdays = [
      "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
    ];
    return weekdays[weekday - 1];
  }

  static Future<void> checkPendingNotifications() async {
    final pendingNotifications =
        await _notificationsPlugin.pendingNotificationRequests();
    print("🔎 Pending Notifications: ${pendingNotifications.length}");
  }
}
