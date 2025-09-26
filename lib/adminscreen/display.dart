import 'package:final_project/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllScreen extends StatefulWidget {
  const AllScreen({super.key});
  @override
  State<AllScreen> createState() => _AllListScreenState();
}

class _AllListScreenState extends State<AllScreen> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column (
        children: [
          SizedBox(height: 20),
          Text(
              "เมนูทั้งหมด",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
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
            child: FutureBuilder<List<QuerySnapshot>>( //เปลี่ยนเป็น FutureBuilder ที่ดึงข้อมูลจากหลายคอลเล็กชัน
              future : Future.wait([ //ใช้ Future.wait เพื่อรอผลลัพธ์จากหลายๆ คอลเล็กชัน
                FirebaseFirestore.instance.collection("ListFood").get(),
                FirebaseFirestore.instance.collection("Sweetie").get(),
                FirebaseFirestore.instance.collection("wrong").get(),
                FirebaseFirestore.instance.collection("Drink").get(), 
                  ]),  
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final alldocuments =
                    snapshot.data!.expand((querySnapshot)=>querySnapshot.docs).where((doc) {//ใช้ where แทน filter
                      final name = doc['name'].toString().toLowerCase();
                      return name.contains(searchQuery);
                    }).toList();

        return ListView.builder(
        itemCount: alldocuments.length,
        itemBuilder: (context, index) {
          var document = alldocuments[index];
          return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  document['image'],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                document['name'],
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(document['kcal'] + " kcal"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(document['name']),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(document['image']),
                          const SizedBox(height: 10),
                          const Text(
                            "วัตถุดิบ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(document['ingredients']),
                          const SizedBox(height: 10),
                          const Text(
                            "วิธีทำ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(document['method']),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("ปิด"),
                             ),
                    ],
                  ),
                );
              },
        );
          
        },
      );
    },
  ),
),
]),
);
}
  }
  