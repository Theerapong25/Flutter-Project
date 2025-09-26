import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class KcalScreen extends StatefulWidget {
  const KcalScreen({super.key});

  @override
  State<KcalScreen> createState() => _KcalScreenState();
}

class _KcalScreenState extends State<KcalScreen> {
  final List<Map<String, dynamic>> _selectedItems = [];
  Map<String, dynamic>? _selectedFood; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
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

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text("เลือกอาหาร"),
                        value: _selectedFood?['id'], // ใช้ id เป็น value
                        items:
                            allFoods.map((doc) {
                              final food = doc.data() as Map<String, dynamic>;
                              food['id'] = doc.id; // เก็บ id ลงใน map ด้วย
                              return DropdownMenuItem<String>(
                                value: doc.id, // ไม่ซ้ำแน่นอน
                                child: Text(
                                  "${food['name']} (${food['kcal']} kcal)",
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
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text("เพิ่มอาหาร"),
                        onPressed: _selectedFood == null
                            ? null
                            : () {
                                setState(() {
                                  _selectedItems.add(_selectedFood!);
                                  _selectedFood = null; 
                                });
                              },
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _selectedItems.length,
                          itemBuilder: (context, index) {
                            final item = _selectedItems[index];
                            return ListTile(
                              title: Text(item['name']),
                              subtitle: Text("${item['kcal']} kcal"),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    _selectedItems.removeAt(index);
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Total Calories
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Calories:", style: TextStyle(fontSize: 18)),
                Text(
                  "${_selectedItems.fold<double>(0, (sum, item) => sum + (double.tryParse(item['kcal'].toString()) ?? 0))} kcal",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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