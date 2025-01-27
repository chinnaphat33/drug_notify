import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pill_reminder/font/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:pill_reminder/function/validate.dart';
import 'package:pill_reminder/function/auth_service.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController pass = TextEditingController();
  TextEditingController identifier = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 200),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Login',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 43, 12, 221),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: blueBorder,
                          width: 2,
                        ),
                      ),
                      suffixIcon: identifier.text.isEmpty
                          ? null
                          : IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                identifier.clear();
                              },
                            ),
                      labelText: 'Tel./Email',
                      labelStyle: const TextStyle(color: Colors.grey),
                      floatingLabelStyle: const TextStyle(
                        color: blueBorder,
                      ),
                    ),
                    validator: (value) => validateEmailOrPhone(value ?? ''),
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    controller: identifier,
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 26, 61, 99),
                          width: 2,
                        ),
                      ),
                      suffixIcon: pass.text.isEmpty
                          ? null
                          : IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                pass.clear();
                              },
                            ),
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.grey),
                      floatingLabelStyle: const TextStyle(
                        color: Color.fromARGB(255, 26, 61, 99),
                      ),
                    ),
                    // validator: (val) => validatePassword(val ?? ''),
                    controller: pass,
                  ),
                ),
                const SizedBox(height: 30),
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
                        // final SharedPreferences sharedPreferences =
                        //     await SharedPreferences.getInstance();
                        // sharedPreferences.setString('email', identifier.text);
                        _authService.signIn(
                          context: context,
                          identifier: identifier.text,
                          password: pass.text,
                        );
                      }
                    },
                    child: const Text(
                      'เข้าสู่ระบบ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    // เมื่อกรอกข้อมูลถูกต้อง ส่ง OTP
                    Navigator.pushNamed(context, 'register');
                  },
                  child: const Text(
                    "สมัครสมาชิก",
                    style: TextStyle(
                      color: blueBorder,
                      decoration: TextDecoration.underline,
                      decorationColor: blueBorder,
                      decorationThickness: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
