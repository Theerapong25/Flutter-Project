import 'package:final_project/firebase_options.dart';
import 'package:final_project/model/detail.dart';
import 'package:final_project/screen/foodDetail.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SnackScreen extends StatefulWidget {
  const SnackScreen ({super.key});
  @override
  State<SnackScreen > createState() => _SnackScreenState();
}
class _SnackScreenState extends State<SnackScreen > {
  final Future<FirebaseApp> firebase = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'รายการอาหาร',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w300,
          ),
        ),
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "ค้นหาเมนูอาหาร...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("wrong").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                var documents =
                    snapshot.data!.docs.where((doc) {
                      final name = doc['name'].toString().toLowerCase();
                      return name.contains(searchQuery);
                    }).toList();

                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    var document = documents[index];
                    DetailScreen food = DetailScreen(
                      name: document["name"],
                      image: document["image"],
                      ingredients: document["ingredients"],
                      method: document["method"],
                      kcal: document["kcal"],
                    );
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => FooddetailScreen(food: food),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              child: ShaderMask(
                                shaderCallback: (rect) {
                                  return LinearGradient(
                                    begin:
                                        Alignment.topCenter, // เริ่มจากด้านบน
                                    end:
                                        Alignment.bottomCenter, // จบที่ด้านล่าง
                                    // กำหนดสีและจุดที่เริ่มจาง
                                    colors: [
                                      Colors.black,
                                      Colors.black,
                                      Colors.transparent,
                                    ],
                                    stops: [
                                      0.0,
                                      0.7,
                                      1.0,
                                    ], // เริ่มจางที่ 70% ของความสูง
                                  ).createShader(
                                    Rect.fromLTRB(
                                      0,
                                      0,
                                      rect.width,
                                      rect.height,
                                    ),
                                  ); // ใช้ rect.width และ rect.height เพื่อให้ครอบคลุมทั้งภาพ
                                },
                                blendMode: BlendMode.dstIn,
                                child: Image.asset(
                                  document["image"],
                                  fit: BoxFit.cover,
                                  height: 140,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                document['name'],
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                document['kcal'] + " kcal",
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}