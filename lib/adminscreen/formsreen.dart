import 'package:final_project/model/inputmenu.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Formsreen extends StatefulWidget {
  const Formsreen({super.key});

  @override
  State<Formsreen> createState() => _FormsreenState();
}

class _FormsreenState extends State<Formsreen> {
  Inputmenu foodDetailScreen = Inputmenu(); // model inputmenu.dart
  final formkey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _foodCollection =
      FirebaseFirestore.instance.collection('ListFood');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('เพิ่มข้อมูลรายการ',style: TextStyle(color: Colors.white,)),
      backgroundColor: const Color(0xFF8B0000)),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('ชื่อ'),
                TextFormField(
                  onSaved: (String? name) {
                    foodDetailScreen.name = name;
                  },
                ),
                const SizedBox(height: 10),
                const Text('วัตถุดิบ'),
                TextFormField(
                  onSaved: (String? ingredients) {
                    foodDetailScreen.ingredients = ingredients;
                  },
                ),
                const SizedBox(height: 10),
                const Text('วิธีทำ'),
                TextFormField(
                  onSaved: (String? method) {
                    foodDetailScreen.method = method;
                  },
                ),
                const SizedBox(height: 10),
                const Text('kcal'),
                TextFormField(
                  onSaved: (String? kcal) {
                    foodDetailScreen.kcal = kcal;
                  },
                ),
                const SizedBox(height: 10),
                const Text('รูปภาพ'),
                TextFormField(
                  onSaved: (String? image) {
                    foodDetailScreen.image = image;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B0000), 
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255), 
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    formkey.currentState!.save();
                    await _foodCollection.add({
                      "name": foodDetailScreen.name,
                      "ingredients": foodDetailScreen.ingredients,
                      "method": foodDetailScreen.method,
                      "kcal": foodDetailScreen.kcal,
                      "image": foodDetailScreen.image,
                    });
                    formkey.currentState!.reset();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("บันทึกข้อมูลสำเร็จ"),
                        backgroundColor: Color.fromARGB(255, 0, 255, 4), 
                      ),
                    );
                  },
                  child: const Text(
                    'บันทึกข้อมูล',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class FormsreenSweet extends StatefulWidget {
  const FormsreenSweet({super.key});

  @override
  State<FormsreenSweet> createState() => _FormsreenSweetState();
}

class _FormsreenSweetState extends State<FormsreenSweet> {
  Inputmenu foodDetailScreen = Inputmenu(); // model inputmenu.dart
  final formkey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _foodCollection =
      FirebaseFirestore.instance.collection('Sweetie');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('เพิ่มข้อมูลรายการ',style: TextStyle(color: Colors.white,)),
      backgroundColor: const Color(0xFF8B0000)),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('ชื่อ'),
                TextFormField(
                  onSaved: (String? name) {
                    foodDetailScreen.name = name;
                  },
                ),
                const SizedBox(height: 10),
                const Text('วัตถุดิบ'),
                TextFormField(
                  onSaved: (String? ingredients) {
                    foodDetailScreen.ingredients = ingredients;
                  },
                ),
                const SizedBox(height: 10),
                const Text('วิธีทำ'),
                TextFormField(
                  onSaved: (String? method) {
                    foodDetailScreen.method = method;
                  },
                ),
                const SizedBox(height: 10),
                const Text('kcal'),
                TextFormField(
                  onSaved: (String? kcal) {
                    foodDetailScreen.kcal = kcal;
                  },
                ),
                const SizedBox(height: 10),
                const Text('รูปภาพ'),
                TextFormField(
                  onSaved: (String? image) {
                    foodDetailScreen.image = image;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B0000), 
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255), 
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    formkey.currentState!.save();
                    await _foodCollection.add({
                      "name": foodDetailScreen.name,
                      "ingredients": foodDetailScreen.ingredients,
                      "method": foodDetailScreen.method,
                      "kcal": foodDetailScreen.kcal,
                      "image": foodDetailScreen.image,
                    });
                    formkey.currentState!.reset();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("บันทึกข้อมูลสำเร็จ"),
                        backgroundColor: Color.fromARGB(255, 0, 255, 4), 
                      ),
                    );
                  },
                  child: const Text(
                    'บันทึกข้อมูล',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class Formsreensnack extends StatefulWidget {
  const Formsreensnack({super.key});

  @override
  State<Formsreensnack> createState() => _FormsreensnackState();
}

class _FormsreensnackState extends State<Formsreensnack> {
  Inputmenu foodDetailScreen = Inputmenu(); // model inputmenu.dart
  final formkey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _foodCollection =
      FirebaseFirestore.instance.collection('wrong');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('เพิ่มข้อมูลรายการ',style: TextStyle(color: Colors.white,)),
      backgroundColor: const Color(0xFF8B0000)),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('ชื่อ'),
                TextFormField(
                  onSaved: (String? name) {
                    foodDetailScreen.name = name;
                  },
                ),
                const SizedBox(height: 10),
                const Text('วัตถุดิบ'),
                TextFormField(
                  onSaved: (String? ingredients) {
                    foodDetailScreen.ingredients = ingredients;
                  },
                ),
                const SizedBox(height: 10),
                const Text('วิธีทำ'),
                TextFormField(
                  onSaved: (String? method) {
                    foodDetailScreen.method = method;
                  },
                ),
                const SizedBox(height: 10),
                const Text('kcal'),
                TextFormField(
                  onSaved: (String? kcal) {
                    foodDetailScreen.kcal = kcal;
                  },
                ),
                const SizedBox(height: 10),
                const Text('รูปภาพ'),
                TextFormField(
                  onSaved: (String? image) {
                    foodDetailScreen.image = image;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B0000), 
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255), 
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    formkey.currentState!.save();
                    await _foodCollection.add({
                      "name": foodDetailScreen.name,
                      "ingredients": foodDetailScreen.ingredients,
                      "method": foodDetailScreen.method,
                      "kcal": foodDetailScreen.kcal,
                      "image": foodDetailScreen.image,
                    });
                    formkey.currentState!.reset();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("บันทึกข้อมูลสำเร็จ"),
                        backgroundColor: Color.fromARGB(255, 0, 255, 4), 
                      ),
                    );
                  },
                  child: const Text(
                    'บันทึกข้อมูล',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class FormsreenDrink extends StatefulWidget {
  const FormsreenDrink({super.key});

  @override
  State<FormsreenDrink> createState() => _FormsreenDrinkState();
}

class _FormsreenDrinkState extends State<FormsreenDrink> {
  Inputmenu foodDetailScreen = Inputmenu(); // model inputmenu.dart
  final formkey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _foodCollection =
      FirebaseFirestore.instance.collection('Drink');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('เพิ่มข้อมูลรายการ',style: TextStyle(color: Colors.white,)),
      backgroundColor: const Color(0xFF8B0000)),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('ชื่อ'),
                TextFormField(
                  onSaved: (String? name) {
                    foodDetailScreen.name = name;
                  },
                ),
                const SizedBox(height: 10),
                const Text('วัตถุดิบ'),
                TextFormField(
                  onSaved: (String? ingredients) {
                    foodDetailScreen.ingredients = ingredients;
                  },
                ),
                const SizedBox(height: 10),
                const Text('วิธีทำ'),
                TextFormField(
                  onSaved: (String? method) {
                    foodDetailScreen.method = method;
                  },
                ),
                const SizedBox(height: 10),
                const Text('kcal'),
                TextFormField(
                  onSaved: (String? kcal) {
                    foodDetailScreen.kcal = kcal;
                  },
                ),
                const SizedBox(height: 10),
                const Text('รูปภาพ'),
                TextFormField(
                  onSaved: (String? image) {
                    foodDetailScreen.image = image;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B0000), 
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255), 
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    formkey.currentState!.save();
                    await _foodCollection.add({
                      "name": foodDetailScreen.name,
                      "ingredients": foodDetailScreen.ingredients,
                      "method": foodDetailScreen.method,
                      "kcal": foodDetailScreen.kcal,
                      "image": foodDetailScreen.image,
                    });
                    formkey.currentState!.reset();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("บันทึกข้อมูลสำเร็จ"),
                        backgroundColor: Color.fromARGB(255, 0, 255, 4), 
                      ),
                    );
                  },
                  child: const Text(
                    'บันทึกข้อมูล',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

