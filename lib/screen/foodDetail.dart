
import 'package:flutter/material.dart';
class FoodDetailScreen extends StatelessWidget {
  final String name;
  final String image;
  final String ingredients;
  final String method;

  const FoodDetailScreen({
    super.key,
    required this.name,
    required this.image,
    required this.ingredients,
    required this.method,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image, fit: BoxFit.cover),
            const SizedBox(height: 20),
            Text("วัตถุดิบ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(ingredients),
            const SizedBox(height: 20),
            Text("วิธีทำ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(method),
          ],
        ),
      ),
    );
  }
}