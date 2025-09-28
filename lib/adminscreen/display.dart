import 'package:final_project/firebase_options.dart';
import 'package:final_project/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllScreens extends StatefulWidget {
  const AllScreens({super.key});
  @override
  State<AllScreens> createState() => _AllListScreenState();
}

class _AllListScreenState extends State<AllScreens> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          Text(
            "เมนูทั้งหมด",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(
                Icons.logout,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>  const LoginScreen())),
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
            child: FutureBuilder<List<QuerySnapshot>>(
              //เปลี่ยนเป็น FutureBuilder ที่ดึงข้อมูลจากหลายคอลเล็กชัน
              future: Future.wait([
                //ใช้ Future.wait เพื่อรอผลลัพธ์จากหลายๆ คอลเล็กชัน
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
                    snapshot.data!
                        .expand((querySnapshot) => querySnapshot.docs)
                        .where((doc) {
                          //ใช้ where แทน filter
                          final name = doc['name'].toString().toLowerCase();
                          return name.contains(searchQuery);
                        })
                        .toList();

                return ListView.builder(
                  itemCount: alldocuments.length,
                  itemBuilder: (context, index) {
                    var document = alldocuments[index];

                    return Dismissible(
                      key: Key(document.id), // ใช้ id ของเอกสาร Firestore
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      secondaryBackground: Container(
                        color: Colors.blue,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(Icons.edit, color: Colors.white),
                      ),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          // ✅ ลบ
                          final confirm = await showDialog(
                            context: context,
                            builder:
                                (_) => AlertDialog(
                                  title: const Text("ยืนยันการลบ"),
                                  content: Text(
                                    "คุณต้องการลบ ${document['name']} ใช่ไหม?",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed:
                                          () => Navigator.pop(context, false),
                                      child: const Text("ยกเลิก"),
                                    ),
                                    TextButton(
                                      onPressed:
                                          () => Navigator.pop(context, true),
                                      child: const Text("ลบ"),
                                    ),
                                  ],
                                ),
                          );
                          if (confirm == true) {
                            await document.reference.delete();
                            return true;
                          }
                          return false;
                        } else {
                          // ✅ อัพเดท
                          final controller = TextEditingController(
                            text: document['name'],
                          );
                          await showDialog(
                            context: context,
                            builder:
                                (_) => AlertDialog(
                                  title: const Text("แก้ไขชื่อเมนู"),
                                  content: TextField(
                                    controller: controller,
                                    decoration: const InputDecoration(
                                      labelText: "ชื่อใหม่",
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("ยกเลิก"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await document.reference.update({
                                          'name': controller.text,
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: const Text("บันทึก"),
                                    ),
                                  ],
                                ),
                          );
                          return false;
                        }
                      },
                      child: ListTile(
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
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text("${document['kcal']} kcal"),
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
