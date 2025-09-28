import 'package:final_project/model/popular.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteIcon extends StatefulWidget {
  const FavoriteIcon({super.key,});

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  PopularMenuItem favorite = PopularMenuItem();
  bool _isFavorite = false;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _checkFavorite();
  }

  
  Future<void> _checkFavorite() async {
    if (user == null) return;

    final docRef = FirebaseFirestore.instance
        .collection("favoriter")
        .doc('${user!.email}_${favorite.listFoodId}');

    final snapshot = await docRef.get();
    setState(() {
      _isFavorite = snapshot.exists;
    });
  }

  /// กดหัวใจ -> toggle favorite
  Future<void> _toggleFavorite() async {
    if (user == null) return;

    final docRef = FirebaseFirestore.instance
        .collection("Fav")
        .doc('${user!.email}_${favorite.listFoodId}');

    final snapshot = await docRef.get();

    if (snapshot.exists) {
      await docRef.delete();
      setState(() {
        _isFavorite = false;
      });
    } else {
      await docRef.set({
        "ListFoodId": favorite.listFoodId,
        "name": favorite.name,
        "email": user!.email, // เฉพาะ user
        "ingredients": favorite.ingredients,
        "method": favorite.method,
        "image": favorite.image,
        "kcal": favorite.kcal,
        "createdAt": FieldValue.serverTimestamp(),
      });
      setState(() {
        _isFavorite = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite_border,
        color: _isFavorite ? Colors.red : Colors.grey,
      ),
      onPressed: _toggleFavorite,
    );
  }
}
