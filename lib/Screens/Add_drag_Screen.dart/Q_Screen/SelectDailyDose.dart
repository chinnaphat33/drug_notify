import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Q_drug_model/model.dart';
import 'package:pill_reminder/Screens/Add_drag_Screen.dart/Q_Screen/ScheduleNotification.dart';

class SelectDailyDose extends StatefulWidget {
  final Drug drug;

  const SelectDailyDose({Key? key, required this.drug}) : super(key: key);

  @override
  State<SelectDailyDose> createState() => _SelectDailyDoseState();
}

class _SelectDailyDoseState extends State<SelectDailyDose> {
  List<String> dailyDoseOptions = [
    "Once a day",
    "Twice a day",
    "3 times a day",
    "More than 3 times a day",
    "Every X hours"
  ];

  String? selectedDose;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Daily Dose")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "How often do you take it in a day?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: dailyDoseOptions.length,
                separatorBuilder: (context, index) => const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(dailyDoseOptions[index]),
                    trailing: selectedDose == dailyDoseOptions[index]
                        ? const Icon(Icons.check, color: Colors.blue)
                        : null,
                    onTap: () {
                      setState(() {
                        selectedDose = dailyDoseOptions[index];
                      });

                      widget.drug.dosagePerDay =
                          _mapDoseToNumber(selectedDose!);

                      debugPrint(
                          'Drug Daily Dose (for debug): ${widget.drug.dosagePerDay}');

                      if (selectedDose == "Once a day") {
                        Future.delayed(Duration(milliseconds: 200), () {
                          Get.to(() => ScheduleNotification(drug: widget.drug));
                        });
                      } else {
                        Get.back(result: widget.drug);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _mapDoseToNumber(String dose) {
    switch (dose) {
      case "Once a day":
        return 1;
      case "Twice a day":
        return 2;
      case "3 times a day":
        return 3;
      case "More than 3 times a day":
        return 4;
      case "Every X hours":
        return 5;
      default:
        return 0;
    }
  }
}
