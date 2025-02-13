import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Q_drug_model/model.dart';
import 'ScheduleNotification.dart';

class SelectFrequencyDetails extends StatefulWidget {
  final Drug drug;
  final String frequencyType;

  const SelectFrequencyDetails(
      {Key? key, required this.drug, required this.frequencyType})
      : super(key: key);

  @override
  State<SelectFrequencyDetails> createState() => _SelectFrequencyDetailsState();
}

class _SelectFrequencyDetailsState extends State<SelectFrequencyDetails> {
  List<int> selectedDays = []; // 🆕 เปลี่ยนเป็น List<int> แทนชื่อวัน
  int? everyXDays;
  int? everyXWeeks;
  final Map<String, int> weekDaysMap = {
    "Sunday": 7,
    "Monday": 1,
    "Tuesday": 2,
    "Wednesday": 3,
    "Thursday": 4,
    "Friday": 5,
    "Saturday": 6
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select ${widget.frequencyType}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.frequencyType == "Specific days of the week")
              _buildDaySelector(),
            if (widget.frequencyType == "Every X days") _buildXDaysSelector(),
            if (widget.frequencyType == "Every X weeks") _buildXWeeksSelector(),
            const SizedBox(height: 20),

            // ✅ ปุ่มบันทึกค่าที่เลือก
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (widget.frequencyType == "Specific days of the week" &&
                      selectedDays.isNotEmpty) {
                    widget.drug.selectedDays =
                        selectedDays; // 🆕 บันทึกค่าเป็นตัวเลข
                  } else if (widget.frequencyType == "Every X days" &&
                      everyXDays != null) {
                    widget.drug.intervalDays = everyXDays;
                  } else if (widget.frequencyType == "Every X weeks" &&
                      everyXWeeks != null) {
                    widget.drug.intervalDays =
                        everyXWeeks! * 7; // 🆕 คูณ 7 เพื่อให้เป็นวัน
                  } else {
                    Get.snackbar("Error", "Please select an option",
                        backgroundColor: Colors.red, colorText: Colors.white);
                    return;
                  }
                  print(
                      "📅 Selected Days in Drug Model: ${widget.drug.selectedDays}");
                  print(
                      "⏳ Interval Days in Drug Model: ${widget.drug.intervalDays}");
                  // ✅ ส่งข้อมูลไปหน้า ScheduleNotification
                  Get.to(() => ScheduleNotification(drug: widget.drug));
                },
                child: const Text("Confirm & Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ **เลือกวันในสัปดาห์**
  Widget _buildDaySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Select the days you take this medication:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Wrap(
          children: weekDaysMap.keys.map((day) {
            return ChoiceChip(
              label: Text(day),
              selected: selectedDays.contains(weekDaysMap[day]),
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    selectedDays.add(weekDaysMap[day]!);
                  } else {
                    selectedDays.remove(weekDaysMap[day]!);
                  }

                  // ✅ บันทึกค่าลงใน drug model ทันที
                  widget.drug.selectedDays = List.from(selectedDays);

                  // ✅ Debug ตรวจสอบค่าที่บันทึก
                  print("📌 Selected Days: ${widget.drug.selectedDays}");
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  /// ✅ **เลือก "ทุก X วัน"**
  Widget _buildXDaysSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("How many days apart do you take it?",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        DropdownButton<int>(
          value: everyXDays,
          items: List.generate(30, (index) => index + 1).map((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text("Every $value days"),
            );
          }).toList(),
          onChanged: (int? newValue) {
            setState(() {
              everyXDays = newValue;
            });
          },
        ),
      ],
    );
  }

  /// ✅ **เลือก "ทุก X สัปดาห์"**
  Widget _buildXWeeksSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("How many weeks apart do you take it?",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        DropdownButton<int>(
          value: everyXWeeks,
          items: List.generate(12, (index) => index + 1).map((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text("Every $value weeks"),
            );
          }).toList(),
          onChanged: (int? newValue) {
            setState(() {
              everyXWeeks = newValue;
            });
          },
        ),
      ],
    );
  }
}
