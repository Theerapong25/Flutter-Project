import 'package:final_project/screen/Header.dart';
import 'package:final_project/screen/allmenu.dart';
import 'package:final_project/screen/categoriesSection.dart';
import 'package:final_project/screen/popular.dart';
import 'package:flutter/material.dart';
import 'package:final_project/screen/setting.dart';
import 'package:final_project/screen/kcal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late final List<Widget> _pages = [
    const HomeTab(),
    const AllScreen(),
    const KcalScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, 
      children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor:  Color(0xFF8B0000),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), 
            label: 'หน้าหลัก'),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'รายการอาหาร',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bolt),
            label: 'คำนวณแคลอรี่',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu), 
            label: 'ตั้งค่า'),
        ],
      ),
    );
  }
}

/// ----------------- หน้า HomeTab -----------------
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with TickerProviderStateMixin {
  late AnimationController _headerController;
  late Animation<double> _headerAnimation;
  
  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _headerAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOutBack),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AnimatedHeader(animation: _headerAnimation),
          CategoriesSection(),
          PopularScreen(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}





