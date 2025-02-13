import 'package:get/get.dart';
import '../Screens/Add_drag_Screen.dart/Q_drug_model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class MedicationController extends GetxController {
  var medications = <Drug>[].obs;

  void addMedication(Drug drug) {
    medications.add(drug);
    saveMedications();
  }

  Future<void> saveMedications() async {
    final prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> jsonMedications = medications
        .map((drug) => {
              'name': drug.name,
              'times': drug.times,
              'selectedDays':
                  drug.selectedDays, 
              'intervalDays':
                  drug.intervalDays, 
            })
        .toList();

    String encoded = jsonEncode(jsonMedications);
    await prefs.setString('medications', encoded);

    print("💾 Saved Medications: $encoded"); 
  }

  Future<void> loadMedications() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonMedications = prefs.getString('medications');

    if (jsonMedications != null) {
      print("📥 Loaded JSON: $jsonMedications"); // ✅ ตรวจสอบ JSON ที่โหลดมา

      List<dynamic> decodedList = jsonDecode(jsonMedications);
      medications.value = decodedList.map((item) {
        Drug drug = Drug(
          name: item['name'],
          times: List<String>.from(item['times']),
          selectedDays: item['selectedDays'] != null
              ? List<int>.from(item['selectedDays'])
              : [],
          intervalDays: item['intervalDays'],
        );

        print(
            "🔍 Loaded Drug: ${drug.name}, Days: ${drug.selectedDays}, Interval: ${drug.intervalDays}"); // ✅ Log ค่าแต่ละตัว

        return drug;
      }).toList();
    } else {
      print("⚠️ No Medications Found in SharedPreferences");
    }
  }
void confirmDeleteDrug(int index) {
    Get.defaultDialog(
      title: "Confirm Deletion",
      middleText: "Are you sure you want to delete this medication?",
      textConfirm: "Delete",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        medications.removeAt(index);  
        saveMedications();  
        
        Get.back(); 
      },
    );
  }
}
