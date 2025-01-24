import '../Database/Insert_Data.dart';

class DataStandardAll {
  void Data_category() async {
    InsertData insertData = InsertData();

    List<Map<String, dynamic>> subcategoryData = [
      {
        "id": 1,
        "name_th": "ยาแก้ปวด",
        "name_en": "Pain reliever",
        "description_th": "ยาที่ใช้บรรเทาอาการปวด",
        "description_en": "Medicines used to relieve pain"
      },
      {
        "id": 2,
        "name_th": "ยาลดไข้",
        "name_en": "Antipyretic medicine",
        "description_th": "ยาที่ช่วยลดอุณหภูมิร่างกาย",
        "description_en": "Medicines that reduce body temperature"
      },
      {
        "id": 3,
        "name_th": "ยาแก้แพ้",
        "name_en": "Antihistamines",
        "description_th": "ยาสำหรับอาการภูมิแพ้",
        "description_en": "Medicine for allergy symptoms"
      },
      {
        "id": 4,
        "name_th": "ยาฆ่าเชื้อ",
        "name_en": "Disinfectant",
        "description_th": "ยาที่ใช้รักษาการติดเชื้อแบคทีเรีย",
        "description_en": "Medicines used to treat bacterial infections"
      },
      {
        "id": 5,
        "name_th": "วิตามินและเกลือแร่",
        "name_en": "Vitamins and minerals",
        "description_th": "ยาที่ใช้เสริมสุขภาพ",
        "description_en": "Medicines used to enhance health"
      },
      {
        "id": 6,
        "name_th": "ยาโรคกระเพาะ",
        "name_en": "Gastritis medicine",
        "description_th": "ยาสำหรับโรคกระเพาะ กรดไหลย้อน",
        "description_en": "Medicine for gastritis, acid reflux"
      },
      {
        "id": 7,
        "name_th": "ยาเฉพาะทาง",
        "name_en": "Specialized medicine",
        "description_th": "ยาสำหรับรักษาอาการเฉพาะเจาะจง",
        "description_en": "Drugs for specific symptom treatment"
      }
    ];

    for (var data in subcategoryData) {
      await insertData.insertCategoryData(data);
    }
  }

  void Data_medications() async {
    InsertData insertData = InsertData();

    List<Map<String, dynamic>> medicationsData = [
      {
        "id": 1,
        "name_th": "อัลปราโซแลม",
        "name_en": "Alprazolam",
        "description_th": "บรรเทาอาการนอนไม่หลับ",
        "description_en": "Alleviates insomnia",
        "common_usage_th": "ทานก่อนนอน",
        "common_usage_en": "Take before bedtime",
        "category_id": 1
      },
      {
        "id": 2,
        "name_th": "แคลเซียมคาร์บอเนต",
        "name_en": "Calcium Carbonate",
        "description_th": "เสริมแคลเซียม",
        "description_en": "Calcium supplement",
        "common_usage_th": "ทานพร้อมอาหาร",
        "common_usage_en": "Take with food",
        "category_id": 5
      },
      {
        "id": 3,
        "name_th": "ซัลบูทามอล",
        "name_en": "Salbutamol",
        "description_th": "บรรเทาอาการหอบ",
        "description_en": "Relieves asthma symptoms",
        "common_usage_th": "ทานหรือสูดตามคำแนะนำ",
        "common_usage_en": "Take or inhale as directed",
        "category_id": 3
      },
      {
        "id": 4,
        "name_th": "โซเดียมคลอไรด์",
        "name_en": "Sodium Chloride",
        "description_th": "ล้างแผล/ทำความสะอาด",
        "description_en": "Wound cleaning",
        "common_usage_th": "ใช้ภายนอก",
        "common_usage_en": "For external use",
        "category_id": 4
      },
      {
        "id": 5,
        "name_th": "คีโตโคนาโซล",
        "name_en": "Ketoconazole",
        "description_th": "รักษาเชื้อราผิวหนัง",
        "description_en": "Treats skin fungal infections",
        "common_usage_th": "ใช้ทาภายนอก",
        "common_usage_en": "For external application",
        "category_id": 4
      },
      {
        "id": 6,
        "name_th": "ทรามาดอล",
        "name_en": "Tramadol",
        "description_th": "บรรเทาอาการปวดรุนแรง",
        "description_en": "Relieves severe pain",
        "common_usage_th": "ทานตามคำแนะนำของแพทย์",
        "common_usage_en": "Take as prescribed by a doctor",
        "category_id": 1
      },
      {
        "id": 7,
        "name_th": "บัสโคแปน",
        "name_en": "Buscopan",
        "description_th": "แก้ปวดเกร็งท้อง",
        "description_en": "Relieves stomach cramps",
        "common_usage_th": "ทานเมื่อมีอาการ",
        "common_usage_en": "Take when symptoms occur",
        "category_id": 1
      },
      {
        "id": 8,
        "name_th": "ฟลูโคนาโซล",
        "name_en": "Fluconazole",
        "description_th": "รักษาเชื้อราภายใน",
        "description_en": "Treats internal fungal infections",
        "common_usage_th": "ทานตามคำแนะนำของแพทย์",
        "common_usage_en": "Take as prescribed by a doctor",
        "category_id": 4
      },
      {
        "id": 9,
        "name_th": "ด็อกซี่ไซคลิน",
        "name_en": "Doxycycline",
        "description_th": "ยาฆ่าเชื้อแบคทีเรีย",
        "description_en": "Antibiotic",
        "common_usage_th": "ทานวันละ 1 ครั้ง",
        "common_usage_en": "Take once daily",
        "category_id": 4
      },
      {
        "id": 10,
        "name_th": "ไซโปรฟลอกซาซิน",
        "name_en": "Ciprofloxacin",
        "description_th": "รักษาอาการติดเชื้อแบคทีเรีย",
        "description_en": "Treats bacterial infections",
        "common_usage_th": "ทานตามคำแนะนำของแพทย์",
        "common_usage_en": "Take as prescribed by a doctor",
        "category_id": 4
      },
      {
        "id": 11,
        "name_th": "แคลไดทรอล",
        "name_en": "Calcitriol",
        "description_th": "เสริมวิตามินดี",
        "description_en": "Vitamin D supplement",
        "common_usage_th": "ทานพร้อมอาหาร",
        "common_usage_en": "Take with food",
        "category_id": 5
      },
      {
        "id": 12,
        "name_th": "รานิทิดีน",
        "name_en": "Ranitidine",
        "description_th": "บรรเทาอาการกรดไหลย้อน",
        "description_en": "Relieves acid reflux",
        "common_usage_th": "ทานก่อนอาหาร",
        "common_usage_en": "Take before meals",
        "category_id": 6
      },
      {
        "id": 13,
        "name_th": "เฟอร์รัสซัลเฟต",
        "name_en": "Ferrous Sulfate",
        "description_th": "เสริมธาตุเหล็ก",
        "description_en": "Iron supplement",
        "common_usage_th": "ทานพร้อมน้ำผลไม้",
        "common_usage_en": "Take with fruit juice",
        "category_id": 5
      },
      {
        "id": 14,
        "name_th": "แอมพิซิลลิน",
        "name_en": "Ampicillin",
        "description_th": "ยาฆ่าเชื้อแบคทีเรีย",
        "description_en": "Antibiotic",
        "common_usage_th": "ทานตามคำแนะนำของแพทย์",
        "common_usage_en": "Take as prescribed by a doctor",
        "category_id": 4
      },
      {
        "id": 15,
        "name_th": "โคลชิซีน",
        "name_en": "Colchicine",
        "description_th": "รักษาโรคเก๊าท์",
        "description_en": "Treats gout",
        "common_usage_th": "ทานหลังอาหาร",
        "common_usage_en": "Take after meals",
        "category_id": 7
      },
      {
        "id": 16,
        "name_th": "คลาร์ริโทรมัยซิน",
        "name_en": "Clarithromycin",
        "description_th": "ยาฆ่าเชื้อแบคทีเรีย",
        "description_en": "Antibiotic",
        "common_usage_th": "ทานวันละ 2 ครั้ง",
        "common_usage_en": "Take twice daily",
        "category_id": 4
      },
      {
        "id": 17,
        "name_th": "เมโทโคลพราไมด์",
        "name_en": "Metoclopramide",
        "description_th": "แก้อาการคลื่นไส้อาเจียน",
        "description_en": "Relieves nausea and vomiting",
        "common_usage_th": "ทานก่อนอาหาร",
        "common_usage_en": "Take before meals",
        "category_id": 1
      },
      {
        "id": 18,
        "name_th": "แอคซีโคลเวียร์",
        "name_en": "Acyclovir",
        "description_th": "รักษาเริม/งูสวัด",
        "description_en": "Treats herpes/shingles",
        "common_usage_th": "ทานตามคำแนะนำของแพทย์",
        "common_usage_en": "Take as prescribed by a doctor",
        "category_id": 4
      },
      {
        "id": 19,
        "name_th": "นอร์ฟลอกซาซิน",
        "name_en": "Norfloxacin",
        "description_th": "รักษาอาการติดเชื้อในระบบทางเดินปัสสาวะ",
        "description_en": "Treats urinary tract infections",
        "common_usage_th": "ทานตามคำแนะนำของแพทย์",
        "common_usage_en": "Take as prescribed by a doctor",
        "category_id": 4
      },
      {
        "id": 20,
        "name_th": "เม็ดฟู่เกลือแร่",
        "name_en": "Oral Rehydration Salts (ORS)",
        "description_th": "ชดเชยเกลือแร่",
        "description_en": "Replenishes electrolytes",
        "common_usage_th": "ละลายน้ำและดื่ม",
        "common_usage_en": "Dissolve in water and drink",
        "category_id": 5
      },
      {
        "id": 21,
        "name_th": "อิริโทรมัยซิน",
        "name_en": "Erythromycin",
        "description_th": "รักษาอาการติดเชื้อแบคทีเรีย",
        "description_en": "Treats bacterial infections",
        "common_usage_th": "ทานวันละ 2-4 ครั้ง",
        "common_usage_en": "Take 2-4 times daily",
        "category_id": 4
      },
      {
        "id": 22,
        "name_th": "ไทลีนอล",
        "name_en": "Tylenol",
        "description_th": "ลดไข้ บรรเทาอาการปวด",
        "description_en": "Reduces fever and relieves pain",
        "common_usage_th": "ทานตามคำแนะนำ",
        "common_usage_en": "Take as directed",
        "category_id": 1
      },
      {
        "id": 23,
        "name_th": "โพรพานอลอล",
        "name_en": "Propranolol",
        "description_th": "รักษาอาการหัวใจเต้นผิดจังหวะ",
        "description_en": "Treats irregular heartbeat",
        "common_usage_th": "ทานวันละครั้ง",
        "common_usage_en": "Take once daily",
        "category_id": 7
      },
      {
        "id": 24,
        "name_th": "อะโทรเวนต์",
        "name_en": "Atrovent",
        "description_th": "รักษาโรคหอบหืด",
        "description_en": "Treats asthma",
        "common_usage_th": "สูดตามคำแนะนำแพทย์",
        "common_usage_en": "Inhale as directed by a doctor",
        "category_id": 7
      },
      {
        "id": 25,
        "name_th": "บี1 บี6 บี12",
        "name_en": "Vitamin B1 B6 B12",
        "description_th": "บำรุงประสาท",
        "description_en": "Nerve health support",
        "common_usage_th": "ทานวันละ 1 ครั้ง",
        "common_usage_en": "Take once daily",
        "category_id": 7
      },
      {
        "id": 26,
        "name_th": "โฟลิก แอซิด",
        "name_en": "Folic Acid",
        "description_th": "เสริมวิตามินบี 9",
        "description_en": "Folic acid supplement",
        "common_usage_th": "ทานก่อนอาหาร",
        "common_usage_en": "Take before meals",
        "category_id": 26
      },
      {
        "id": 27,
        "name_th": "พาราเซตามอล",
        "name_en": "Paracetamol",
        "description_th": "บรรเทาอาการปวด ลดไข้",
        "description_en": "Relieves pain and reduces fever",
        "common_usage_th": "ทานหลังอาหาร",
        "common_usage_en": "Take after meals",
        "category_id": 1
      },
      {
        "id": 28,
        "name_th": "ไอบูโพรเฟน",
        "name_en": "Ibuprofen",
        "description_th": "ลดการอักเสบ บรรเทาอาการปวด",
        "description_en": "Reduces inflammation and relieves pain",
        "common_usage_th": "ทานพร้อมน้ำ",
        "common_usage_en": "Take with water",
        "category_id": 2
      },
      {
        "id": 29,
        "name_th": "อม็อกซีซิลลิน",
        "name_en": "Amoxicillin",
        "description_th": "รักษาอาการติดเชื้อแบคทีเรีย",
        "description_en": "Treats bacterial infections",
        "common_usage_th": "ทานตามคำแนะนำของแพทย์",
        "common_usage_en": "Take as prescribed by a doctor",
        "category_id": 4
      },
      {
        "id": 30,
        "name_th": "โลเพอราไมด์",
        "name_en": "Loperamide",
        "description_th": "บรรเทาอาการท้องเสีย",
        "description_en": "Relieves diarrhea",
        "common_usage_th": "ทานเมื่อมีอาการ",
        "common_usage_en": "Take when symptoms occur",
        "category_id": 7
      },
      {
        "id": 31,
        "name_th": "เม็ดฟู่วิตามินซี",
        "name_en": "Vitamin C Effervescent",
        "description_th": "เสริมวิตามินซี",
        "description_en": "Vitamin C supplement",
        "common_usage_th": "ละลายในน้ำ 1 แก้ว",
        "common_usage_en": "Dissolve in 1 glass of water",
        "category_id": 5
      },
      {
        "id": 32,
        "name_th": "คลอร์เฟนิรามีน",
        "name_en": "Chlorpheniramine",
        "description_th": "บรรเทาอาการแพ้",
        "description_en": "Relieves allergy symptoms",
        "common_usage_th": "ทานก่อนนอน",
        "common_usage_en": "Take before bedtime",
        "category_id": 3
      },
      {
        "id": 33,
        "name_th": "ซิตริซีน",
        "name_en": "Cetirizine",
        "description_th": "รักษาอาการภูมิแพ้",
        "description_en": "Treats allergies",
        "common_usage_th": "ทานก่อนนอน",
        "common_usage_en": "Take before bedtime",
        "category_id": 3
      },
      {
        "id": 34,
        "name_th": "ลอราทาดีน",
        "name_en": "Loratadine",
        "description_th": "บรรเทาอาการคัดจมูก",
        "description_en": "Relieves nasal congestion",
        "common_usage_th": "ทานวันละครั้ง",
        "common_usage_en": "Take once daily",
        "category_id": 3
      },
      {
        "id": 35,
        "name_th": "โอเมพราโซล",
        "name_en": "Omeprazole",
        "description_th": "รักษาอาการกรดไหลย้อน",
        "description_en": "Treats acid reflux",
        "common_usage_th": "ทานก่อนอาหารเช้า",
        "common_usage_en": "Take before breakfast",
        "category_id": 6
      },
      {
        "id": 36,
        "name_th": "แอลบูมิน",
        "name_en": "Albumin",
        "description_th": "เสริมโปรตีน",
        "description_en": "Protein supplement",
        "common_usage_th": "ดื่มระหว่างมื้ออาหาร",
        "common_usage_en": "Drink between meals",
        "category_id": 7
      },
      {
        "id": 37,
        "name_th": "ไซเมทิโคน",
        "name_en": "Simethicone",
        "description_th": "แก้ปัญหาท้องอืด",
        "description_en": "Relieves bloating",
        "common_usage_th": "ทานเมื่อมีอาการ",
        "common_usage_en": "Take when symptoms occur",
        "category_id": 7
      },
      {
        "id": 38,
        "name_th": "โคเดอีน",
        "name_en": "Codeine",
        "description_th": "บรรเทาอาการไอ",
        "description_en": "Relieves cough",
        "common_usage_th": "ทานตามคำแนะนำของแพทย์",
        "common_usage_en": "Take as prescribed by a doctor",
        "category_id": 7
      },
      {
        "id": 39,
        "name_th": "ยาคูลล์",
        "name_en": "Yakult",
        "description_th": "โปรไบโอติกส์ บำรุงลำไส้",
        "description_en": "Probiotics for gut health",
        "common_usage_th": "ดื่มวันละครั้ง",
        "common_usage_en": "Drink once daily",
        "category_id": 7
      },
      {
        "id": 40,
        "name_th": "ไดโคลฟีแนค",
        "name_en": "Diclofenac",
        "description_th": "บรรเทาอาการปวดข้อ",
        "description_en": "Relieves joint pain",
        "common_usage_th": "ทานพร้อมอาหาร",
        "common_usage_en": "Take with food",
        "category_id": 2
      },
      {
        "id": 41,
        "name_th": "กาบาเพนติน",
        "name_en": "Gabapentin",
        "description_th": "รักษาอาการปวดเส้นประสาท",
        "description_en": "Treats nerve pain",
        "common_usage_th": "ทานก่อนนอน",
        "common_usage_en": "Take before bedtime",
        "category_id": 7
      },
      {
        "id": 42,
        "name_th": "แอสไพริน",
        "name_en": "Aspirin",
        "description_th": "ป้องกันลิ่มเลือดอุดตัน",
        "description_en": "Prevents blood clots",
        "common_usage_th": "ทานตามคำแนะนำของแพทย์",
        "common_usage_en": "Take as prescribed by a doctor",
        "category_id": 7
      },
      {
        "id": 43,
        "name_th": "เซฟาเล็กซิน",
        "name_en": "Cephalexin",
        "description_th": "ยาฆ่าเชื้อแบคทีเรีย",
        "description_en": "Antibiotic",
        "common_usage_th": "ทานวันละ 2 ครั้ง",
        "common_usage_en": "Take twice daily",
        "category_id": 4
      },
      {
        "id": 44,
        "name_th": "โพแทสเซียมคลอไรด์",
        "name_en": "Potassium Chloride",
        "description_th": "เสริมเกลือแร่",
        "description_en": "Potassium supplement",
        "common_usage_th": "ทาน วันละครั้ง",
        "common_usage_en": "Take once daily",
        "category_id": 5
      },
      {
        "id": 45,
        "name_th": "ฟลูออรีควิโนโลน",
        "name_en": "Fluoroquinolone",
        "description_th": "ยาปฏิชีวนะ",
        "description_en": "Antibiotic",
        "common_usage_th": "ทานตามคำแนะนำของแพทย์",
        "common_usage_en": "Take as prescribed by a doctor",
        "category_id": 4
      },
      {
        "id": 46,
        "name_th": "เมโทรนิดาโซล",
        "name_en": "Metronidazole",
        "description_th": "รักษาอาการติดเชื้อ",
        "description_en": "Treats infections",
        "common_usage_th": "ทานตามคำแนะนำของแพทย์",
        "common_usage_en": "Take as prescribed by a doctor",
        "category_id": 4
      },
      {
        "id": 47,
        "name_th": "ซัลฟาเมโทซีน",
        "name_en": "Sulfamethoxazole",
        "description_th": "ยาปฏิชีวนะ",
        "description_en": "Antibiotic",
        "common_usage_th": "ทานตามคำแนะนำของแพทย์",
        "common_usage_en": "Take as prescribed by a doctor",
        "category_id": 4
      },
      {
        "id": 48,
        "name_th": "อัลลูมิเนียมไฮดรอกไซด์",
        "name_en": "Aluminum Hydroxide",
        "description_th": "บรรเทาอาการกรดในกระเพาะ",
        "description_en": "Relieves stomach acid",
        "common_usage_th": "ทานตามคำแนะนำ",
        "common_usage_en": "Take as directed",
        "category_id": 6
      },
      {
        "id": 49,
        "name_th": "ซิโทรไพริดีน",
        "name_en": "Ciprofloxacin",
        "description_th": "ยาปฏิชีวนะ",
        "description_en": "Antibiotic",
        "common_usage_th": "ทานตามคำแนะนำของแพทย์",
        "common_usage_en": "Take as prescribed by a doctor",
        "category_id": 4
      },
      {
        "id": 50,
        "name_th": "อีโซเมพราโซล",
        "name_en": "Esomeprazole",
        "description_th": "รักษาอาการกรดไหลย้อน",
        "description_en": "Treats acid reflux",
        "common_usage_th": "ทานก่อนอาหาร",
        "common_usage_en": "Take before meals",
        "category_id": 6
      },
      {
        "id": 51,
        "name_th": "ฟีนิทอยน",
        "name_en": "Phenytoin",
        "description_th": "รักษาอาการชัก",
        "description_en": "Treats seizures",
        "common_usage_th": "ทานตามคำแนะนำของแพทย์",
        "common_usage_en": "Take as prescribed by a doctor",
        "category_id": 7
      }
    ];

    for (var data in medicationsData) {
      await insertData.insertMedicationData(data);
    }
  }

  void Data_unit() async {
    InsertData insertData = InsertData();

    List<Map<String, dynamic>> subunitData = [
      {"id": 1, "unit_th": "เม็ด", "unit_en": "grain"},
      {"id": 2, "unit_th": "ขวด", "unit_en": "bottle"},
      {"id": 3, "unit_th": "กระปุก", "unit_en": "bowl"}
    ];

    for (var data in subunitData) {
      await insertData.insertUnitData(data);
    }
  }

  void Data_user() async {
    InsertData insertData = InsertData();

    List<Map<String, dynamic>> subuserData = [
      {
        "id": 1,
        "name_th": "สมชาย สุขสันต์",
        "name_en": "Somchai Suksant",
        "sex_th": "ชาย",
        "sex_en": "Male",
        "weight": 70,
        "height": 170,
        "img": "img1.jpg",
        "birthday": "1990-01-01",
        "phone": "0812345678",
        "other": "ข้อมูลอื่นๆ",
        "email": "test01@gmail.com",
        "tel": 613544099,
        "addr":
            "ถนน รัตนโกสินทร์ ตำบลศรีภูมิ อำเภอเมืองเชียงใหม่ เชียงใหม่ 50200"
      }
    ];

    for (var data in subuserData) {
      await insertData.insertUserData(data);
    }
  }

  void Data_medication_schedule() async {
    InsertData insertData = InsertData();

    List<Map<String, dynamic>> submedication_scheduleData = [
      {
        // "id": 1,
        "medication_id": 1,
        "date": "2025-01-14",
        "time": "08:00:00",
        "qty": 1.5,
        "stamp": "2025-01-14 08:00:00",
        "status": "succeed",
        "st": 0,
        "user_id": 1,
        "status_stamp": "2025-01-14 08:10:00",
        "type": 1
      },
      {
        // "id": 2,
        "medication_id": 2,
        "date": "2025-01-14",
        "time": "12:00:00",
        "qty": 1.5,
        "stamp": "2025-01-14 12:00:00",
        "status": "succeed",
        "st": 0,
        "user_id": 1,
        "status_stamp": "2025-01-14 12:20:47",
        "type": 1
      },
      {
        // "id": 3,
        "medication_id": 3,
        "date": "2025-01-14",
        "time": "18:00:00",
        "qty": 1,
        "stamp": "2025-01-14 18:00:00",
        "status": "pending",
        "st": 0,
        "user_id": 1,
        "status_stamp": "N/A",
        "type": 1
      },
      {
        // "id": 4,
        "medication_id": 1,
        "date": "2025-01-15",
        "time": "08:00:00",
        "qty": 1,
        "stamp": "2025-01-15 08:00:00",
        "status": "pending",
        "st": 0,
        "user_id": 1,
        "status_stamp": "N/A",
        "type": 1
      },
      {
        // "id": 5,
        "medication_id": 2,
        "date": "2025-01-15",
        "time": "12:00:00",
        "qty": 2,
        "stamp": "2025-01-15 12:00:00",
        "status": "pending",
        "st": 0,
        "user_id": 1,
        "status_stamp": "N/A",
        "type": 1
      },
      {
        // "id": 6,
        "medication_id": 3,
        "date": "2025-01-15",
        "time": "18:00:00",
        "qty": 3,
        "stamp": "2025-01-15 08:00:00",
        "status": "pending",
        "st": 0,
        "user_id": 1,
        "status_stamp": "N/A",
        "type": 1
      }
    ];

    for (var data in submedication_scheduleData) {
      if (data["status_stamp"] == "") {
        data["status_stamp"] = "N/A";
      }
      await insertData.insertMedicationScheduleData(data);
    }
  }
}
