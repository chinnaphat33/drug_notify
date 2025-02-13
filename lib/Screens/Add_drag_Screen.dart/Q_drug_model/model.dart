class Drug {
  String? name;
  int? dosagePerDay;
  List<String>? times;
  String? frequencydose;
  List<int>? selectedDays; 
  int? intervalDays; 
  DateTime? startDate;

  Drug({
    this.name,
    this.dosagePerDay,
    this.times,
    this.frequencydose,
    this.selectedDays,
    this.intervalDays,
    this.startDate,
  });

  // ✅ แปลงเป็น JSON
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "dosagePerDay": dosagePerDay,
      "times": times,
      "frequency": frequencydose,
      "selectedDays": selectedDays, // 🆕 เพิ่มข้อมูลวัน
      "intervalDays": intervalDays, // 🆕 เพิ่มข้อมูลจำนวนวัน
      "startDate": startDate?.toIso8601String(),
    };
  }

  // ✅ โหลดจาก JSON
  factory Drug.fromJson(Map<String, dynamic> json) {
    return Drug(
      name: json["name"],
      dosagePerDay: json["dosagePerDay"],
      times: List<String>.from(json["times"] ?? []),
      frequencydose: json["frequency"],
      selectedDays: json["selectedDays"] != null
          ? List<int>.from(json["selectedDays"])
          : null, // 🆕 โหลดข้อมูลวัน
      intervalDays: json["intervalDays"], // 🆕 โหลดข้อมูลจำนวนวัน
      startDate:
          json["startDate"] != null ? DateTime.parse(json["startDate"]) : null,
    );
  }
}
