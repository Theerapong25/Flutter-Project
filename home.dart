import 'package:final_project/screen/setting.dart';
import 'package:flutter/material.dart';
import 'package:final_project/screen/kcal.dart';
import 'package:final_project/screen/listfood.dart';
import 'package:final_project/model/popular.dart';

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


  final TextEditingController _searchTextController = TextEditingController();
  bool _isSearching = false;

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
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _cardsController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _headerAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOutBack));

    _cardsAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _cardsController, curve: Curves.elasticOut));

    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _cardsController.forward();
    });
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
          _buildAnimatedHeader(),
          _buildCategoriesSection(),
          _buildPopularMenuSection(),
          // _buildQuickActions(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildAnimatedHeader() {
    final scheme = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: _headerAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - _headerAnimation.value)),
          child: Opacity(
            opacity: _headerAnimation.value,
            child: Stack(
              children: [
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/11.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 50,
                  left: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [scheme.onPrimary, scheme.secondary],
                        ).createShader(bounds),
                        child: Text(
                          "🍴 Kin A Raidee",
                          style: TextStyle(
                            color: Colors.white38,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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

                Positioned(
                  top: 50,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: scheme.surface.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      // blur
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
            ),
          ),
        );
      },
    );
  }
  // ===== เพิ่มใน _HomeTabState =====

// หมวดหมู่เมนู
Widget _buildCategoriesSection() {
  final scheme = Theme.of(context).colorScheme;
  final categories = [
    {'icon': Icons.rice_bowl, 'label': 'อาหารจานเดียว'},
    {'icon': Icons.local_drink, 'label': 'เครื่องดื่ม'},
    {'icon': Icons.icecream,   'label': 'ของหวาน'},
    {'icon': Icons.fastfood,   'label': 'ของว่าง'},
  ];

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('หมวดหมู่',
            style: TextStyle(
              color: scheme.onSurface,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: categories.map((c) {
            return Column(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: scheme.primary.withOpacity(0.2),
                  child: Icon(c['icon'] as IconData, color: scheme.primary, size: 28),
                ),
                const SizedBox(height: 6),
                Text(c['label'] as String,
                    style: TextStyle(color: scheme.onSurface)),
              ],
            );
          }).toList(),
        ),
      ],
    ),
  );
}

// เมนูยอดนิยม
Widget _buildPopularMenuSection() {
  final scheme = Theme.of(context).colorScheme;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('เมนูยอดนิยม',
            style: TextStyle(
              color: scheme.onSurface,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 12),
        Column(
          children: popularMenus.map((item) {
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
                  child: const Icon(Icons.fastfood, color: Colors.deepPurple, size: 30),
                ),
                title: Text(item.name,
                    style: TextStyle(
                        color: scheme.onSurface,
                        fontWeight: FontWeight.bold)),
                subtitle: Text('${item.calories} | ⭐ ${item.rating}',
                    style: TextStyle(color: scheme.onSurface.withOpacity(0.7))),
              ));
          }).toList(),
        ),
      ],
    ),
  );
}

// ปุ่มลัดการทำงาน
// Widget _buildQuickActions() {
//   final scheme = Theme.of(context).colorScheme;
//   final actions = [
//     {'icon': Icons.favorite, 'label': 'เมนูโปรด'},
//     {'icon': Icons.history,  'label': 'ประวัติ'},
//     {'icon': Icons.shopping_cart, 'label': 'ตะกร้า'},
//   ];

//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('การทำงานด่วน',
//             style: TextStyle(
//               color: scheme.onSurface,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             )),
//         const SizedBox(height: 12),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: actions.map((a) {
//             return ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: scheme.primary,
//                 foregroundColor: scheme.onPrimary,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               ),
//               onPressed: () {},
//               icon: Icon(a['icon'] as IconData),
//               label: Text(a['label'] as String),
//             );
//           }).toList(),
//         ),
//       ],
//     ),
//   );
// }


  // --- ส่วนอื่น ๆ (Category, PopularMenu, BottomSheet) ---
  // 👉 ทุก container / text เปลี่ยน color: Colors.white/black
  //    เป็น Theme.of(context).colorScheme.surface / onSurface / primary ตามบริบท
  // 👉 ปุ่ม ElevatedButton ใช้ scheme.primary / scheme.onPrimary

  // … (โค้ดส่วนที่เหลือเหมือนเดิม แต่ปรับสีตามหลักนี้)
}

// Model


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late final List<Widget> _pages = [
    const HomeTab(),
    const FoodListScreen(),
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
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
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
