import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:pill_reminder/Controllers/ medication_controller.dart';
import 'package:pill_reminder/Screens/Add_drag_Screen.dart/Q_Screen/Select_name_medication.dart.dart';
import 'package:pill_reminder/Screens/Categories_Screen.dart';
import 'Add_drag_Screen.dart/Q_drug_model/model.dart';
// import 'dart:developer';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _Homepage();
}

class _Homepage extends State<HomePage> {
  final DatePickerController _controller = DatePickerController();
  DateTime _selectedDate = DateTime.now();
  DateTime? _lastPrintedDate; // ✅ ตัวแปรเก็บค่าที่ print ไปแล้ว
  int _selectedIndex = 1;
  List<Drug> _cachedFilteredMeds = [];

  final MedicationController medicationController =
      Get.put(MedicationController());

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    medicationController.loadMedications().then((_) {
      _updateFilteredMedications();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.animateToDate(_selectedDate);
      final Drug? newDrug = Get.arguments;
      if (newDrug != null &&
          !medicationController.medications.contains(newDrug)) {
        medicationController.addMedication(newDrug);
        _updateFilteredMedications();
      }
    });
  }

  void _onDateSelected(DateTime date) {
    if (_selectedDate != date) {
      setState(() {
        _selectedDate = date;
        _updateFilteredMedications();
      });
    }
  }

  void _updateFilteredMedications() {
    _cachedFilteredMeds = medicationController.medications
        .where((drug) => _shouldShowMedication(drug))
        .toList();

    // ✅ Print แค่ครั้งเดียวเมื่อ _selectedDate เปลี่ยน
    if (_lastPrintedDate == null || _lastPrintedDate != _selectedDate) {
      print("📅 Selected Date Changed: $_selectedDate");
      print("📋 Medications Count: ${_cachedFilteredMeds.length}");
      _lastPrintedDate = _selectedDate;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 73, 91, 227)),
      body: Column(
        children: [
          _addTaskBar(),
          const SizedBox(height: 10),
          _datePickerTimeline(),
          const SizedBox(height: 10),
          _medicationsList(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _addTaskBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat.yMMMMd().format(DateTime.now()),
                  style: GoogleFonts.lato(
                      fontSize: 16, fontWeight: FontWeight.w600)),
              const Text("Today",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              Drug newDrug = Drug();
              final result =
                  await Get.to(() => QuestionNameScreen(drug: newDrug));
              if (result != null && result is Drug) {
                medicationController.addMedication(result);
                _updateFilteredMedications();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
            child: const Text("เพิ่มรายการยา"),
          )
        ],
      ),
    );
  }

  Widget _datePickerTimeline() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: DatePicker(
        DateTime(DateTime.now().year, 1, 1),
        controller: _controller,
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.blue,
        selectedTextColor: Colors.white,
        onDateChange: _onDateSelected,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _medicationsList() {
    return Expanded(
      child: _cachedFilteredMeds.isEmpty
          ? Center(child: Text("No medications for this day."))
          : _buildMedicationsList(),
    );
  }

  Widget _buildMedicationsList() {
    return ListView.builder(
      itemCount: _cachedFilteredMeds.length,
      itemBuilder: (context, index) {
        final drug = _cachedFilteredMeds[index];

        return Card(
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            title: Text(drug.name ?? "No Name",
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle:
                Text("Times: ${drug.times?.join(", ") ?? "No schedule set"}"),
            trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    // ✅ ใช้ setState เพื่อบังคับให้ UI รีเฟรช
                    medicationController.medications.removeAt(index);
                    medicationController.saveMedications();
                    _updateFilteredMedications();
                  });
                }),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
        if (index == 0) Get.to(() => Categories());
        if (index == 1) Get.to(() => HomePage());
      },
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey[300],
      backgroundColor: const Color.fromARGB(255, 73, 91, 227),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.medical_services, size: 35), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.home, size: 35), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.person, size: 35), label: ""),
      ],
    );
  }

  bool _shouldShowMedication(Drug drug) {
    DateTime today = _selectedDate;
    int weekdayFlutter = today.weekday;

    if (drug.frequencydose == "Every day") return true;
    if (drug.selectedDays != null &&
        drug.selectedDays!.contains(weekdayFlutter)) return true;

    if (drug.intervalDays != null && drug.startDate != null) {
      int daysSinceStart = today.difference(drug.startDate!).inDays;
      return daysSinceStart % drug.intervalDays! == 0;
    }

    return false;
  }
}
