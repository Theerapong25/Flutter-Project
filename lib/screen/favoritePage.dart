import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  User? get user => FirebaseAuth.instance.currentUser;

  /// ดึงข้อมูล favorites ของ user
  Stream<QuerySnapshot> getFavorites() {
  if (user == null) return const Stream.empty();
  return FirebaseFirestore.instance
      .collection("favorites")        
      .doc(user!.email)
      .collection("items")
      .snapshots();
}
/// ลบ 
Future<void> removeFavorite(String menuId) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  await FirebaseFirestore.instance
      .collection("favorites")        
      .doc(user.email)
      .collection("items")
      .doc(menuId)
      .delete();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Favorites")),
      body: StreamBuilder<QuerySnapshot>(
        stream: getFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("เกิดข้อผิดพลาดในการโหลด favorites"));
          }

          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) {
            return const Center(child: Text("ยังไม่มีเมนูโปรด"));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final menuId = docs[index].id;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: data["image"] != null
                      ? (data["image"].toString().startsWith('http')
                          ? Image.network(
                              data["image"],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 50),
                            )
                          : Image.asset(
                              data["image"],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ))
                      : const Icon(Icons.fastfood, size: 50),
                  title: Text(data["name"] ?? "-"),
                  subtitle: Text(
                    "Kcal: ${data["kcal"] ?? '-'}",
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("ลบจากรายการโปรด"),
                          content: const Text(
                              "คุณต้องการลบเมนูนี้ออกจากรายการโปรดหรือไม่?"),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, false), // ยกเลิก
                              child: const Text("ยกเลิก"),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, true), // ยืนยัน
                              child: const Text("ลบ"),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        await removeFavorite(menuId);
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
