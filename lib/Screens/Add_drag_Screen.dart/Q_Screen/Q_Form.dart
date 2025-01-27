import 'package:flutter/material.dart';
import 'package:pill_reminder/Database/Database_Helper.dart';
import '../Q_drug_model/model.dart';

class QuestionFormScreen extends StatefulWidget {
  final Drug drug;

  const QuestionFormScreen({Key? key, required this.drug}) : super(key: key);

  @override
  State<QuestionFormScreen> createState() => _QuestionFormScreenState();
}

class _QuestionFormScreenState extends State<QuestionFormScreen> {
  // Future สำหรับโหลดรายการ unit_th
  late Future<List<String>> _futureUnits;

  // ตัวแปรเก็บค่าที่เลือกใน Dropdown ปัจจุบัน
  String? _selectedUnit;

  @override
  void initState() {
    super.initState();
    // เรียกฟังก์ชัน fetchUnits() ครั้งเดียวใน initState
    _futureUnits = fetchUnits();
  }

  // ฟังก์ชันดึงข้อมูล unit_th จากตาราง d_unit
  Future<List<String>> fetchUnits() async {
    final db = await DatabaseHelper.instance.database;
    // ดึงเฉพาะ unit_th จากตาราง d_unit
    final results = await db.rawQuery('SELECT unit_th FROM d_unit');
    // แปลงเป็น List<String>
    return results.map((row) => row['unit_th'] as String).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ฟอร์มของยา'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<String>>(
          future: _futureUnits,
          builder: (context, snapshot) {
            // สถานะกำลังโหลด
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // ถ้าเกิด error
            if (snapshot.hasError) {
              return Center(child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
            }

            // ถ้าไม่มีข้อมูลหรือว่างเปล่า
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('ไม่พบรูปแบบยาในฐานข้อมูล'));
            }

            // ได้ข้อมูลรายการ unit_th มาแล้ว
            final units = snapshot.data!;

            return Column(
              children: [
                // DropdownButtonFormField เพื่อเลือกฟอร์มยา
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'ฟอร์มของยา',
                    border: OutlineInputBorder(),
                  ),
                  // สร้าง DropdownMenuItem จากแต่ละ unit ในฐานข้อมูล
                  items: units.map((unit) {
                    return DropdownMenuItem(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                  // ค่าที่เลือกไว้ในปัจจุบัน (ถ้ามี)
                  value: _selectedUnit,
                  onChanged: (value) {
                    setState(() {
                      _selectedUnit = value;
                      // บันทึกฟอร์มของยาใน Model
                      widget.drug.form = value;
                    });
                  },
                ),

                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () {
                    // ตัวอย่าง debug ดูว่าฟอร์มของยาใน model มีค่าอะไร
                    debugPrint('Selected form: ${widget.drug.form}');

                    // ทำอย่างอื่น หรือไปหน้าถัดไปได้ตามต้องการ
                  },
                  child: const Text('บันทึก / ถัดไป'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
