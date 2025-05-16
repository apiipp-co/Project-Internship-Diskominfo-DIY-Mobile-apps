import 'dart:math';
// Untuk ImageShader
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Untuk HapticFeedback
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// Pastikan nama file dan kelas ini sudah diupdate
import 'package:JogjaIstimewa/Screens/Views/cctv_search.dart';

// --- Data Model ---
class CctvInfo {
  final String title;
  final String imagePath;
  final String date; // Mengganti 'latitude' dengan 'date'

  const CctvInfo({
    required this.title,
    required this.imagePath,
    required this.date,
  });
}

// --- Konstanta (Bisa dipisah ke file sendiri) ---
class AppCarouselStyles {
  static final BorderRadius cardBorderRadius = BorderRadius.circular(20.0);
  static const Duration animationDuration = Duration(milliseconds: 350);
  static const Curve animationCurve = Curves.easeInOutSine; // Kurva animasi yang lebih smooth

  static const List<Color> cardGradientColors = [
    Color.fromARGB(255, 220, 20, 60), // Crimson Red sedikit lebih gelap
    Color.fromARGB(255, 255, 69, 0),  // Red-Orange
  ];

   static const List<Color> playButtonGradientColors = [
    Colors.orangeAccent,
    Colors.deepOrange,
  ];

  static const BoxShadow cardShadow = BoxShadow(
    color: Color.fromARGB(100, 255, 0, 0), // Shadow merah transparan
    blurRadius: 18,
    offset: Offset(0, 6),
  );

   static const BoxShadow playButtonShadow = BoxShadow(
      color: Colors.orangeAccent,
      blurRadius: 12,
      offset: Offset(0, 4),
   );

  static TextStyle titleStyle = GoogleFonts.poppins(
    color: Colors.white,
    fontSize: 15.sp, // Sedikit lebih besar
    fontWeight: FontWeight.bold,
    shadows: const [
      Shadow(color: Colors.black54, blurRadius: 4, offset: Offset(0, 1)),
    ],
  );

  static TextStyle dateStyle = GoogleFonts.poppins(
    color: Colors.white.withOpacity(0.85), // Lebih terang sedikit
    fontSize: 12.sp,
    fontWeight: FontWeight.w500, // Medium weight
     shadows: const [
      Shadow(color: Colors.black45, blurRadius: 3, offset: Offset(0, 1)),
    ],
  );
}

// --- Widget Carousel Utama ---
class event_carousel extends StatefulWidget {
  const event_carousel({super.key});

  @override
  _EventCarouselState createState() => _EventCarouselState();
}

class _EventCarouselState extends State<event_carousel> with TickerProviderStateMixin {
  late PageController _pageController;
  double _currentPage = 2.0; // Tetap mulai dari tengah jika diinginkan

  // Data CCTV (sekarang menggunakan CctvInfo)
  // Sebaiknya data ini dimuat dari luar (misal: API atau state management)
  final List<CctvInfo> _cctvData = const [
    CctvInfo(
      title: "SIMPANG JOKTENG KULON (PTZ)",
      imagePath: "lib/icons/cctv1.jpeg",
      date: "Senin, 7 April 2025", // Contoh tanggal (seharusnya data dinamis)
    ),
    CctvInfo(
      title: "SIMPANG PKU MUH. (PTZ)",
      imagePath: "lib/icons/cctv3.jpeg",
      date: "Senin, 7 April 2025",
    ),
    CctvInfo(
      title: "NOL. KM-TIMUR",
      imagePath: "lib/icons/cctv2.jpeg",
      date: "Senin, 7 April 2025",
    ),
    CctvInfo(
      title: "JL. AHMAD JAZULI (K24)", // Disingkat
      imagePath: "lib/icons/cctv4.jpeg",
      date: "Senin, 7 April 2025",
    ),
    CctvInfo(
      title: "SIMPANG ATMOSUKARTO (PTZ)",
      imagePath: "lib/icons/cctv5.jpeg",
      date: "Senin, 7 April 2025",
    ),
  ];

  @override
  void initState() {
    super.initState();
    // ViewportFraction sedikit lebih kecil untuk efek 3D yang lebih terlihat
    _pageController = PageController(viewportFraction: 0.72, initialPage: 2);

    // Listener untuk update _currentPage
    _pageController.addListener(() {
      if (_pageController.page != null && mounted) {
        setState(() {
          _currentPage = _pageController.page!;
        });
      }
    });

    // Lompat ke halaman awal setelah frame pertama dibangun (jika diperlukan)
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (_pageController.hasClients) {
    //      _pageController.jumpToPage(2);
    //   }
    // });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28.h, // Sedikit lebih tinggi untuk efek 3D
      child: PageView.builder(
        controller: _pageController,
        itemCount: _cctvData.length,
        // Agar bisa scroll tak terbatas (opsional)
        // itemCount: null,
        // onPageChanged: (index) { ... }, // Jika menggunakan itemCount null
        itemBuilder: (context, index) {
          // Jika menggunakan itemCount: null, perlu modulo
          // final actualIndex = index % _cctvData.length;
          final actualIndex = index; // Gunakan ini jika itemCount terbatas

          // Calculate offset for parallax/rotation effect
          double offset = 0;
          if (_pageController.position.haveDimensions) {
             offset = _currentPage - actualIndex;
          }

          // Calculate scale based on distance from center
          // Scale down cards further away more significantly
          double scale = max(0.85, (1 - (offset.abs() * 0.15)));

          // Calculate rotation angle
          double angle = offset * (-pi / 10); // Adjust angle multiplier for desired effect

          return Transform.scale(
             scale: scale,
             child: Transform(
               transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // perspective
                ..rotateY(angle), // Rotate based on offset
               alignment: Alignment.center, // Rotate around the center
               child: CctvCard(
                 info: _cctvData[actualIndex],
                 // Menggunakan unique key jika ada masalah state pada pergeseran cepat
                 // key: ValueKey('cctv_${_cctvData[actualIndex].title}_$actualIndex'),
               ),
             ),
          );
        },
      ),
    );
  }
}

// --- Widget Kartu CCTV ---
class CctvCard extends StatefulWidget {
  final CctvInfo info;

  const CctvCard({
    super.key, // Menggunakan Key
    required this.info,
  });

  @override
  _CctvCardState createState() => _CctvCardState();
}

class _CctvCardState extends State<CctvCard> with TickerProviderStateMixin {
  bool _isTapped = false;
  late AnimationController _playButtonController;
  late Animation<double> _playButtonScale;
  late AnimationController _particleController; // Controller untuk partikel

  @override
  void initState() {
    super.initState();
    _playButtonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200), // Lebih cepat
      reverseDuration: const Duration(milliseconds: 300),
    );
    _playButtonScale = Tween<double>(begin: 1.0, end: 1.15).animate( // Sedikit lebih besar
      CurvedAnimation(parent: _playButtonController, curve: Curves.elasticOut), // Kurva elastic
    );

     // Controller untuk animasi partikel
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // Durasi animasi partikel
    )..repeat(); // Ulangi animasi
  }

  @override
  void dispose() {
    _playButtonController.dispose();
    _particleController.dispose(); // Jangan lupa dispose particle controller
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    HapticFeedback.lightImpact(); // Getaran halus saat ditekan
    if (mounted) {
      setState(() => _isTapped = true);
      _playButtonController.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (mounted) {
      setState(() => _isTapped = false);
      _playButtonController.reverse().whenComplete(() {
        // Navigasi *setelah* animasi selesai
         Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.scale, // Coba transisi Scale
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 400),
            child: const cctv_search(), // Pastikan nama kelas benar
          ),
        );
      });
    }
  }

  void _handleTapCancel() {
    if (mounted) {
      setState(() => _isTapped = false);
      _playButtonController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedScale(
        scale: _isTapped ? 0.97 : 1.0, // Sedikit scale down saat ditekan
        duration: const Duration(milliseconds: 150),
        curve: Curves.fastOutSlowIn,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 15), // Margin disesuaikan
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: AppCarouselStyles.cardGradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: AppCarouselStyles.cardBorderRadius,
            boxShadow: const [AppCarouselStyles.cardShadow],
            // Hapus border atau buat sangat halus jika diinginkan
            // border: Border.all(color: Colors.white10, width: 1),
          ),
          child: ClipRRect(
            borderRadius: AppCarouselStyles.cardBorderRadius,
            child: Stack(
              fit: StackFit.expand, // Stack mengisi seluruh area
              children: [
                // 1. Animated Particle Background
                Positioned.fill(
                  child: AnimatedBuilder(
                      animation: _particleController,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: ParticlePainter(animationValue: _particleController.value),
                        );
                      }),
                ),

                // 2. Gambar CCTV (dengan error handling)
                Positioned.fill(
                   // Animasi fade-in untuk gambar (jika diperlukan lebih eksplisit)
                   // child: FadeTransition(...)
                   child: Image.asset(
                     widget.info.imagePath,
                     fit: BoxFit.cover, // Cover agar mengisi area
                     // Fallback jika gambar gagal dimuat
                     errorBuilder: (context, error, stackTrace) => Container(
                       alignment: Alignment.center,
                       color: Colors.black38, // Warna background fallback
                       child: Icon(
                         Icons.videocam_off_outlined, // Icon outline
                         color: Colors.white60,
                         size: 15.w,
                       ),
                     ),
                  ),
                ),

                // 3. Overlay Gelap di Bawah untuk Teks
                 Positioned.fill(
                   child: Container(
                     decoration: BoxDecoration(
                       gradient: LinearGradient(
                         colors: [
                           Colors.black.withOpacity(0.6), // Lebih gelap di atas
                           Colors.black.withOpacity(0.0), // Transparan di tengah
                           Colors.black.withOpacity(0.0), // Transparan di tengah
                           Colors.black.withOpacity(0.6), // Lebih gelap di bawah (opsional)
                         ],
                         begin: Alignment.topCenter,
                         end: Alignment.bottomCenter,
                         stops: const [0.0, 0.4, 0.6, 1.0] // Kontrol persebaran gradient
                       ),
                     ),
                   ),
                 ),


                // 4. Tombol Play di Tengah
                Center(
                  child: ScaleTransition(
                    scale: _playButtonScale,
                    child: Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                           colors: AppCarouselStyles.playButtonGradientColors,
                            begin: Alignment.topLeft,
                           end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [AppCarouselStyles.playButtonShadow],
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded, // Ikon rounded
                        color: Colors.white,
                        size: 10.w,
                      ),
                    ),
                  ),
                ),

                // 5. Informasi Teks CCTV (di atas overlay)
                Positioned(
                  top: 15, // Padding dari atas
                  left: 15, // Padding dari kiri
                  right: 15, // Padding dari kanan (mencegah teks terlalu panjang)
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, // Agar kolom tidak memanjang
                    children: [
                      Text(
                        widget.info.title,
                        style: AppCarouselStyles.titleStyle,
                        maxLines: 2, // Batasi judul jadi 2 baris
                        overflow: TextOverflow.ellipsis, // Tampilkan ... jika terlalu panjang
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.info.date,
                        style: AppCarouselStyles.dateStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// --- Custom Painter untuk Partikel Bergerak ---
class Particle {
  Offset position;
  Color color;
  double radius;
  double speed;
  double angle; // Arah pergerakan

  Particle({
    required this.position,
    required this.color,
    required this.radius,
    required this.speed,
    required this.angle,
  });

   // Fungsi untuk mengupdate posisi partikel
  void update(Size bounds, double animationValue) {
     // Gerakkan partikel berdasarkan sudut dan kecepatan
     position += Offset(cos(angle), sin(angle)) * speed * 0.1; // Faktor perlambatan

     // Buat efek "warp" atau kembali jika keluar batas
     if (position.dx < -radius) position = Offset(bounds.width + radius, position.dy);
     if (position.dx > bounds.width + radius) position = Offset(-radius, position.dy);
     if (position.dy < -radius) position = Offset(position.dx, bounds.height + radius);
     if (position.dy > bounds.height + radius) position = Offset(position.dx, -radius);

     // (Opsional) Ubah radius atau opacity berdasarkan animationValue
     // radius = initialRadius * (1 + sin(animationValue * 2 * pi) * 0.1);
  }
}

class ParticlePainter extends CustomPainter {
  final double animationValue; // Nilai animasi (0.0 to 1.0) dari controller
  final List<Particle> particles;
  final Random random = Random();

  // Inisialisasi partikel hanya sekali
  ParticlePainter({required this.animationValue}) : particles = _createParticles();

  static List<Particle> _createParticles() {
    final random = Random();
    return List.generate(30, (index) { // Jumlah partikel
      return Particle(
        position: Offset(-1, -1), // Akan diinisialisasi dalam paint
        color: Colors.white.withOpacity(random.nextDouble() * 0.2 + 0.05), // Opacity acak
        radius: random.nextDouble() * 1.5 + 0.5, // Ukuran acak
        speed: random.nextDouble() * 0.5 + 0.2,   // Kecepatan acak
        angle: random.nextDouble() * 2 * pi,    // Sudut acak
      );
    });
  }


  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Inisialisasi posisi jika belum diatur (pertama kali paint)
    for (var particle in particles) {
       if (particle.position == const Offset(-1,-1)){
           particle.position = Offset(random.nextDouble() * size.width, random.nextDouble() * size.height);
       }

      // Update posisi partikel
      particle.update(size, animationValue);

      // Gambar partikel
      paint.color = particle.color;
      canvas.drawCircle(particle.position, particle.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) {
    // Hanya repaint jika nilai animasi berubah
    return oldDelegate.animationValue != animationValue;
  }
}