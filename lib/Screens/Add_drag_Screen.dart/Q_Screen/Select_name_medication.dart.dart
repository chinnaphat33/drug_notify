import 'package:flutter/material.dart';
import '../Q_drug_model/model.dart';
import 'package:pill_reminder/Database/Database_Helper.dart';
import 'package:pill_reminder/Screens/Add_drag_Screen.dart/Q_Screen/Select_dose_frequency.dart';

class QuestionNameScreen extends StatefulWidget {
  final Drug drug;
  const QuestionNameScreen({Key? key, required this.drug}) : super(key: key);

  @override
  State<QuestionNameScreen> createState() => _QuestionNameScreenState();
}

class _QuestionNameScreenState extends State<QuestionNameScreen> {

  Future<List<String>>? _futureMedicationNames;
  List<String> _medicationList = [];
  @override
  void initState() {
    super.initState();
    _futureMedicationNames = fetchMedicationNames();
  }

  final _formKey = GlobalKey<FormState>();
  Future<List<String>> fetchMedicationNames() async {
    final db = await DatabaseHelper.instance.database;
    final results = await db.rawQuery('SELECT name_en FROM d_medications');
    return results.map((row) => row['name_en'] as String).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ชื่อยา'),
      ),
      body: FutureBuilder<List<String>>(
        future: _futureMedicationNames,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('ไม่พบข้อมูลยาในฐานข้อมูล'));
          } else {
            final medicationNames = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey, // กำหนด key ให้ Form
                child: Column(
                  children: [
                    // ใช้ TextFormField เพื่อที่เราจะได้ใช้ validator
                    Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return const Iterable<String>.empty();
                        }
                        return medicationNames.where((String option) {
                          return option
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (String selection) {
                        setState(() {
                          widget.drug.name = selection;
                        });
                      },
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController textEditingController,
                          FocusNode focusNode,
                          VoidCallback onFieldSubmitted) {
                        return TextFormField(
                          controller: textEditingController,
                          focusNode: focusNode,
                          decoration: const InputDecoration(
                            labelText: '',
                            border: OutlineInputBorder(),
                          ),
                          // validator อยู่ใน TextFormField
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'โปรดกรอกชื่อยา';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            widget.drug.name = value;
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    ElevatedButton(
                      onPressed: () {
                        // ตัวอย่าง: หากมี Form และตัวแปร _formKey
                        if (_formKey.currentState!.validate()) {
                          // แสดงค่า drug.name ใน console
                          debugPrint(
                              'Drug name (for debug): ${widget.drug.name}');

                          // จากนั้นค่อยไปหน้าถัดไป
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SelectDoseFrequency(drug: widget.drug),
                            ),
                          );
                        }
                      },
                      child: const Text('ถัดไป'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
