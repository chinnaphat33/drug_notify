// auth_service.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pill_reminder/Database/Database_Helper.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/quickalert.dart';

class AuthService {
  /// ฟังก์ชันสำหรับ login
  Future signIn({
  required BuildContext context,
  required String identifier,
  required String password,
}) async {
  String url = "http://10.0.2.2/pill_reminder_login/login.php";
  final response = await http.post(Uri.parse(url), body: {
    'identifier': identifier,
    'password': password,
  });

  print("Response Status Code: ${response.statusCode}");
  print("Response Body: ${response.body}");

  if (response.statusCode == 200) {
    var data = json.decode(response.body);

    if (data['status'] == 'Error') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'] ?? "เข้าสู่ระบบไม่สำเร็จ")),
      );
    } else if (data['status'] == 'Success') {
      // แสดง QuickAlert
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'login Successful!',
      );

      // หน่วงเวลา 1 วินาทีก่อนเปลี่ยนหน้า
      await Future.delayed(const Duration(milliseconds: 2000));

      // ปิด QuickAlert ก่อนเปลี่ยนหน้า
      Navigator.pop(context);

      // เปลี่ยนหน้าไปยัง home
      Navigator.pushNamed(context, 'home');
    }
  } else {
    // กรณี Response Status Code ไม่ใช่ 200
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: ${response.statusCode}")),
    );
  }
}


Future<void> signup({
  required BuildContext context,
  required String nameTh,
  required String nameEn,
  required String sexTh,
  required String sexEn,
  required double weight,
  required double height,
  required String img,
  required String birthday,
  required String age,
  required String phone,
  required String email,
  required String addr,
  required String pass,
}) async {
  final dbHelper = DatabaseHelper.instance;

  try {
    // ตรวจสอบว่ามีผู้ใช้อยู่ในระบบแล้วหรือไม่
    final existingUser = await dbHelper.getUserByEmail(email);
    if (existingUser != null) {
      // แสดงข้อความแจ้งว่าอีเมลนี้มีอยู่แล้ว
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("อีเมลนี้มีผู้ใช้แล้ว")),
      );
      return;
    }

    // สร้างข้อมูลผู้ใช้ใหม่
  Map<String, dynamic> newUser = {
  'name_th': nameTh,
  'name_en': nameEn,
  'sex_th': sexTh,
  'sex_en': sexEn,
  'weight': weight,
  'height': height,
  'img': img,
  'birthday': birthday,
  'age': age,
  'phone': int.parse(phone),
  'email': email,
  'addr': addr,
  'password': pass, // เพิ่มค่านี้สำหรับเก็บรหัสผ่าน
};


    // เพิ่มข้อมูลผู้ใช้ลงในตาราง d_user
    await dbHelper.insertData(newUser, 'd_user');

    // แสดงข้อความสำเร็จ
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("สมัครสมาชิกสำเร็จ")),
    );

    // นำทางไปยังหน้า Login
    Navigator.pushNamed(context, 'login');
  } catch (e) {
    // จัดการข้อผิดพลาด
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("เกิดข้อผิดพลาด: $e")),
    );
  }
}
}
