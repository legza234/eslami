import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const SebhaTab());
}

class SebhaTab extends StatelessWidget {
  const SebhaTab({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SebhaScreen(),
    );
  }
}

class SebhaScreen extends StatefulWidget {
  @override
  _SebhaScreenState createState() => _SebhaScreenState();
}

class _SebhaScreenState extends State<SebhaScreen> {
  int _counter = 0;
  int _highlightedBead = 0; // لتحديد الخرزة التي ستكبر
  final List<String> tasbeehPhrases = ["سبحان الله", "الحمد لله", "الله أكبر"];
  int currentPhraseIndex = 0;
  int beadCount = 33; // عدد الكرات

  void _incrementCounter() {
    setState(() {
      _counter++;

      // تحديد أي كُرة ستكبر
      _highlightedBead = _counter % beadCount;

      // عند الوصول إلى 30، إعادة العداد وتغيير الكلمة
      if (_counter % 30 == 0) {
        currentPhraseIndex = (currentPhraseIndex + 1) % tasbeehPhrases.length;
        _counter = 0; // تصفير العدد بعد كل 30 ضغطة
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double radius = 160; // نصف قطر السبحة

    return Scaffold(
      body: Stack(
        children: [
          // الخلفية
          Positioned.fill(
            child: Image.asset(
              "assets/images/Background.png", // صورة الخلفية
              fit: BoxFit.cover,
            ),
          ),

          // المحتوى الرئيسي
          Column(
            children: [
              const SizedBox(width: 30), // مسافة من الأعلى

              // اللوجو في الأعلى
              Center(
                child: Image.asset(
                  "assets/images/logo.png", // مسار اللوجو
                  width: 250,
                  height: 250,
                ),
              ),

              const SizedBox(height: 10), // مسافة تحت اللوجو

              // الجملة أعلى السبحة
              const Text(
                "سَبِّحِ اسْمَ رَبِّكَ الأعلى",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),

              const Spacer(),

              // السبحة والتسبيح مع صورة العلويّة
              Stack(
                alignment: Alignment.center,
                children: [
                  // صورة الجزء العلوي للسبحة (لاصقة بها)
                  Positioned(
                    top: -70, // تحريك الصورة لتكون فوق السبحة بدون مسافة
                    child: Image.asset(
                      "assets/images/topsebha.png",
                      width: 120,
                      height: 120,
                    ),
                  ),
                  GestureDetector(
                    onTap: _incrementCounter,
                    child: SizedBox(
                      width: 2 * radius + 70,
                      height: 2 * radius + 70,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // توزيع الكرات حول الدائرة
                          for (int i = 0; i < beadCount; i++)
                            Positioned(
                              left: radius + 25 +
                                  radius * cos((i / beadCount) * 2 * pi),
                              top: radius + 25 +
                                  radius * sin((i / beadCount) * 2 * pi),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: i == _highlightedBead ? 40 : 34,
                                // تكبير الكُرة المضغوطة
                                height: i == _highlightedBead ? 40 : 34,
                                child: Image.asset(
                                  "assets/images/Vector.png", // صورة الخرزة
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  // كلمة التسبيح في المنتصف (ثابتة لا تتحرك)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tasbeehPhrases[currentPhraseIndex],
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "$_counter",
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
