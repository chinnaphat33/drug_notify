import 'package:flutter/material.dart';
import 'package:pill_reminder/font/theme.dart';
import 'package:get/get.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget; // กำหนด Widget เป็น optional

  const MyInputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // แสดง Title
          Text(
            title,
            style: titleStyle, // ใช้ Style ที่กำหนดจาก theme.dart
          ),
          Container(
              height: 52,
              margin: EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    autofocus: false,
                    controller: controller,
                    style: subtitleStyle,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: subtitleStyle,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide()
                      )
                    ),
                  ))
                ],
              )),
        ]));
  }
}
