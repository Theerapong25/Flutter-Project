import 'package:final_project/adminscreen/formsreen.dart';
import 'package:final_project/screen/allmenu.dart';
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
      length: 2,
      child: Scaffold(
        body: const TabBarView(
          children: [
            Formsreen(),
            AllScreen(),
          ],
        ),
        backgroundColor: Colors.amber,
        bottomNavigationBar: TabBar(tabs: [
          Tab(text: 'เพิ่มรายการอาหาร',),
          Tab(text: 'รายการอาหารทั้งหมด',)
        ]),
      ),
    );
  }
}