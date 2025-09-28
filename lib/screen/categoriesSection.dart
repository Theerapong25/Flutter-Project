import 'package:final_project/screen/drink.dart';
import 'package:final_project/screen/listfood.dart';
import 'package:final_project/screen/snack.dart';
import 'package:final_project/screen/sweet.dart';
import 'package:flutter/material.dart';
class CategoriesSection extends StatelessWidget {
 const CategoriesSection({super.key});

  final List<Map<String, dynamic>> categories = const [
    {'icon': Icons.rice_bowl, 'label': 'อาหารจานเดียว'},
    {'icon': Icons.local_drink, 'label': 'เครื่องดื่ม'},
    {'icon': Icons.icecream, 'label': 'ของหวาน'},
    {'icon': Icons.fastfood, 'label': 'ของว่าง'},
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'หมวดหมู่',
            style: TextStyle(
              
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
                categories.map((c) {
                  return GestureDetector(
                    onTap: () {
                      Widget nextPage;
                      switch (c['label']) {
                        case 'อาหารจานเดียว':
                          nextPage = const FoodListScreen();
                          break;
                        case 'เครื่องดื่ม':
                          nextPage = const DrinkScreen();
                          break;
                        case 'ของหวาน':
                          nextPage = const SweetScreen();
                          break;
                        case 'ของว่าง':
                          nextPage = const SnackScreen();
                          break;
                        default:
                          nextPage = const FoodListScreen();
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => nextPage),
                      );
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Color(0xFF8B0000),
                          child: Icon(
                            c['icon'] as IconData,
                            color: const Color.fromARGB(255, 255, 255, 255),
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          c['label'] as String,
                         
                        )
                      ],
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}