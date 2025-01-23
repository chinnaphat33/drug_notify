// auth_service.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    var data = json.decode(response.body);
    if (data == "Error") {
      Navigator.pushNamed(context, 'login');
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("เข้าสู่ระบบไม่สำเร็จ")));
    } else {
      Navigator.pushNamed(context, 'HomePage');
    }
  }
}
