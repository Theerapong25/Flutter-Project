import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

//----------- Kcal Screen -----------------
class KcalScreen extends StatefulWidget {
  const KcalScreen({super.key});

  @override
  State<KcalScreen> createState() => _KcalScreenState();
}

class _KcalScreenState extends State<KcalScreen> {
  final TextEditingController foodController = TextEditingController();
  final TextEditingController kcalController = TextEditingController();

  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 1));

  List<Map<String, dynamic>> foodList = [];
  double totalKcal = 0;

  @override
  void dispose() {
    foodController.dispose();
    kcalController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void addFood() {
    try {
      if (foodController.text.isEmpty || kcalController.text.isEmpty) {
        throw Exception("กรอกไม่ครบ");
      }

      double kcal = double.parse(kcalController.text);

      setState(() {
        foodList.add({
          "name": foodController.text,
          "kcal": kcal,
        });
      });

      foodController.clear();
      kcalController.clear();
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("ข้อผิดพลาด", style: TextStyle(color: Colors.red)),
          content: const Text("กรุณากรอกข้อมูลให้ถูกต้อง"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("ปิด"),
            ),
          ],
        ),
      );
    }
  }

  void reset() {
    setState(() {
      foodList.clear();
      totalKcal = 0;
    });
  }

  void showTotal() {
    setState(() {
      totalKcal = foodList.fold(0, (sum, item) => sum + item["kcal"] as double);
    });

    _confettiController.play();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("ผลรวมแคลอรี่"),
        content: Text(
          "คุณกินไปทั้งหมด: $totalKcal kcal",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("ปิด"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        title: const Text(
          "คำนวณแคลอรี่จากอาหารที่กินเข้าไป",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(199, 183, 171, 58),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "assets/images/food.jpg",
                            height: size.width < 600 ? 150 : 200,
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: foodController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.fastfood,
                                color: Colors.deepPurple),
                            labelText: "ชื่ออาหาร",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: kcalController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.local_fire_department,
                                color: Colors.deepPurple),
                            labelText: "แคลอรี่ (kcal)",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: addFood,
                              icon: const Icon(Icons.add),
                              label: const Text("เพิ่มอาหาร"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: reset,
                              icon: const Icon(Icons.refresh),
                              label: const Text("รีเซต"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: showTotal,
                          icon: const Icon(Icons.summarize),
                          label: const Text("รวมแคลอรี่"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 152, 0),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "รายการอาหารที่กิน",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const Divider(),
                        ...foodList.map((item) => ListTile(
                              leading: const Icon(Icons.fastfood,
                                  color: Colors.deepPurple),
                              title: Text(item["name"]),
                              trailing: Text("${item["kcal"]} kcal"),
                            )),
                        const SizedBox(height: 20),
                        Text(
                          "รวมทั้งหมด: $totalKcal kcal",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [Colors.purple, Colors.deepPurple, Colors.pink],
              gravity: 0.3,
              emissionFrequency: 0.05,
            ),
          ),
        ],
      ),
    );
  }
}
