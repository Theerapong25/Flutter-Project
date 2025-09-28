import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/firebase_options.dart';
import 'package:final_project/model/detail.dart';
import 'package:final_project/screen/foodDetail.dart';
import 'favoritePage.dart';

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
  User? get user => FirebaseAuth.instance.currentUser;

  Future<void> addToFavorites(Map<String, dynamic> menu) async {
    if (user == null) return;

    final favRef = FirebaseFirestore.instance
        .collection("favorites")
        .doc(user!.email)
        .collection("items");

    await favRef.doc(menu["id"]).set({
      "name": menu["name"],
      "image": menu["image"],
      "kcal": menu["kcal"],
      "ingredients": menu["ingredients"],
      "method": menu["method"],
    });
  }
 Stream<DocumentSnapshot> favoriteStatus(String menuId) {
    return FirebaseFirestore.instance
        .collection("favorites")
        .doc(user!.email)
        .collection("items")
        .doc(menuId)
        .snapshots();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("เมนูทั้งหมด"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritePage()),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          // Search Box
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

          // All Menus
          Expanded(
            child: FutureBuilder<List<QuerySnapshot>>(
              future: Future.wait([
                FirebaseFirestore.instance.collection("ListFood").get(),
                FirebaseFirestore.instance.collection("Sweetie").get(),
                FirebaseFirestore.instance.collection("wrong").get(),
                FirebaseFirestore.instance.collection("Drink").get(),
              ]),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final alldocuments = snapshot.data!
                    .expand((querySnapshot) => querySnapshot.docs)
                    .where((doc) {
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
                  itemCount: alldocuments.length,
                  itemBuilder: (context, index) {
                    var document = alldocuments[index];
                    var data = document.data() as Map<String, dynamic>;
                    data["id"] = document.id;

                    DetailScreen food = DetailScreen(
                      name: data["name"],
                      image: data["image"],
                      ingredients: data["ingredients"],
                      method: data["method"],
                      kcal: data["kcal"],
                    );

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FooddetailScreen(food: food),
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
                              child: Image.asset(
                                data["image"],
                                fit: BoxFit.cover,
                                height: 120,
                                width: double.infinity,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                data['name'],
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2, 
                                overflow: TextOverflow.ellipsis, 
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text(
                              "${data['kcal']} kcal",
                              style: const TextStyle(fontSize: 13),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            
                            StreamBuilder<DocumentSnapshot>(
                            stream: favoriteStatus(data["id"]),
                            builder: (context, favSnapshot) {
                              final isFav =
                                  favSnapshot.data?.exists ?? false;

                              return IconButton(
                                icon: Icon(
                                  isFav
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                ),
                              onPressed: () async {
                                await addToFavorites(data);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "${data['name']} ถูกเพิ่มในรายการโปรด",
                                    ),
                                  ),
                                );
                              });
                            })
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
