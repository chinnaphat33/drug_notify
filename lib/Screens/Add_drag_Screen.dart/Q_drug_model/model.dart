class Drug {
  String? name;
  String? form; // ฟอร์มของยา เช่น เม็ด น้ำ
  int? dosagePerDay; // จำนวนยาที่ต้องทานต่อวัน
  List<String>? times; // เวลาที่ต้องการแจ้งเตือน
  String? frequencydose;
  Drug({this.name, this.form,this.frequencydose, this.dosagePerDay, this.times});
}

