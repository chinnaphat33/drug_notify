import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pill_reminder/services/NotificationService.dart';
import '../Q_drug_model/model.dart';
import 'package:pill_reminder/Screens/home_Screen.dart';
import 'package:pill_reminder/Controllers/ medication_controller.dart';

class ScheduleNotification extends StatefulWidget {
  final Drug drug;

  const ScheduleNotification({Key? key, required this.drug}) : super(key: key);

  @override
  State<ScheduleNotification> createState() => _ScheduleNotificationState();
}

class _ScheduleNotificationState extends State<ScheduleNotification> {
  TimeOfDay selectedTime = TimeOfDay.now();
  List<String> selectedTimes = []; //
  final MedicationController medicationController =
      Get.find<MedicationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Set Medication Time")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select times for your reminders:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // แสดงรายการเวลาที่เลือก
            if (selectedTimes.isNotEmpty)
              Column(
                children: selectedTimes
                    .map((time) => ListTile(
                          title: Text(time),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                selectedTimes.remove(time);
                              });
                            },
                          ),
                        ))
                    .toList(),
              ),

            const SizedBox(height: 10),

            // ปุ่มเลือกเวลา
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                    helpText: "Select Time", // เปลี่ยนข้อความ Title ของ Dialog
                    initialEntryMode:
                        TimePickerEntryMode.input, // เริ่มต้นที่ Numeric Input
                    builder: (BuildContext context, Widget? child) {
                      return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: true),
                        child: child!,
                      );
                    },
                  );

                  if (pickedTime != null) {
                    setState(() {
                      selectedTime = pickedTime;
                      String formattedTime =
                          "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}";
                      if (!selectedTimes.contains(formattedTime)) {
                        selectedTimes.add(formattedTime);
                      }
                    });
                  }
                },
                child: const Text("Pick Time"),
              ),
            ),

            const SizedBox(height: 20),

            // ปุ่มบันทึกการแจ้งเตือน
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedTimes.isNotEmpty) {
                    widget.drug.times = selectedTimes;
                    medicationController.addMedication(widget.drug);
                    medicationController.saveMedications(); // บันทึกข้อมูล

                    for (String time in selectedTimes) {
                      List<String> splitTime = time.split(":");
                      int hour = int.parse(splitTime[0]);
                      int minute = int.parse(splitTime[1]);

                      // 🔥 **เรียกใช้ฟังก์ชันแจ้งเตือนตามประเภทความถี่ที่เลือก**
                      if (widget.drug.frequencydose == "Every day") {
                        NotificationService.scheduleDailyNotification(
                            hour, minute, widget.drug.name ?? "your medicine");
                      } else if (widget.drug.frequencydose ==
                              "Specific days of the week" &&
                          widget.drug.selectedDays != null) {
                        NotificationService.scheduleWeeklyNotification(
                            hour,
                            minute,
                            widget.drug.selectedDays!,
                            widget.drug.name ?? "your medicine");
                      } else if (widget.drug.frequencydose == "Every X days" &&
                          widget.drug.intervalDays != null) {
                        NotificationService.scheduleEveryXDaysNotification(
                            hour,
                            minute,
                            widget.drug.intervalDays!,
                            widget.drug.name ?? "your medicine");
                      } else {
                        // ถ้าไม่มีเงื่อนไขพิเศษ ให้แจ้งเตือนครั้งเดียว
                        NotificationService.scheduleNotification(
                            hour, minute, widget.drug.name ?? "your medicine");
                      }
                    }

                    debugPrint(
                        'Drug Frequency (for debug): ${widget.drug.times}');
                    Get.off(() => HomePage(), arguments: widget.drug);
                  } else {
                    Get.snackbar(
                      "Error",
                      "Please select at least one time!",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                child: const Text("Confirm & Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
