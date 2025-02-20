import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/asset_manager.dart';
import '../home/home.dart';

class IntroScreen extends StatefulWidget {
  static const String routeName = "intro"; // تعريف المسار

  const IntroScreen({super.key});

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> introPages = [
    {
      "image": "assets/images/welcom.png",
      "title": "Welcome To App",
      "subtitle": ""
    },
    {
      "image": "assets/images/masged.png",
      "title": "Welcome To Islami",
      "subtitle": "We Are Very Excited To Have You In Our Community"
    },
    {
      "image": "assets/images/qoran.png",
      "title": "Reading the Quran",
      "subtitle": "Read, and your Lord is the Most Generous"
    },
    {
      "image": "assets/images/hand.png",
      "title": "Bearish",
      "subtitle": "Praise the name of your Lord, the Most High"
    },
    {
      "image": "assets/images/mic.png",
      "title": "Holy Quran Radio",
      "subtitle":
          "You can listen to the Holy Quran Radio through the application for free and easily"
    },
  ];

  void _nextPage() {
    if (_currentIndex < introPages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _goToHome();
    }
  }

  void _goToHome() {
    Navigator.pushReplacementNamed(context, Home.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: introPages.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                decoration: const BoxDecoration(color: AppColors.black),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      width: 291, // حدد الحجم المناسب
                      height: 171,
                      fit: BoxFit.contain,
                    ),

                    const SizedBox(height: 20),
                    Image.asset(introPages[index]["image"]!,
                        width: 300, height: 300, fit: BoxFit.contain),
                    const SizedBox(height: 20),
                    Text(introPages[index]["title"]!,
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary)),
                    const SizedBox(height: 10),
                    Text(introPages[index]["subtitle"]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 20, color: AppColors.primary)),
                  ],
                ),
              );
            },
          ),

          // Dots Indicator
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                introPages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: _currentIndex == index ? 12 : 8,
                  height: _currentIndex == index ? 12 : 8,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? Colors.amber
                          : Colors.white54),
                ),
              ),
            ),
          ),

          // Navigation Buttons
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentIndex > 0)
                  TextButton(
                    onPressed: () => _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut),
                    child: const Text("Back",
                        style:
                            TextStyle(fontSize: 18, color: AppColors.primary)),
                  )
                else
                  const SizedBox(width: 60),
                TextButton(
                  onPressed: _nextPage,
                  child: Text(
                      _currentIndex == introPages.length - 1 ? "Start" : "Next",
                      style: const TextStyle(
                          fontSize: 18, color: AppColors.primary)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
