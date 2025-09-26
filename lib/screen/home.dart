import 'package:final_project/screen/allmenu.dart';
import 'package:final_project/screen/drink.dart';
import 'package:final_project/screen/snack.dart';
import 'package:final_project/screen/sweet.dart';
import 'package:flutter/material.dart';
import 'package:final_project/screen/setting.dart';
import 'package:final_project/screen/kcal.dart';
import 'package:final_project/screen/listfood.dart';
import 'package:final_project/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



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
          PopularScreen(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
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
 const CategoriesSection({super.key});

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


class PopularScreen extends StatelessWidget {
  const PopularScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'เมนูเเนะนำ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 400,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('popura').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                var documents = snapshot.data!.docs;
                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    var document = documents[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            barrierColor: const Color.fromARGB(93, 131, 131, 131),
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: Text(
                                    document["name"],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ShaderMask(
                                          shaderCallback: (rect) {
                                            return LinearGradient(
                                              begin:
                                                  Alignment
                                                      .topCenter, // เริ่มจากด้านบน
                                              end:
                                                  Alignment
                                                      .bottomCenter, // จบที่ด้านล่าง
                                              // กำหนดสีและจุดที่เริ่มจาง
                                              colors: [
                                                Colors.black,
                                                Colors.black,
                                                Colors.transparent,
                                              ],
                                              stops: [
                                                0.0,
                                                0.7,
                                                1.0,
                                              ], // เริ่มจางที่ 70% ของความสูง
                                            ).createShader(
                                              Rect.fromLTRB(
                                                0,
                                                0,
                                                rect.width,
                                                rect.height,
                                              ),
                                            ); // ใช้ rect.width และ rect.height เพื่อให้ครอบคลุมทั้งภาพ
                                          },
                                          blendMode: BlendMode.dstIn,
                                          child: Image.asset(document["image"]),
                                        ),
                                        const SizedBox(height: 20),
                                        
                                        const Text(
                                          "วัตถุดิบ",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(document["ingredients"]),

                                        const SizedBox(height: 20),

                                        const Text(
                                          "วิธีทำ",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(document["method"]),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("ปิด"),
                                    ),
                                  ],
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
                              child: ShaderMask(
                                shaderCallback: (rect) {
                                  return LinearGradient(
                                    begin:
                                        Alignment.topCenter, // เริ่มจากด้านบน
                                    end:
                                        Alignment.bottomCenter, // จบที่ด้านล่าง
                                    // กำหนดสีและจุดที่เริ่มจาง
                                    colors: [
                                      Colors.black,
                                      Colors.black,
                                      Colors.transparent,
                                    ],
                                    stops: [
                                      0.0,
                                      0.7,
                                      1.0,
                                    ], // เริ่มจางที่ 70% ของความสูง
                                  ).createShader(
                                    Rect.fromLTRB(
                                      0,
                                      0,
                                      rect.width,
                                      rect.height,
                                    ),
                                  ); // ใช้ rect.width และ rect.height เพื่อให้ครอบคลุมทั้งภาพ
                                },
                                blendMode: BlendMode.dstIn,
                                child: Image.asset(
                                  document["image"],
                                  fit: BoxFit.cover,
                                  height: 150,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                document['name'],
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                document['kcal'] + " kcal",
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
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
     
    );
  }
}

