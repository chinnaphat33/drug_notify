import 'Database_Helper.dart';

class UpdateData {
  Future<void> updateCategoryData(Map<String, dynamic> data, int id) async {
    await DatabaseHelper.instance.updateData(data, 'd_categories', id);
  }

  Future<void> updateMedicationData(Map<String, dynamic> data, int id) async {
    await DatabaseHelper.instance.updateData(data, 'd_medications', id);
  }

  Future<void> updateUnitData(Map<String, dynamic> data, int id) async {
    await DatabaseHelper.instance.updateData(data, 'd_unit', id);
  }

  Future<void> updateUserData(Map<String, dynamic> data, int id) async {
    await DatabaseHelper.instance.updateData(data, 'd_user', id);
  }

  Future<void> updateMedicationScheduleData(
      Map<String, dynamic> data, int id) async {
    await DatabaseHelper.instance.updateData(data, 'medication_schedule', id);
  }
}

////////------------------------------------>
// EX.updateData
// void _updateData() async {
//   UpdateData updateData = UpdateData();
//   Map<String, dynamic> data = {
//     'description_th': 'ยาที่ใช้บรรเทาอาการปวดใหม่',
//   };
//   int id = 1; // specify the id here
//   await updateData.updateCategoryData(data, id);
// }
