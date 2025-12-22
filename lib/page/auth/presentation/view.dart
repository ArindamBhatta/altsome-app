import 'package:altsome_app/page/auth/presentation/widgets/scrollable_screen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<Map<String, String>> list = [
    {
      'caption': 'Track Your Wealth',
      'subCaption':
          'Real-time analytics and insights for your entire crypto portfolio.',
      'imageUrl': 'assets/onboarding/crypto_1.png',
    },
    {
      'caption': 'Bank-Grade Security',
      'subCaption':
          'Your assets are protected by state-of-the-art encryption and security protocols.',
      'imageUrl': 'assets/onboarding/crypto_2.png',
    },
    {
      'caption': 'Instant Transactions',
      'subCaption':
          'Send and receive crypto globally in seconds with low fees.',
      'imageUrl': 'assets/onboarding/crypto_3.png',
    },
    {
      'caption': 'Trade with Confidence',
      'subCaption':
          'Smart market insights to help you make informed investment decisions.',
      'imageUrl': 'assets/onboarding/crypto_4.png',
    },
  ];

  late PageController _pageController;
  late Timer _timer;
  int currentPage = 0; //* Update the dot indicator
  int nextPage = 0; //* Update the page Image
  late int _actualListLength;

  @override
  void initState() {
    super.initState();
    _actualListLength = list.length;
    _pageController = PageController();

//Listening Event of  scrolling
    _pageController.addListener(
      () {
        setState(() {
          currentPage =
              _pageController.page!.toInt(); //* Update the current page
        });
      },
    );

    _timer = Timer.periodic(
      const Duration(seconds: 4),
      (timer) async {
        nextPage = currentPage + 1;

        //* Check if we reached the last page
        if (nextPage == list.length) {
          setState(() {
            list.add(list[0]); //* Temporarily add the first item at the end
          }); //* Update the UI with the new list

          //* Animate to the temporary page smoothly
          await _pageController.animateToPage(
            nextPage,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );

          //* Reset to the actual first page without animation
          _pageController.jumpToPage(0);

          //* reset the page controller animation page
          nextPage = 0;

          //* Remove the temporary item
          list.removeLast();
        } else {
          //* Continue with normal page transition
          _pageController.animateToPage(
            nextPage,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  int get dotsLength => _actualListLength;
  int get currentDot => _actualListLength == currentPage ? 0 : currentPage;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: height * 0.8,
            child: Stack(
              children: [
                PageView(
                  controller: _pageController,
                  children: list.map((iterateItem) {
                    return ScrollableScreen(
                      caption: iterateItem['caption'] ?? '',
                      subCaption: iterateItem['subCaption'] ?? '',
                      imageUrl: iterateItem['imageUrl'] ?? '',
                    );
                  }).toList(),
                ),
                Positioned(
                  bottom: height * 0.2,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: DotsIndicator(
                      dotsCount: dotsLength,
                      position: (currentDot).toDouble(),
                      //* Limit to original items
                      decorator: DotsDecorator(
                        shape: const CircleBorder(
                          side: BorderSide(
                            color: Colors.teal,
                            width: 0.8,
                          ),
                        ),
                        color: Colors.white,
                        spacing: const EdgeInsets.all(8.0),
                        activeColor: Colors.white,
                        size: const Size(8.0, 8.0), // Size of inactive dots
                        activeSize:
                            const Size(40.0, 12.0), // Size of active dot
                        activeShape: RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.black, width: 0.1),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const SizedBox(height: 30),
          // Social Login Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSocialButton(
                  'assets/images/google_icon.png',
                  () {
                    // TODO: Implement Google Sign In
                  },
                ),
                _buildSocialButton(
                  'assets/images/facebook_icon.png',
                  () {
                    // TODO: Implement Facebook Sign In
                  },
                ),
                _buildSocialButton(
                  'assets/images/twitter_icon.png',
                  () {
                    // TODO: Implement Twitter Sign In
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(String assetName, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Image.asset(
          assetName,
          width: 32,
          height: 32,
        ),
      ),
    );
  }
}
