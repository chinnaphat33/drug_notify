import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:pill_reminder/Screens/add_drug.dart';
import 'package:pill_reminder/Screens/widget/button.dart';
import 'package:pill_reminder/Screens/Categories_Screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _Homepage();
}

class _Homepage extends State<HomePage> {
  final DatePickerController _controller = DatePickerController();
  DateTime _selectedDate = DateTime.now();
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      // ไปหน้าฐานข้อมูลยา
      Get.to(() => Categories()); // ตรวจสอบว่า Categories import มาจากไหน
    } else if (index == 1) {
      // หน้า HomePage (ไม่ต้องเปลี่ยนอะไร)
      Get.to(() => HomePage()); // หากต้องการเปลี่ยนกลับไปหน้า HomePage
    } else if (index == 2) {
      // ไปหน้าข้อมูลผู้ใช้
      // Get.to(() => UserProfileScreen()); // ตรวจสอบว่า UserProfileScreen import ถูกต้องหรือไม่
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller != null) {
        _controller.animateToDate(DateTime.now());
      }
    });
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
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.white, // สีไอคอนที่เลือก
        unselectedItemColor: Colors.grey[300], // สีไอคอนที่ไม่ได้เลือก
        backgroundColor:
            const Color.fromARGB(255, 73, 91, 227), // พื้นหลังสีน้ำเงิน
        showSelectedLabels: false, // ไม่แสดง Label สำหรับปุ่มที่เลือก
        showUnselectedLabels: false, // ไม่แสดง Label สำหรับปุ่มที่ไม่ได้เลือก
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.medical_services,
              size: 35,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 35,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 35,
            ),
            label: "",
          ),
        ],
      ),
    );
  }

  Widget _addTaskBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
        MyButton(label: "เพิ่มรายการ", onTap: () => Get.to(AddDrug()))
      ]),
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
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }
}
