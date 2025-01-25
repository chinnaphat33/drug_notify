// auth_service.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pill_reminder/Database/Database_Helper.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/quickalert.dart';

class AuthService {
  /// ฟังก์ชันสำหรับ login
  Future<void> signIn({
  required BuildContext context,
  required String identifier,
  required String password,
}) async {
  final dbHelper = DatabaseHelper.instance;

  try {
    // ค้นหาผู้ใช้จากอีเมลหรือเบอร์โทร
    final user = await dbHelper.getUserByEmailOrPhone(identifier);

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("ไม่พบผู้ใช้ในระบบ")),
      );
      return;
    }

    // ตรวจสอบรหัสผ่าน
    if (user['password'] != password) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("รหัสผ่านไม่ถูกต้อง")),
      );
      return;
    }

    // หากเข้าสู่ระบบสำเร็จ แสดง QuickAlert
    await QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: 'เข้าสู่ระบบสำเร็จ!',
    );

    // หน่วงเวลา 2 วินาทีก่อนเปลี่ยนหน้า
    await Future.delayed(const Duration(milliseconds: 500));

    // เปลี่ยนหน้าไปยังหน้า 'home'
    Navigator.pushNamed(context, 'home');
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("เกิดข้อผิดพลาด: $e")),
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
    // ตรวจสอบว่ามีผู้ใช้อยู่ในระบบแล้วหรือไม่ (อีเมลหรือเบอร์โทร)
    final existingEmail = await dbHelper.getUserByEmailOrPhone(email);
    final existingPhone = await dbHelper.getUserByEmailOrPhone(phone);

    if (existingEmail != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("อีเมลนี้มีผู้ใช้แล้ว")),
      );
      return;
    }

    if (existingPhone != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("เบอร์โทรนี้มีผู้ใช้แล้ว")),
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
    await QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'สำเร็จ',
      text: 'สมัครสมาชิกสำเร็จ!',
      autoCloseDuration:
          const Duration(seconds: 2), // ตั้งเวลาค้างไว้ 2 วินาที
    );

    // หลังจาก QuickAlert ปิด ให้ไปยังหน้า Login
    Navigator.pushNamed(context, 'login');
  } catch (e) {
    // จัดการข้อผิดพลาด
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("เกิดข้อผิดพลาด: $e")),
    );
  }
}

}
