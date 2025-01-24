import 'Database_Helper.dart';

class DeleteData {
  Future<void> deleteCategoryData(int id) async {
    await DatabaseHelper.instance.deleteData(id, 'd_categories');
  }

  Future<void> deleteMedicationData(int id) async {
    await DatabaseHelper.instance.deleteData(id, 'd_medications');
  }

  Future<void> deleteUnitData(int id) async {
    await DatabaseHelper.instance.deleteData(id, 'd_unit');
  }

  Future<void> deleteUserData(int id) async {
    await DatabaseHelper.instance.deleteData(id, 'd_user');
  }

  Future<void> deleteMedicationScheduleData(int id) async {
    await DatabaseHelper.instance.deleteData(id, 'medication_schedule');
  }
}

////////------------------------------------>
// EX.deleteData
// void _deleteData() async {
//   DeleteData deleteData = DeleteData();

//   await deleteData.deleteCategoryData(1);
// }
