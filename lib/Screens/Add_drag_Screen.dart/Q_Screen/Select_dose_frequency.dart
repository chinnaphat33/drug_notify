import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Q_drug_model/model.dart';
import 'package:pill_reminder/Screens/Add_drag_Screen.dart/Q_Screen/SelectDailyDose.dart';

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
                separatorBuilder: (context, index) => const Divider(
                  thickness: 1, // ความหนาของเส้น
                  color: Colors.grey, // สีของเส้น
                ),
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(doseOptions[index]),
                      trailing: selectedFrequency == doseOptions[index]
                          ? const Icon(Icons.check, color: Colors.blue)
                          : null,
                      onTap: () {
                        setState(() {
                          selectedFrequency = doseOptions[index];
                        });

                        // อัปเดตค่าลงใน Drug object
                        widget.drug.frequencydose =
                            selectedFrequency; // ✨ เพิ่มการบันทึกค่า frequencydose

                        debugPrint(
                            'Drug Frequency (for debug): ${widget.drug.frequencydose}'); // ✨ แสดงผลค่า frequencydose
                        if (selectedFrequency == "Every day") {
                          Get.to(() => SelectDailyDose(drug: widget.drug));
                        }

                        // ส่งค่ากลับไปยังหน้าก่อนหน้า
                        else {
                          // ถ้าเป็น "Only as needed" → กลับหน้าหลัก
                          Get.back(result: widget.drug);
                        }
                      });
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
