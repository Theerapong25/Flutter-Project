import 'package:final_project/screen/allmenu.dart';
import 'package:final_project/screen/drink.dart';
import 'package:final_project/screen/snack.dart';
import 'package:final_project/screen/sweet.dart';
import 'package:flutter/material.dart';
import 'package:final_project/screen/setting.dart';
import 'package:final_project/screen/kcal.dart';
import 'package:final_project/screen/listfood.dart';
import 'package:final_project/model/popular.dart';


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
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.red[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าหลัก'),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'รายการอาหาร',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bolt),
            label: 'คำนวณแคลอรี่',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'ตั้งค่า'),
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
  late AnimationController _cardsController;
  late Animation<double> _headerAnimation;
  late Animation<double> _cardsAnimation;

  final List<PopularMenuItem> popularMenus = [
    PopularMenuItem(
      name: 'ผัดไทย',
      calories: '350 kcal',
      rating: 4.8,
      isRecommended: true,
    ),
    PopularMenuItem(
      name: 'ส้มตำ',
      calories: '120 kcal',
      rating: 4.9,
      isSpicy: true,
    ),
    PopularMenuItem(
      name: 'ข้าวผัดกุ้ง',
      calories: '420 kcal',
      rating: 4.7,
      isNew: true,
    ),
    PopularMenuItem(
      name: 'ต้มยำกุ้ง',
      calories: '180 kcal',
      rating: 4.9,
      isSpicy: true,
    ),
    PopularMenuItem(
      name: 'แกงเขียวหวาน',
      calories: '280 kcal',
      rating: 4.6,
      isSpicy: true,
    ),
    PopularMenuItem(
      name: 'ข้าวหมูแดง',
      calories: '450 kcal',
      rating: 4.5,
      isRecommended: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _cardsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _headerAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOutBack),
    );
    _cardsAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _cardsController, curve: Curves.elasticOut),
    );

    _headerController.forward();
    Future.delayed(
      const Duration(milliseconds: 300),
      () => _cardsController.forward(),
    );
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AnimatedHeader(animation: _headerAnimation),
          CategoriesSection(),
          PopularMenuSection(popularMenus: popularMenus),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

/// ----------------- Widget Header -----------------
class AnimatedHeader extends StatelessWidget {
  final Animation<double> animation;
  const AnimatedHeader({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Stack(
              children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      // กำหนดสีและจุดที่เริ่มจา
                      colors: [Colors.black, Colors.black, Colors.transparent],
                      stops: [0.0, 0.7, 1.0], // เริ่มจางที่ 70% ของความสูง
                    ).createShader(
                      Rect.fromLTRB(0, 0, rect.width, rect.height),
                    ); // ใช้ rect.width และ rect.height เพื่อให้ครอบคลุมทั้งภาพ
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image(image: AssetImage('images/backheard.jpg')),
                ),
                Positioned(
                  top: 50,
                  left: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "🍴 Kin A Raidee",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: scheme.primary.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "กินเก่า ได้ดี มีประโยชน์",
                          style: TextStyle(
                            color: scheme.onPrimary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // เวลามุมขวา
                Positioned(
                  top: 50,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(12),
                      backgroundBlendMode: BlendMode.overlay,
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.sunny, color: Colors.yellow, size: 24),
                        const SizedBox(height: 4),
                        Text(
                          "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
                          style: TextStyle(
                            color: scheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
      }

  }


class CategoriesSection extends StatelessWidget {
  CategoriesSection({super.key});

  final List<Map<String, dynamic>> categories = const [
    {'icon': Icons.rice_bowl, 'label': 'อาหารจานเดียว'},
    {'icon': Icons.local_drink, 'label': 'เครื่องดื่ม'},
    {'icon': Icons.icecream, 'label': 'ของหวาน'},
    {'icon': Icons.fastfood, 'label': 'ของว่าง'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'หมวดหมู่',
            style: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
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
                          style: TextStyle(color: Colors.grey[800]),
                        ),
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

/// ----------------- Widget PopularMenu -----------------
class PopularMenuSection extends StatelessWidget {
  final List<PopularMenuItem> popularMenus;
  const PopularMenuSection({super.key, required this.popularMenus});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'เมนูยอดนิยม',
            style: TextStyle(
              color: scheme.onSurface,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children:
                popularMenus.map((item) {
                  return Card(
                    color: scheme.surface,
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: scheme.primary.withOpacity(0.2),
                        child: const Icon(
                          Icons.fastfood,
                          color: Colors.deepPurple,
                          size: 30,
                        ),
                      ),
                      title: Text(
                        item.name,
                        style: TextStyle(
                          color: scheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${item.calories} | ⭐ ${item.rating}',
                        style: TextStyle(
                          color: scheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}



