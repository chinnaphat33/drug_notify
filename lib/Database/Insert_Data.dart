import 'Database_Helper.dart';

class InsertData {
  Future<void> insertCategoryData(Map<String, dynamic> data) async {
    await DatabaseHelper.instance.insertData(data, 'd_categories');
  }

  Future<void> insertMedicationData(Map<String, dynamic> data) async {
    await DatabaseHelper.instance.insertData(data, 'd_medications');
  }

  Future<void> insertUnitData(Map<String, dynamic> data) async {
    await DatabaseHelper.instance.insertData(data, 'd_unit');
  }

  Future<void> insertUserData(Map<String, dynamic> data) async {
    await DatabaseHelper.instance.insertData(data, 'd_user');
  }

  Future<void> insertMedicationScheduleData(Map<String, dynamic> data) async {
    await DatabaseHelper.instance.insertData(data, 'medication_schedule');
  }
}

// class InsertMedicationScheduleData {Update_Data
//   Future<void> insert(Map<String, dynamic> data) async {
//     await DatabaseHelper.instance.insertData(data, 'medication_schedule');
//   }
// }

// void _insertData() async {
//   InsertData insertData = InsertData();

//   Map<String, dynamic> categoryData = {
//     // 'id': 1,
//     'name_th': 'ยาแก้ปวด',
//     'name_en': 'Pain reliever',
//     'description_th': 'ยาที่ใช้บรรเทาอาการปวด',
//     'description_en': 'Medicines used to relieve pain',
//   };

//   await insertData.insertCategoryData(categoryData);

//   Map<String, dynamic> medicationData = {
//     // 'id': 1,
//     'name_th': 'ยาลดไข้',
//     'name_en': 'Antipyretic medicine',
//     'description_th': 'ยาที่ช่วยลดอุณหภูมิร่างกาย',
//     'description_en': 'Medicines that reduce body temperature',
//     'common_usage_th': 'ใช้ลดไข้',
//     'common_usage_en': 'Used to reduce fever',
//     'category_id': 1,
//   };

//   await insertData.insertMedicationData(medicationData);
// }
