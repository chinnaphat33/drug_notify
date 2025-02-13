import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Q_drug_model/model.dart';
import 'package:pill_reminder/Screens/Add_drag_Screen.dart/Q_Screen/SelectDailyDose.dart';
import 'package:pill_reminder/Screens/Add_drag_Screen.dart/Q_Screen/SelectFrequencyDetails.dart';

class SelectDoseFrequency extends StatefulWidget {
  final Drug drug;

  const SelectDoseFrequency({Key? key, required this.drug}) : super(key: key);

  @override
  State<SelectDoseFrequency> createState() => _SelectDoseFrequencyState();
}

class _SelectDoseFrequencyState extends State<SelectDoseFrequency> {
  List<String> doseOptions = [
    "Every day",
    "Every other day",
    "Specific days of the week",
    "On a recurring cycle",
    "Every X days",
    "Every X weeks",
    "Every X months",
    "Only as needed"
  ];

  String? selectedFrequency;
  List<int> frequencyMap = [1, 2, 3, 4, 5, 6, 7, -1];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Dose Frequency")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "How often do you take it?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: doseOptions.length,
                separatorBuilder: (context, index) =>
                    const Divider(thickness: 1, color: Colors.grey),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(doseOptions[index]),
                    trailing: selectedFrequency == doseOptions[index]
                        ? const Icon(Icons.check, color: Colors.blue)
                        : null,
                    onTap: () {
                      setState(() {
                        selectedFrequency = doseOptions[index];
                        widget.drug.frequencydose = selectedFrequency;
                      });

                      debugPrint(
                          'Drug Frequency (for debug): ${widget.drug.frequencydose}');

                      if (selectedFrequency == "Every day") {
                        Get.to(() => SelectDailyDose(drug: widget.drug));
                      } else if (selectedFrequency ==
                              "Specific days of the week" ||
                          selectedFrequency == "Every X days" ||
                          selectedFrequency == "Every X weeks") {
                        Get.to(() => SelectFrequencyDetails(
                            drug: widget.drug,
                            frequencyType: selectedFrequency?? "Every day"));
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

  // แปลงความถี่เป็นค่าตัวเลขที่ใช้ในระบบ
  int _mapFrequencyToNumber(String frequency) {
    switch (frequency) {
      case "Every day":
        return 1;
      case "Every other day":
        return 2;
      case "Specific days of the week":
        return 3;
      case "On a recurring cycle":
        return 4;
      case "Every X days":
        return 5;
      case "Every X weeks":
        return 6;
      case "Every X months":
        return 7;
      case "Only as needed":
        return -1;
      default:
        return 0;
    }
  }
}
