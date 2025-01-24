import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pill_reminder/font/theme.dart';
import 'package:pill_reminder/Screens/widget/Input_feild.dart';

class AddDrug extends StatefulWidget {
  const AddDrug({Key? key}) : super(key: key);

  @override
  State<AddDrug> createState() => _AddDrug();
}

class _AddDrug extends State<AddDrug> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'เพิ่มรายการยา',
                style: HeadingStyle,
              ),
              MyInputField(title: "Title", hint: "Enter your title")

            ],
          ),
        ),
      ),
    );
  }
}
