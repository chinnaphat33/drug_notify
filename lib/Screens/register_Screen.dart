import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:pill_reminder/function/validate.dart';
import 'package:pill_reminder/function/auth_service.dart';
import 'package:pill_reminder/font/theme.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  final TextEditingController nameThController = TextEditingController();
  final TextEditingController nameEnController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController sexThController = TextEditingController();
  final TextEditingController sexEnController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController imgController =
      TextEditingController(); // สำหรับรูปภาพ (ถ้ายังไม่มีค่า ให้เก็บเป็นค่าว่าง)
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otherController =
      TextEditingController(); // ฟิลด์อื่นๆ (optional)
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telController = TextEditingController();
  final TextEditingController addrController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Register',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 43, 12, 221),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 350,
                    child: Stack(
                      children: [
                        TextFormField(
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'ชื่อ (ไทย)',
                            labelStyle: TextStyle(
                              color: Colors.grey, // สีปกติของ label
                            ),
                            floatingLabelStyle: TextStyle(
                              color: blueBorder, // สีของ label เมื่อ focus
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: blueBorder,
                                width: 2,
                              ),
                            ),
                            suffixIcon: nameThController.text.isEmpty
                                ? null
                                : IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      nameThController.clear();
                                    }),
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'โปรดกรอกข้อมูล';
                            }
                            return null;
                          },
                          controller: nameThController,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 350,
                    child: Stack(
                      children: [
                        TextFormField(
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'ชื่อ (อังกฤษ) ',
                            labelStyle: TextStyle(
                              color: Colors.grey, // สีปกติของ label
                            ),
                            floatingLabelStyle: TextStyle(
                              color: blueBorder, // สีของ label เมื่อ focus
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: blueBorder,
                              ),
                            ),
                            suffixIcon: nameEnController.text.isEmpty
                                ? null
                                : IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      nameEnController.clear();
                                    }),
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'โปรดกรอกข้อมูล';
                            }
                            return null;
                          },
                          controller: nameEnController,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      readOnly: true, // ป้องกันการพิมพ์ในช่อง
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'birthday',
                        labelStyle: TextStyle(
                          color: Colors.grey, // สีปกติของ label
                        ),
                        floatingLabelStyle: TextStyle(
                          color: blueBorder, // สีของ label เมื่อ focus
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: blueBorder,
                          ),
                        ),
                      ),
                      controller: birthdayController,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900), // วันที่เริ่มต้นเลือกได้
                          lastDate: DateTime.now(), // วันที่สิ้นสุดเลือกได้
                        );
                        if (pickedDate != null) {
                          // ถ้ามีวันที่ถูกเลือก ให้แปลงเป็น String แล้วใส่ใน controller
                          birthdayController.text =
                              "${pickedDate.toLocal()}".split(' ')[0];
                        }
                      },
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'โปรดกรอกข้อมูล'
                          : null,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 170,
                        child: TextFormField(
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'age',
                            labelStyle: TextStyle(
                              color: Colors.grey, // สีปกติของ label
                            ),
                            floatingLabelStyle: TextStyle(
                              color: blueBorder, // สีของ label เมื่อ focus
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: blueBorder,
                              ),
                            ),
                          ),
                          validator: (value) => (value == null || value.isEmpty)
                              ? 'โปรดกรอกข้อมูล'
                              : null,
                          keyboardType: TextInputType.numberWithOptions(),
                          controller: ageController,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 170,
                        child: TextFormField(
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'img',
                            labelStyle: TextStyle(
                              color: Colors.grey, // สีปกติของ label
                            ),
                            floatingLabelStyle: TextStyle(
                              color: blueBorder, // สีของ label เมื่อ focus
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: blueBorder,
                              ),
                            ),
                          ),
                          validator: (value) => (value == null || value.isEmpty)
                              ? 'โปรดกรอกข้อมูล'
                              : null,
                          controller: imgController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 170,
                        child: TextFormField(
                          readOnly: true, // ป้องกันการพิมพ์ในช่อง
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'sex (en)',
                            labelStyle: TextStyle(
                              color: Colors.grey, // สีปกติของ label
                            ),
                            floatingLabelStyle: TextStyle(
                              color: blueBorder, // สีของ label เมื่อ focus
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: blueBorder,
                              ),
                            ),
                          ),
                          controller: sexEnController,
                          onTap: () async {
                            // ตัวเลือกเพศ
                            List<String> genderOptions = [
                              'Male',
                              'Female',
                              'LGBTQ+'
                            ];

                            // แสดง wheel picker
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 250,
                                  child: Column(
                                    children: [
                                      // ปุ่มยืนยัน

                                      Expanded(
                                        child: CupertinoPicker(
                                          itemExtent:
                                              40, // ความสูงของแต่ละตัวเลือก
                                          onSelectedItemChanged: (int index) {
                                            // อัปเดตค่าใน TextFormField
                                            sexEnController.text =
                                                genderOptions[index];
                                          },
                                          children: genderOptions
                                              .map((gender) =>
                                                  Center(child: Text(gender)))
                                              .toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          validator: (value) => (value == null || value.isEmpty)
                              ? 'โปรดกรอกข้อมูล'
                              : null,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 170,
                        child: TextFormField(
                          readOnly: true, // ป้องกันการพิมพ์ในช่อง
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'sex (th)',
                            labelStyle: TextStyle(
                              color: Colors.grey, // สีปกติของ label
                            ),
                            floatingLabelStyle: TextStyle(
                              color: blueBorder, // สีของ label เมื่อ focus
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: blueBorder,
                              ),
                            ),
                          ),
                          controller: sexThController,
                          onTap: () async {
                            // ตัวเลือกเพศ
                            List<String> genderOptions = [
                              'ชาย',
                              'หญิง',
                              'LGBTQ+'
                            ];

                            // แสดง wheel picker
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 250,
                                  child: Column(
                                    children: [
                                      // ปุ่มยืนยัน

                                      Expanded(
                                        child: CupertinoPicker(
                                          itemExtent:
                                              40, // ความสูงของแต่ละตัวเลือก
                                          onSelectedItemChanged: (int index) {
                                            // อัปเดตค่าใน TextFormField
                                            sexThController.text =
                                                genderOptions[index];
                                          },
                                          children: genderOptions
                                              .map((gender) =>
                                                  Center(child: Text(gender)))
                                              .toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          validator: (value) => (value == null || value.isEmpty)
                              ? 'โปรดกรอกข้อมูล'
                              : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 170,
                        child: TextFormField(
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'height(cm.)',
                            labelStyle: TextStyle(
                              color: Colors.grey, // สีปกติของ label
                            ),
                            floatingLabelStyle: TextStyle(
                              color: blueBorder, // สีของ label เมื่อ focus
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: blueBorder,
                              ),
                            ),
                          ),
                          validator: (value) => (value == null || value.isEmpty)
                              ? 'โปรดกรอกข้อมูล'
                              : null,
                          keyboardType: TextInputType.numberWithOptions(),
                          controller: heightController,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 170,
                        child: TextFormField(
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'weight(kg)',
                            labelStyle: TextStyle(
                              color: Colors.grey, // สีปกติของ label
                            ),
                            floatingLabelStyle: TextStyle(
                              color: blueBorder, // สีของ label เมื่อ focus
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: blueBorder,
                              ),
                            ),
                          ),
                          validator: (value) => (value == null || value.isEmpty)
                              ? 'โปรดกรอกข้อมูล'
                              : null,
                          keyboardType: TextInputType.numberWithOptions(),
                          controller: weightController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'email',
                        labelStyle: TextStyle(
                          color: Colors.grey, // สีปกติของ label
                        ),
                        floatingLabelStyle: TextStyle(
                          color: blueBorder, // สีของ label เมื่อ focus
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: blueBorder,
                          ),
                        ),
                        suffixIcon: Row(
                          mainAxisSize:
                              MainAxisSize.min, // ป้องกัน Row กินพื้นที่ทั้งหมด
                          children: [
                            if (emailController.text.isNotEmpty)
                              IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  emailController.clear();
                                },
                              ),
                          ],
                        ),
                      ),
                      validator: (val) => validateEmail(val ?? ''),
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'address',
                        labelStyle: TextStyle(
                          color: Colors.grey, // สีปกติของ label
                        ),
                        floatingLabelStyle: TextStyle(
                          color: blueBorder, // สีของ label เมื่อ focus
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: blueBorder,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 20, // เพิ่มความสูงในแนวตั้ง
                          horizontal: 10,
                        ),
                        suffixIcon: Row(
                          mainAxisSize:
                              MainAxisSize.min, // ป้องกัน Row กินพื้นที่ทั้งหมด
                          children: [
                            if (addrController.text.isNotEmpty)
                              IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  addrController.clear();
                                },
                              ),
                          ],
                        ),
                      ),
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'โปรดกรอกข้อมูล'
                          : null,
                      controller: addrController,
                    ),
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'อื่นๆ',
                        labelStyle: TextStyle(
                          color: Colors.grey, // สีปกติของ label
                        ),
                        floatingLabelStyle: TextStyle(
                          color: blueBorder, // สีของ label เมื่อ focus
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: blueBorder,
                          ),
                        ),
                        suffixIcon: Row(
                          mainAxisSize:
                              MainAxisSize.min, // ป้องกัน Row กินพื้นที่ทั้งหมด
                          children: [
                            if (otherController.text.isNotEmpty)
                              IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  otherController.clear();
                                },
                              ),
                          ],
                        ),
                      ),
                      controller: otherController,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 350,
                    child: Stack(
                      children: [
                        TextFormField(
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'phone number',
                            labelStyle: TextStyle(
                              color: Colors.grey, // สีปกติของ label
                            ),
                            floatingLabelStyle: TextStyle(
                              color: blueBorder, // สีของ label เมื่อ focus
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: blueBorder,
                                width: 2,
                              ),
                            ),
                            suffixIcon: phoneController.text.isEmpty
                                ? null
                                : IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      phoneController.clear();
                                    }),
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'โปรดกรอกข้อมูล';
                            }
                            return null;
                          },
                          controller: phoneController,
                          keyboardType: TextInputType.numberWithOptions(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: blueBorder,
                            width: 2,
                          ),
                        ),
                        suffixIcon: passController.text.isEmpty
                            ? null
                            : IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  passController.clear();
                                }),
                        labelText: 'passwords',
                        labelStyle: TextStyle(
                          color: Colors.grey, // สีปกติของ label
                        ),
                        floatingLabelStyle: TextStyle(
                          color: blueBorder, // สีของ label เมื่อ focus
                        ),
                      ),
                      // validator: (val) => validatePassword(val ?? ''),
                      controller: passController,
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       width: 8,
                  //     ),
                  //     SizedBox(
                  //       child: Text(
                  //         'หมายเหตุ: รหัสผ่านต้องมีอย่างน้อย 1 ตัวอักษรเล็ก, '
                  //         '1 ตัวอักษรใหญ่ \n1 ตัวเลข และ 1 ตัวอักษรพิเศษ',
                  //         style: TextStyle(
                  //           fontSize: 11,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: blueBorder,
                            width: 2,
                          ),
                        ),
                        labelText: 're-password',
                        labelStyle: TextStyle(
                          color: Colors.grey, // สีปกติของ label
                        ),
                        floatingLabelStyle: TextStyle(
                          color: blueBorder, // สีของ label เมื่อ focus
                        ),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'โปรดกรอกข้อมูล';
                        } else if (val != passController.text) {
                          return 'รหัสผ่านไม่ตรงกัน';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 350,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 26, 61, 99),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          // เรียกใช้ฟังก์ชัน sign_up ผ่าน AuthService
                          _authService.signup(
                            context: context,
                            nameTh: nameThController.text,
                            nameEn: nameEnController.text,
                            sexTh: sexThController.text,
                            sexEn: sexEnController.text,
                            pass: passController.text,
                            weight: double.parse(weightController.text),
                            height: double.parse(heightController.text),
                            img: imgController.text,
                            birthday: birthdayController.text,
                            age: ageController.text,
                            phone: phoneController.text,
                            email: emailController.text,
                            addr: addrController.text,
                          );
                        }
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
