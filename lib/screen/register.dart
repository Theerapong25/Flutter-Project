import 'package:flutter/material.dart';
import 'login.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:final_project/model/register.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Register register = Register();// model register.dart  
  final _formKey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  CollectionReference usercollection = FirebaseFirestore.instance.collection('User');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
    future: firebase,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
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
                      top: 20,
                      left: 16,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Image.asset(
                            'images/Logo.png',
                            width: 140,
                            height: 140,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'ลงทะเบียน',
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
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFF5F5F5),
                            hintText: 'ชื่อผู้ใช้',
                            hintStyle: const TextStyle(
                              color: Color(0xFF666666),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'กรุณากรอกชื่อผู้ใช้'),
                          ]),
                          onSaved: (name) {
                            register.name = name!;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFF5F5F5),
                            hintText: 'อีเมล',
                            hintStyle: const TextStyle(
                              color: Color(0xFF666666),
                            ),
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
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFF5F5F5),
                            hintText: 'รหัสผ่าน',
                            hintStyle: const TextStyle(
                              color: Color(0xFF666666),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: MultiValidator([
                          MinLengthValidator(6,errorText: 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร'),
                          RequiredValidator(errorText: 'กรุณากรอกรหัสผ่าน'),]
                          ),
                          onSaved: (password) {
                            register.password = password!;
                          },
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              await usercollection.add({
                              "email":register.email,
                              "password":register.password,
                              "name":register.name
                            });

                              try {
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                      email: register.email!,
                                      password: register.password!,
                                    );

                                _formKey.currentState!.reset();

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              } on FirebaseAuthException catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.message ?? "error")),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8B0000),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 80,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'ลงทะเบียน',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
  }return const Center(child: CircularProgressIndicator());

      }
  );
  }
  }
  
