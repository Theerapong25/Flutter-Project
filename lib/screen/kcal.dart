import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KcalScreen extends StatefulWidget {
  const KcalScreen({super.key});

  @override
  State<KcalScreen> createState() => _KcalScreenState();
}

class _KcalScreenState extends State<KcalScreen> {
  Map<String, dynamic>? _selectedFood;
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final theme = Theme.of(context);

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("กรุณาเข้าสู่ระบบก่อน")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "คำนวณแคลอรี่",
          style: TextStyle(
              
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.primaryColor.withOpacity(0.5),
                  width: 1.5,
                ),
              ),
              child: FutureBuilder<List<QuerySnapshot>>(
                future: Future.wait([
                  FirebaseFirestore.instance.collection("ListFood").get(),
                  FirebaseFirestore.instance.collection("Sweetie").get(),
                  FirebaseFirestore.instance.collection("wrong").get(),
                  FirebaseFirestore.instance.collection("Drink").get(),
                ]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }

                  final allFoods = snapshot.data!
                      .expand((querySnapshot) => querySnapshot.docs)
                      .toList();

                  return Row(
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: const Text("เลือกอาหาร"),
                          value: _selectedFood?['id'],
                          items: allFoods.map((doc) {
                            final food = doc.data() as Map<String, dynamic>;
                            food['id'] = doc.id;
                            return DropdownMenuItem<String>(
                              value: doc.id,
                              child: Text(
                                "${food['name']} (${food['kcal']} kcal)",
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedFood = allFoods
                                  .map((doc) {
                                    final food =
                                        doc.data() as Map<String, dynamic>;
                                    food['id'] = doc.id;
                                    return food;
                                  })
                                  .firstWhere((food) => food['id'] == value);
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text("เพิ่ม"),
                        onPressed: _selectedFood == null
                            ? null
                            : () async {
                                await FirebaseFirestore.instance
                                    .collection("kcal")
                                    .doc(user.email)
                                    .collection("items")
                                    .add({
                                  'name': _selectedFood!['name'],
                                  'kcal': _selectedFood!['kcal'],
                                });
                                setState(() {
                                  _selectedFood = null;
                                });
                              },
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // List of selected items
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("kcal")
                    .doc(user.email)
                    .collection("items")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final items = snapshot.data!.docs;

                  if (items.isEmpty) {
                    return Center(
                      child: Text("ยังไม่มีอาหารที่เลือก",
                          
                      ));
                  }

                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final data = items[index].data() as Map<String, dynamic>;
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 0),
                        child: ListTile(
                          title: Text(data['name'],
                              ),
                          subtitle: Text("${data['kcal']} kcal",
                              ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await items[index].reference.delete();
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            // Total Calories
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.primaryColor.withOpacity(0.5),
                  width: 1.5,
                ),
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("kcal")
                    .doc(user.email)
                    .collection("items")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Total Calories: 0 kcal",
                        );
                  }

                  final total = snapshot.data!.docs.fold<double>(0, (sum, doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return sum +
                        (double.tryParse(data['kcal'].toString()) ?? 0);
                  });

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Calories:", ),
                      Text("$total kcal",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
