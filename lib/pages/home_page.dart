import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pill_reminder/font/theme.dart';
import 'package:pill_reminder/pages/widget/button.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _Homepage();
}

class _Homepage extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  var notifyHelper;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 73, 91, 227),
      ),
      body: Column(
        children: [
          _addTaskBar(),
          SizedBox(height: 10),
          _datePickerTimeline(),
          // เพิ่ม Widget อื่น ๆ ที่ต้องการ
        ],
      ),
    );
  }

  Widget _addTaskBar() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  "Today",
                  style: HeadingStyle,
                ),
              ],
            ),
          ),
          MyButton(label: "เพิ่มรายการ", onTap: () => null)
        ],
      ),
    );
  }

  Widget _datePickerTimeline() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: DatePicker(
        DateTime.now()
            .subtract(Duration(days: 7)), 
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        onDateChange: (date) {
          // เมื่อเลือกวันที่ใหม่
          setState(() {
            _selectedDate = date;
          });
          // ทำสิ่งที่ต้องการเมื่อเลือกวันที่ เช่น โหลดข้อมูลวันนั้น
        },
      ),
    );
  }
}
