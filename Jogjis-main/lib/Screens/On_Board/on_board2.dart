import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// Renamed to follow UpperCamelCase convention
class on_board2 extends StatefulWidget {
  const on_board2({super.key});

  @override
  State<on_board2> createState() => _OnBoard2State();
}

class _OnBoard2State extends State<on_board2> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeScaleAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize animation controller for image entrance
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOutCubic),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
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
              Color.fromARGB(255, 255, 50, 50),
              Color.fromARGB(255, 100, 10, 10),
              Color.fromARGB(255, 50, 5, 5).withOpacity(0.8),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Particle Animation Background
            Positioned.fill(
              child: ParticleBackground(),
            ),
            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Image with Glow
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.redAccent.withOpacity(0.4),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: FadeTransition(
                      opacity: _fadeScaleAnimation,
                      child: ScaleTransition(
                        scale: _fadeScaleAnimation,
                        child: Image.asset(
                          "images/onboarding1.png",
                          height: 45.h,
                          width: 80.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  // Enhanced Glassmorphism Container for Text
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(
                          width: 90.w,
                          padding: EdgeInsets.all(3.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.5),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [
                                    Colors.redAccent,
                                    Colors.orangeAccent,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ).createShader(bounds),
                                child: Text(
                                  "Jogja Up To Date & Notifikasi Istimewa",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.2),
                                        offset: const Offset(2, 2),
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              // Subtitle text removed as requested
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Enhanced Decorative Wave at the Bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomPaint(
                painter: EnhancedWavePainter(),
                child: SizedBox(
                  height: 15.h,
                  width: double.infinity,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Painter for the enhanced wave effect
class EnhancedWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.redAccent.withOpacity(0.4),
          Colors.orangeAccent.withOpacity(0.2),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.2,
      size.height * 1.1,
      size.width * 0.4,
      size.height * 0.6,
    );
    path.quadraticBezierTo(
      size.width * 0.6,
      size.height * 0.1,
      size.width * 0.8,
      size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.9,
      size.height * 0.8,
      size.width,
      size.height * 0.6,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Particle Animation Background
class ParticleBackground extends StatefulWidget {
  const ParticleBackground({super.key});

  @override
  _ParticleBackgroundState createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Particle> particles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    // Generate particles
    for (int i = 0; i < 50; i++) {
      particles.add(Particle());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        for (var particle in particles) {
          particle.update();
        }
        return CustomPaint(
          painter: ParticlePainter(particles),
          child: Container(),
        );
      },
    );
  }
}

class Particle {
  double x;
  double y;
  double size;
  double speedX;
  double speedY;
  Color color;

  Particle()
      : x = Random().nextDouble() * 1000,
        y = Random().nextDouble() * 1000,
        size = Random().nextDouble() * 2 + 1,
        speedX = (Random().nextDouble() - 0.5) * 2,
        speedY = (Random().nextDouble() - 0.5) * 2,
        color = Colors.white.withOpacity(Random().nextDouble() * 0.3 + 0.1);

  void update() {
    x += speedX;
    y += speedY;
    if (x < 0 || x > 1000) speedX = -speedX;
    if (y < 0 || y > 1000) speedY = -speedY;
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      final paint = Paint()..color = particle.color;
      canvas.drawCircle(
        Offset(particle.x * size.width / 1000, particle.y * size.height / 1000),
        particle.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}