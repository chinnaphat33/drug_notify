import 'package:get/get.dart';
import '../Screens/Add_drag_Screen.dart/Q_drug_model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MedicationController extends GetxController {
  var medications = <Drug>[].obs;

  void addMedication(Drug drug) {
    medications.add(drug);
    saveMedications(); 
  }

  Future<void> saveMedications() async {
    final prefs = await SharedPreferences.getInstance();
  
    List<Map<String, dynamic>> medicationList = medications.map((drug) => {
      "name": drug.name,
      "times": drug.times,
    }).toList();

    String jsonMedications = jsonEncode(medicationList);
    await prefs.setString('medications', jsonMedications);
  }

  Future<void> loadMedications() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonMedications = prefs.getString('medications');

    if (jsonMedications != null) {
      List<dynamic> decodedList = jsonDecode(jsonMedications);
      medications.value = decodedList.map((item) => Drug(
        name: item['name'],
        times: List<String>.from(item['times']),
      )).toList();
    }
  }
}

