// validators.dart
import 'package:flutter/material.dart';


String? validateEmailOrPhone(String input) {
  
  String value = input.trim();

  
  if (value.isEmpty) {
    return 'โปรดกรอกข้อมูล';
  }

  
  if (value.contains('@')) {
    
    final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    if (!emailRegExp.hasMatch(value)) {
      return 'รูปแบบอีเมลของท่านไม่ถูกต้อง';
    }
  } else {
    
    final RegExp phoneRegExp = RegExp(r'^\d{10,15}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'รูปแบบเบอร์โทรของท่านไม่ถูกต้อง';
    }
  }

  return null;
}

/// Regular expression สำหรับตรวจสอบรูปแบบรหัสผ่าน
final RegExp passwordRegex = RegExp(
  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&_])[A-Za-z\d@$!%*?&_]{8,}$',
);

/// ตรวจสอบรหัสผ่าน
String? validatePassword(String passReg) {
  if (passReg.isEmpty) {
    return 'โปรดกรอกรหัสผ่าน';
  } else if (!passwordRegex.hasMatch(passReg)) {
    return 'รหัสผ่านต้องมีอย่างน้อย:\n'
        '1 ตัวอักษรเล็ก, 1 ตัวอักษรใหญ่,\n'
        '1 ตัวเลข, และ 1 ตัวอักษรพิเศษ';
  }
  return null;
}
