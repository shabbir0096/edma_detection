import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:edemadetection/screens/login.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({Key? key}) : super(key: key);

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  final PageController _pageController = PageController(initialPage: 0);
  final List<Map<String, dynamic>> onboardingPages = [
    {
      "image": 'assets/Images/aimedical.jpg',
      "text": 'Monitor Your Health with Edema Detection',
    },
    {
      "image": 'assets/Images/consultation.jpg',
      "text": 'Monitor Your Health with Edema Detection',
    },
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
    return Scaffold(
  appBar: AppBar(
    backgroundColor: Colors.white,
    actions: [
      GestureDetector(
        onTap: () {
          // Navigate to the next screen when "SKIP" is clicked
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LoginView(), // Replace with your login screen
            ),
          );
        },
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'SKIP',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  ),
  body: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.blueGrey, Colors.deepPurple], // Replace with your desired gradient colors
      ),
    ),
    child: Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: onboardingPages.length,
            itemBuilder: (context, index) {
              return OnboardingPage(
                image: onboardingPages[index]['image'],
                text: onboardingPages[index]['text'],
              );
            },
          ),
        ),
      ],
    ),
  ),
);
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String text;

  const OnboardingPage({
    Key? key,
    required this.image,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Align content in the center
      children: [
        Image.asset(image),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
