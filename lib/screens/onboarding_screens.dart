import 'dart:ui';

import 'package:edemadetection/screens/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  late final PageController _pageController;

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginView()),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController();
    super.initState();
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/Images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return SafeArea(
      child: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Colors.white,
        allowImplicitScrolling: true,
        autoScrollDuration: 3000,
        infiniteAutoScroll: true,
        globalHeader: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 10),
            child: _buildImage('app_logo.png', 50),
          ),
        ),
        globalFooter: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            child: const Text(
              'Let\'s go right away!',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold ,color: Colors.blue),
            ),
            onPressed: () => _onIntroEnd(context),
          ),
        ),
        pages: [
          PageViewModel(
            title: "Fractional shares",
            body:
            "Instead of having to buy an entire share, invest any amount you want.",
            image: _buildImage('image_1.jpg'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Learn as you go",
            body:
            "Download the Stockpile app and master the market with our mini-lesson.",
            image: _buildImage('doctor_consultation_vector.jpg'),
            decoration: pageDecoration,
          ),

          PageViewModel(
            title: "Kids and teens",
            body:
            "Kids and teens can track their stocks 24/7 and place trades that you approve.",
            image: _buildImage('image_3.jpg'),
            decoration: pageDecoration,
          ),

          PageViewModel(
            title: "Kids and teens",
            body:
            "Kids and teens can track their stocks 24/7 and place trades that you approve.",
            image: _buildImage('image_2.jpeg'),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        skipOrBackFlex: 0,
        nextFlex: 0,
        showBackButton: false,
        //rtl: true, // Display as right-to-left
        back: const Icon(Icons.arrow_back ,color: Colors.white,),
        skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
        next: const Icon(Icons.arrow_forward , color: Colors.white,),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600 , color: Colors.white)),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        controlsPadding: kIsWeb
            ? const EdgeInsets.all(12.0)
            : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}