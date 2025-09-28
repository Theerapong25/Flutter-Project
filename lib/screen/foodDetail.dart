import 'package:final_project/model/detail.dart';
import 'package:flutter/material.dart';
class FooddetailScreen extends StatelessWidget {
  final DetailScreen food;

  const FooddetailScreen({super.key, required this.food});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title: Text(food.name ?? "")),
      body:Stack(
              clipBehavior: Clip.none,
              children: [ 
                SizedBox(
                height: 400,
                width: double.infinity,
                child: Image.asset(
                  food.image!, 
                  fit: BoxFit.cover)
                  ),
            Positioned(
              bottom: -350, 
              left: 0,
              right: 0,
               child: SizedBox(
              height: 400, 
              child: PageView(
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 240, 196, 1),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                    ),
                      child: ListView(
                        children: [
                          const Text(
                            "วัตถุดิบ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(food.ingredients ?? "",style: TextStyle(fontSize: 16),),
                        ],
                      ),
                    ),
                  
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 240, 196, 1),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                    ),
                      child: ListView(
                        children: [
                          const Text(
                            "วิธีทำ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(food.method ?? "",style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                        
                      ],
                    ),
                  ),
                
      )],
            ),
  );}}
          
        
      
    
  