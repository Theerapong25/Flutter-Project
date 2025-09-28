
import 'package:flutter/material.dart';

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
                          "หิวเมื่อไหร่ ก็เเวะมา",
                          style: TextStyle(
                            
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
                      color: const Color.fromARGB(211, 255, 255, 255),
                      borderRadius: BorderRadius.circular(12),
                     
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