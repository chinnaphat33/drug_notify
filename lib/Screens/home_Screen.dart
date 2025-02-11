import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:pill_reminder/Screens/Add_drag_Screen.dart/Q_Screen/Select_name_medication.dart.dart';
import 'package:pill_reminder/Screens/widget/button.dart';
import 'package:pill_reminder/Screens/Categories_Screen.dart';
import 'package:pill_reminder/Screens/Add_drag_Screen.dart/Q_Screen/ScheduleNotification.dart';
import 'package:pill_reminder/Controllers/ medication_controller.dart';
import 'Add_drag_Screen.dart/Q_drug_model/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _Homepage();
}

class _Homepage extends State<HomePage> {
  final DatePickerController _controller = DatePickerController();
  DateTime _selectedDate = DateTime.now();
  int _selectedIndex = 1;

  // ใช้ GetX Controller แทน List ทั่วไป
  final MedicationController medicationController =
      Get.put(MedicationController());

  void _confirmDeleteDrug(int index) {
    Get.defaultDialog(
        title: "Confirm Deletion",
        middleText: "Are you sure you want to delete this medication?",
        textConfirm: "Delete",
        textCancel: "Cancel",
        confirmTextColor: Colors.white,
        buttonColor: Colors.red,
        onConfirm: () {
          medicationController.medications.removeAt(index);
          medicationController.saveMedications();

          Get.back(); // ปิด Dialog หลังจากลบข้อมูล
        },
        onCancel: () => Get.off(() => HomePage()));
  }

  void initState() {
    super.initState();
    final MedicationController medicationController =
        Get.put(MedicationController());
    medicationController.loadMedications();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller != null) {
        _controller.animateToDate(DateTime.now());
      }

      // รับค่าจาก arguments ถ้ามี
      final Drug? newDrug = Get.arguments;
      if (newDrug != null) {
        medicationController.addMedication(newDrug);
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Get.to(() => Categories());
    } else if (index == 1) {
      Get.to(() => HomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 73, 91, 227),
      ),
      body: Column(
        children: [
          _addTaskBar(),
          const SizedBox(height: 10),
          _datePickerTimeline(),
          const SizedBox(height: 10),
          _medicationsList(), // เปลี่ยนมาใช้ GetX Observer
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[300],
        backgroundColor: const Color.fromARGB(255, 73, 91, 227),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services, size: 35),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 35),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 35),
            label: "",
          ),
        ],
      ),
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
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style:
                    GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const Text(
                "Today",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              Drug newDrug = Drug();
              final result =
                  await Get.to(() => QuestionNameScreen(drug: newDrug));

              if (result != null && result is Drug) {
                medicationController.addMedication(result);
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
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  Widget _medicationsList() {
    return Expanded(
        child: Obx(
      () => medicationController.medications.isEmpty
          ? Center(child: Text("No medications added."))
          : ListView.builder(
              itemCount: medicationController.medications.length,
              itemBuilder: (context, index) {
                final drug = medicationController.medications[index];

                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      drug.name ?? "No Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Times: ${drug.times != null && drug.times!.isNotEmpty ? drug.times!.join(", ") : "No schedule set"}",
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _confirmDeleteDrug(index);
                      },
                    ),
                    onTap: () async {
                      // เมื่อกดเข้าไปให้ไปที่หน้าแก้ไขยา
                      Drug? updatedDrug =
                          await Get.to(() => ScheduleNotification(drug: drug));

                      // อัปเดตค่าหากมีการเปลี่ยนแปลง
                      if (updatedDrug != null) {
                        setState(() {
                          medicationController.medications[index] = updatedDrug;
                        });
                      }
                    },
                  ),
                );
              },
            ),
    ));
  }
}
