import 'package:final_project/adminscreen/adminSrceen.dart';
import 'package:final_project/model/register.dart';
import 'package:final_project/screen/register.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _adminemailController = TextEditingController(); 
  final _passwordController = TextEditingController();



  static const String _hardcodeEmailname = 'admin@gmail.com';
  static const String _hardcodePassword = '123456';
  

  Register register = Register();
  final _formKey = GlobalKey<FormState>();

  final Future<FirebaseApp> firebase = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  decoration: const BoxDecoration(
                    color: Color(0xFF8B0000),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(200),
                      bottomRight: Radius.circular(200),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  right: 16,
                  bottom: 50,
                  child: Column(
                    children: [
                      Image.asset('images/Logo.png', width: 140, height: 140),
                      const SizedBox(height: 10),
                      const Text(
                        'ยินดีต้อนรับ',
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _adminemailController, 
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFF5F5F5),
                        hintText: 'อีเมล',
                        hintStyle: const TextStyle(color: Color(0xFF666666)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'กรุณากรอกอีเมล'),
                        EmailValidator(errorText: 'รูปเเบบอีเมลไม่ถูกต้อง'),
                      ]),
                      onSaved: (email) {
                        register.email = email!;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController, 
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFF5F5F5),
                        hintText: 'รหัสผ่าน',
                        hintStyle: const TextStyle(color: Color(0xFF666666)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'กรุณากรอกรหัสผ่าน'),
                      ]),
                      onSaved: (password) {
                        register.password = password!;
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  try {
                    if (_adminemailController.text == _hardcodeEmailname &&
                        _passwordController.text == _hardcodePassword) {
                      if (mounted) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const AdminScreen(),
                          ),
                        );
                      }
                      return; 
                    }
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: register.email!,
                      password: register.password!,
                    );

                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('isLoggedIn', true);

                    if (mounted) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    }
                  } on FirebaseAuthException {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง'),
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B0000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 15,
                ),
                elevation: 5,
              ),
              child: const Text(
                'เข้าสู่ระบบ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'คุณยังไม่ได้สมัครสมาชิก ',
                  style: TextStyle(color: Color(0xFF666666), fontSize: 14),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'สมัครสมาชิก',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
