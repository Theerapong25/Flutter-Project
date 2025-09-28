import 'package:final_project/adminscreen/display.dart';
import 'package:final_project/adminscreen/formsreen.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: const Color(0xFF8B0000),
        body: const TabBarView(
          children: [
            Formsreen(),
            FormsreenSweet(),
            Formsreensnack(),
            FormsreenDrink(),
            AllScreens(),
          ],
        ),
        bottomNavigationBar: Container(
          color: const Color(0xFF8B0000),
          child: const TabBar(
            isScrollable: true, 
            tabs: [
              Tab(
                icon: Icon(Icons.restaurant_menu),
                text: 'อาหาร',
              ),
              Tab(
                icon: Icon(Icons.cake),
                text: 'ของหวาน',
              ),
              Tab(
                icon: Icon(Icons.local_drink),
                text: 'เครื่องดื่ม',
              ),
              Tab(
                icon: Icon(Icons.fastfood),
                text: 'ของทานเล่น',
              ),
              Tab(
                icon: Icon(Icons.list_alt),
                text: 'ทั้งหมด',
              ),
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
