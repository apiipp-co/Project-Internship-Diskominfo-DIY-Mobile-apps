import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:JogjaIstimewa/Screens/Login-Signup/login_signup.dart';
import 'package:JogjaIstimewa/Screens/On_Board/on_board1.dart';
import 'package:JogjaIstimewa/Screens/On_Board/on_board2.dart';
import 'package:JogjaIstimewa/Screens/On_Board/on_board3.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class on_boarding extends StatefulWidget {
  const on_boarding({super.key});

  @override
  State<on_boarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<on_boarding> with SingleTickerProviderStateMixin {
  final PageController _controller = PageController();
  bool onLastPage = false;
  bool onFirstPage = true;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              const Color.fromARGB(255, 170, 255, 237).withOpacity(0.3),
              const Color.fromARGB(255, 3, 190, 150).withOpacity(0.1),
            ],
          ),
        ),
        child: Stack(
          children: [
            // PageView for onboarding screens
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  onLastPage = (index == 2);
                  onFirstPage = (index == 0);
                });
              },
              children: const [
                on_board1(),
                on_board2(),
                on_board3(),
              ],
            ),
            // Navigation controls
            Align(
              alignment: const Alignment(0, 0.85),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 96, 5, 5).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Previous Button (hidden on first page)
                      if (!onFirstPage)
                        _buildPreviousButton()
                      else
                        SizedBox(width: 30.w), // Empty space to maintain layout

                      // Page Indicator
                      SmoothPageIndicator(
                        controller: _controller,
                        count: 3,
                        effect: WormEffect(
                          spacing: 8.0,
                          radius: 10.0,
                          dotWidth: 12.0,
                          dotHeight: 12.0,
                          strokeWidth: 1.5,
                          dotColor: const Color.fromARGB(255, 0, 0, 0),
                          activeDotColor: const Color.fromARGB(255, 255, 0, 0),
                        ),
                      ),

                      // Next/Done Button
                      onLastPage
                          ? _buildDoneButton(context)
                          : _buildNextButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build the "Previous" button
  Widget _buildPreviousButton() {
    return GestureDetector(
      onTap: () {
        _controller.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 5.h,
        width: 30.w,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 255, 0, 0),
              Color.fromARGB(255, 255, 0, 0),
            ],
          ),
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 4.h,
                width: 4.w,
                child: Image.asset(
                  "lib/icons/arrow1.png", // Make sure you have this asset
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                "Previous",
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build the "Next" button with gradient and animation
  Widget _buildNextButton() {
    return GestureDetector(
      onTap: () {
        _controller.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 5.h,
        width: 30.w,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 255, 0, 0),
              Color.fromARGB(255, 255, 0, 0),
            ],
          ),
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 3, 190, 150).withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Next",
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(width: 2.w),
              SizedBox(
                height: 4.h,
                width: 4.w,
                child: Image.asset(
                  "lib/icons/arrow.png",
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build the "Done" button with gradient and animation
  Widget _buildDoneButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.bottomToTop,
            child: const login_signup(),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 5.h,
        width: 30.w,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 255, 0, 0),
              Color.fromARGB(255, 255, 0, 0),
            ],
          ),
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 0, 255, 200).withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Done",
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(width: 2.w),
              SizedBox(
                height: 4.h,
                width: 4.w,
                child: Image.asset(
                  "lib/icons/check.png",
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}