class Drug {
  String? name;
  String? form; // ฟอร์มของยา เช่น เม็ด น้ำ
  int? dosagePerDay; // จำนวนยาที่ต้องทานต่อวัน
  List<String>? times; // เวลาที่ต้องการแจ้งเตือน

  Drug({this.name, this.form, this.dosagePerDay, this.times});
}