// Import for ImageFilter (Meskipun tidak digunakan langsung di kode ini, baik untuk dimiliki jika diperlukan nanti)
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:animate_do/animate_do.dart';

// --- Banner Widget (Ditingkatkan) ---
class banner extends StatelessWidget { // Ubah nama kelas ke UpperCamelCase (konvensi Dart)
  const banner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Padding konsisten di seluruh aplikasi
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: FadeInUp(
        duration: const Duration(milliseconds: 800),
        child: Container(
          height: 22.h, // Tinggi banner
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              // Gradient modern yang menarik
              colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 79, 5, 5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20), // Radius sudut yang konsisten
            boxShadow: [
              BoxShadow(
                // Shadow yang lebih halus untuk efek kedalaman
                color: const Color.fromARGB(255, 255, 0, 0).withOpacity(0.35), // Sedikit lebih jelas
                blurRadius: 18, // Blur lebih besar
                offset: const Offset(0, 10), // Offset lebih jauh
                spreadRadius: -2, // Spread negatif agar shadow lebih terfokus di bawah
              ),
            ],
          ),
          child: ClipRRect( // Memastikan konten terpotong sesuai sudut rounded
            borderRadius: BorderRadius.circular(20),
            child: Stack( // Stack jika ingin menambahkan elemen background lain nanti
              children: [
                // Tambahkan pola background halus jika diinginkan (opsional)
                // Positioned.fill(
                //   child: Opacity(
                //     opacity: 0.05,
                //     child: Image.asset(
                //       'assets/images/abstract_pattern.png', // Ganti dengan pattern Anda
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Area Konten Kiri
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, top: 2.h, bottom: 2.h, right: 2.w), // Padding yg disesuaikan
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeInLeft( // Animasi tambahan untuk teks
                            delay: const Duration(milliseconds: 200), // Delay sedikit
                            duration: const Duration(milliseconds: 700),
                            child: Text(
                              "Temukan\nFitur-fitur",
                              style: GoogleFonts.poppins(
                                fontSize: 21.sp,
                                fontWeight: FontWeight.w700, // Bold
                                color: Colors.white,
                                height: 1.25, // Spasi antar baris
                                shadows: [ // Shadow teks halus
                                  Shadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 5,
                                    offset: const Offset(0, 2)
                                  )
                                ]
                              ),
                            ),
                          ),
                          SizedBox(height: 2.5.h), // Spasi konsisten
                          // Tombol yang diperbarui dengan Material & InkWell
                          FadeInUp( // Animasi tambahan untuk tombol
                             delay: const Duration(milliseconds: 400),
                             duration: const Duration(milliseconds: 700),
                             child: Material( // Dibutuhkan untuk efek splash InkWell
                              color: Colors.transparent, // Transparan agar gradient terlihat
                              child: InkWell(
                                onTap: () {
                                  // Navigasi ke halaman fitur
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      // Pastikan ModernFeaturesPage didefinisikan di tempat lain
                                      builder: (context) => const ModernFeaturesPage(),
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(12), // Radius konsisten
                                splashColor: Colors.white.withOpacity(0.3),
                                highlightColor: Colors.white.withOpacity(0.1),
                                child: Ink( // Gunakan Ink untuk dekorasi di dalam InkWell
                                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white, // Background tombol putih
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [ // Shadow halus untuk tombol
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        blurRadius: 10,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Row( // Tambahkan ikon pada tombol
                                    mainAxisSize: MainAxisSize.min, // Agar row tidak memenuhi lebar
                                    children: [
                                      Icon(Icons.explore_outlined, color: const Color(0xFF2575FC), size: 16.sp),
                                      SizedBox(width: 2.w),
                                      Text(
                                        "Jelajahi", // Teks tombol
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600, // Sedikit tebal
                                          color: const Color(0xFF2575FC), // Warna teks cocok dengan gradient
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Area Gambar Kanan
                    // Pastikan gambar ini relevan dan berkualitas baik
                    // Hindari GIF jika memungkinkan untuk performa & tampilan modern
                    SizedBox(
                       width: 38.w, // Lebar gambar disesuaikan
                       height: 22.h, // Tinggi sama dengan banner
                       child: ClipRRect( // Potong gambar sesuai sudut banner
                         borderRadius: const BorderRadius.only(
                           topRight: Radius.circular(20),
                           bottomRight: Radius.circular(20),
                         ),
                         child: Image.asset(
                           // GANTI DENGAN PATH GAMBAR STATIS YANG RELEVAN
                           "lib/icons/discussion.gif",
                           fit: BoxFit.cover, // Agar gambar menutupi area
                           // Optional: Tambahkan overlay gelap untuk blending
                           // color: Colors.black.withOpacity(0.1),
                           // blendMode: BlendMode.darken,
                           errorBuilder: (context, error, stackTrace) {
                             // Fallback jika gambar gagal dimuat
                             return Container(
                               color: Colors.grey.shade300,
                               child: Center(
                                   child: Icon(Icons.image_not_supported_outlined,
                                   color: Colors.grey.shade500, size: 30.sp)
                               ),
                             );
                           },
                         ),
                       ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// --- Halaman Fitur (Ditingkatkan) ---
class ModernFeaturesPage extends StatelessWidget {
  const ModernFeaturesPage({super.key});

  // Daftar fitur (bisa dipindah ke model atau file terpisah jika kompleks)
  static final List<Map<String, dynamic>> features = [
      {'title': 'CCTV', 'description': 'Pantau situasi DIY 24 jam.', 'icon': Icons.videocam_outlined, 'color': const Color(0xFF29B6F6)}, // Light Blue
      {'title': 'E-Lapor', 'description': 'Laporkan aduan ke Pemda.', 'icon': Icons.campaign_outlined, 'color': const Color(0xFFEF5350)}, // Red
      {'title': 'IDMC', 'description': 'Dashboard data target DIY.', 'icon': Icons.bar_chart_rounded, 'color': const Color(0xFF66BB6A)}, // Green
      {'title': 'E-Kelurahan', 'description': 'Akses layanan kelurahan.', 'icon': Icons.account_balance_outlined, 'color': const Color(0xFFAB47BC)}, // Purple
      {'title': 'Pajak Daerah', 'description': 'Cek & bayar pajak online.', 'icon': Icons.payment_outlined, 'color': const Color(0xFFFF7043)}, // Orange
      {'title': 'Info Bencana', 'description': 'Info terkini potensi bencana.', 'icon': Icons.warning_amber_rounded, 'color': const Color(0xFFFFCA28)}, // Yellow
      {'title': 'Kesehatan', 'description': 'Info faskes & jadwal.', 'icon': Icons.local_hospital_outlined, 'color': const Color(0xFFEC407A)}, // Pink
      {'title': 'Pariwisata', 'description': 'Jelajahi wisata & event.', 'icon': Icons.map_outlined, 'color': const Color(0xFF26A69A)}, // Teal
      {'title': 'Transportasi', 'description': 'Info transportasi umum.', 'icon': Icons.directions_bus_filled_outlined, 'color': const Color(0xFF5C6BC0)}, // Indigo
  ];

  // Daftar data galeri placeholder (GANTI DENGAN DATA ASLI)
   static final List<Map<String, String>> galleryItems = [
     {'image': 'lib/icons/galeri1.jpg', 'title': 'Candi Prambanan'},
     {'image': 'lib/icons/galeri2.jpg', 'title': 'Malioboro Malam Hari'},
     {'image': 'lib/icons/galeri3.jpg', 'title': 'Pantai Parangtritis'},
     {'image': 'lib/icons/galeri4.webp', 'title': 'Keraton Yogyakarta'},
     {'image': 'lib/icons/galeri5.jpg', 'title': 'Taman Sari'},
   ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Background lebih terang & bersih
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(16.h), // AppBar sedikit lebih tinggi
        child: FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: Container(
            // Padding atas mengikuti status bar + padding tambahan
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 1.h,
                left: 4.w,
                right: 4.w,
                bottom: 2.5.h // Padding bawah sedikit lebih besar
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 79, 5, 5)], // Gradient konsisten
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)), // Radius konsisten
              boxShadow: [ // Shadow AppBar
                BoxShadow(
                   color: const Color(0xFF6A11CB).withOpacity(0.3),
                   blurRadius: 18, // Sesuaikan dengan banner
                   offset: const Offset(0, 10), // Sesuaikan dengan banner
                   spreadRadius: -2,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Tombol Kembali dan Judul
                Row(
                  children: [
                    // Tombol back dengan efek ripple
                    Material(
                      color: Colors.white.withOpacity(0.2), // Background semi-transparan
                      shape: const CircleBorder(), // Bentuk lingkaran
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        customBorder: const CircleBorder(),
                        splashColor: Colors.white.withOpacity(0.4),
                        child: Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 20, // Ukuran ikon
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    // Judul dan Subjudul
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Fitur & Layanan", // Judul lebih deskriptif
                          style: GoogleFonts.poppins(
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w700, // Bold
                            color: Colors.white,
                            shadows: [ // Shadow halus
                                Shadow(color: Colors.black.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 1))
                            ]
                          ),
                        ),
                        Text(
                          "Akses mudah untuk Anda", // Subjudul
                          style: GoogleFonts.poppins(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400, // Normal
                            color: Colors.white.withOpacity(0.85), // Sedikit lebih terlihat
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Tombol Filter (Aksi Placeholder)
                Material(
                   color: Colors.white.withOpacity(0.2),
                   shape: const CircleBorder(),
                   child: InkWell(
                     onTap: () {
                       // TODO: Implementasikan fungsi filter (misal: tampilkan BottomSheet)
                       ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                           content: Text(
                             'Fitur Filter akan segera hadir!',
                             style: GoogleFonts.poppins(color: Colors.white),
                           ),
                           backgroundColor: const Color(0xFF2575FC), // Warna biru dari gradient
                           behavior: SnackBarBehavior.floating, // Tampilan modern
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                           margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h), // Margin
                         ),
                       );
                     },
                      customBorder: const CircleBorder(),
                      splashColor: Colors.white.withOpacity(0.4),
                     child: Container(
                       padding: EdgeInsets.all(2.5.w),
                       decoration: const BoxDecoration(shape: BoxShape.circle),
                       child: const Icon(Icons.filter_list_alt, color: Colors.white, size: 24),
                     ),
                   ),
                 ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(), // Efek scroll memantul
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Section: Fitur Unggulan ---
            _buildSectionTitle("Fitur Unggulan"), // Panggil helper title
            SizedBox(
              height: 20.h, // Tinggi disesuaikan agar konten pas
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: features.length,
                // Padding list: kiri mengikuti page, kanan sedikit lebih kecil
                padding: EdgeInsets.only(left: 4.w, right: 1.w, top: 1.h, bottom: 2.h),
                itemBuilder: (context, index) {
                  final feature = features[index]; // Ambil data fitur
                  return FadeInRight( // Animasi masuk dari kanan
                    duration: Duration(milliseconds: 500 + (index * 100)), // Delay bertahap
                    child: Padding(
                      padding: EdgeInsets.only(right: 3.w), // Jarak antar kartu
                      child: _buildFeatureCard(context, feature), // Panggil helper card
                    ),
                  );
                },
              ),
            ),

            // --- Section: Galeri Yogyakarta ---
            _buildSectionTitle("Galeri Yogyakarta"),
            SizedBox(
              height: 26.h, // Tinggi galeri disesuaikan
              child: ListView.builder(
                 physics: const BouncingScrollPhysics(),
                 scrollDirection: Axis.horizontal,
                 itemCount: galleryItems.length, // Gunakan panjang data galeri
                 padding: EdgeInsets.only(left: 4.w, right: 1.w, top: 1.h, bottom: 2.h),
                 itemBuilder: (context, index) {
                   final item = galleryItems[index]; // Ambil data galeri
                   return FadeInUp( // Animasi masuk dari bawah
                     duration: Duration(milliseconds: 600 + (index * 100)),
                     child: Padding(
                       padding: EdgeInsets.only(right: 3.w),
                       child: _buildGalleryCard(context, item), // Panggil helper card galeri
                     ),
                   );
                 },
               ),
            ),

             // Tombol "Lihat Semua" Galeri
            FadeInUp(
              duration: const Duration(milliseconds: 700),
              delay: const Duration(milliseconds: 300), // Delay setelah list muncul
              child: Center( // Pusatkan tombol
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.5.h), // Padding vertikal
                  child: ElevatedButton.icon(
                     onPressed: () {
                        // TODO: Implementasikan navigasi ke halaman galeri lengkap
                        ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                           content: Text(
                             'Navigasi ke halaman Galeri Lengkap!',
                             style: GoogleFonts.poppins(color: Colors.white),
                           ),
                           backgroundColor: const Color(0xFF2575FC),
                           behavior: SnackBarBehavior.floating,
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                           margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                         ),
                       );
                     },
                     icon: const Icon(Icons.photo_library_outlined, size: 18), // Ikon tombol
                     label: Text(
                       "Lihat Semua Galeri",
                       style: GoogleFonts.poppins(
                         fontSize: 14.sp,
                         fontWeight: FontWeight.w600,
                       ),
                     ),
                     style: ElevatedButton.styleFrom(
                       foregroundColor: Colors.white, // Warna teks & ikon
                       backgroundColor: const Color(0xFF2575FC), // Warna tombol (biru)
                       padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.8.h), // Padding tombol
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(30), // Tombol rounded penuh
                       ),
                       elevation: 6, // Elevasi tombol
                       shadowColor: const Color(0xFF2575FC).withOpacity(0.5) // Warna shadow
                     ),
                   ),
                ),
              ),
            ),

            SizedBox(height: 3.h), // Padding di bagian bawah halaman
          ],
        ),
      ),
    );
  }

  // Helper Widget untuk Judul Section (Lebih Rapi)
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, top: 2.5.h, bottom: 1.h), // Padding disesuaikan
      child: FadeInLeft( // Animasi masuk dari kiri
        duration: const Duration(milliseconds: 600),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18.sp, // Ukuran judul section
            fontWeight: FontWeight.w600, // Bold
            color: Colors.black.withOpacity(0.8), // Warna sedikit transparan
          ),
        ),
      ),
    );
  }

  // Helper Widget untuk Kartu Fitur (Lebih Rapi)
  Widget _buildFeatureCard(BuildContext context, Map<String, dynamic> feature) {
     return Material( // Dibutuhkan untuk InkWell & Shadow
      color: Colors.white, // Warna dasar kartu
      borderRadius: BorderRadius.circular(18), // Radius sudut kartu
      child: InkWell(
        onTap: () {
          // TODO: Implementasikan navigasi ke halaman detail fitur
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${feature['title']} dipilih!', style: GoogleFonts.poppins()),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          ));
        },
        borderRadius: BorderRadius.circular(18),
        splashColor: (feature['color'] as Color).withOpacity(0.2), // Warna splash sesuai fitur
        highlightColor: (feature['color'] as Color).withOpacity(0.1), // Warna highlight
        child: Ink( // Gunakan Ink untuk dekorasi
          width: 33.w, // Lebar kartu sedikit lebih besar
          decoration: BoxDecoration(
            color: Colors.white, // Pastikan warna dasar
            borderRadius: BorderRadius.circular(18),
            boxShadow: [ // Shadow halus untuk kartu
              BoxShadow(
                color: Colors.grey.shade300, // Warna shadow lebih terang
                blurRadius: 12,
                offset: const Offset(0, 5),
                spreadRadius: -1
              ),
            ],
          ),
          child: Padding( // Padding konten di dalam kartu
            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Background ikon yang lebih simpel
                Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: (feature['color'] as Color).withOpacity(0.15), // Warna BG ikon lebih soft
                    shape: BoxShape.circle, // Bentuk lingkaran
                  ),
                  child: Icon(
                    feature['icon'] as IconData,
                    color: feature['color'] as Color, // Warna ikon sesuai fitur
                    size: 24.sp, // Ukuran ikon
                  ),
                ),
                SizedBox(height: 1.8.h), // Spasi
                Text(
                  feature['title'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 13.5.sp, // Sedikit lebih besar
                    fontWeight: FontWeight.w600,
                    color: Colors.black87, // Warna teks judul
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // Handle teks panjang
                ),
                SizedBox(height: 0.8.h), // Spasi kecil
                Text(
                  feature['description'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 10.5.sp, // Sedikit lebih besar
                    color: Colors.black54, // Warna teks deskripsi
                    height: 1.2 // Spasi baris deskripsi
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2, // Maksimal 2 baris
                  overflow: TextOverflow.ellipsis, // Handle teks panjang
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

   // Helper Widget untuk Kartu Galeri (Lebih Rapi)
  Widget _buildGalleryCard(BuildContext context, Map<String, String> item) {
    return Container(
      width: 48.w, // Lebar kartu galeri lebih besar
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [ // Shadow untuk kartu gambar
          BoxShadow(
            color: Colors.grey.shade400, // Shadow sedikit lebih gelap
            blurRadius: 14,
            offset: const Offset(0, 7),
            spreadRadius: -2
          ),
        ],
      ),
      child: ClipRRect( // Potong sesuai sudut
        borderRadius: BorderRadius.circular(18),
        child: Stack( // Tumpuk gambar dan overlay
          fit: StackFit.expand, // Penuhi area kartu
          children: [
            // Gambar Galeri
            Image.asset(
              item['image']!, // Ambil path gambar dari data
              fit: BoxFit.cover, // Tutupi area
              // Tambahkan error builder untuk menangani jika gambar tidak ada
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey.shade300,
                  child: Center(
                      child: Icon(Icons.broken_image_outlined,
                      color: Colors.grey.shade600, size: 30.sp)
                  ),
                );
              },
            ),
            // Overlay Gradient di bagian bawah untuk Teks
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 12.h, // Tinggi area gradient
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(18)),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.85), // Awal lebih gelap
                      Colors.black.withOpacity(0.0),  // Akhir transparan
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            // Teks Judul Galeri di atas Overlay
            Positioned(
              bottom: 2.h, // Posisi dari bawah
              left: 3.w,   // Posisi dari kiri
              right: 3.w,  // Posisi dari kanan
              child: Text(
                item['title']!, // Ambil judul dari data
                style: GoogleFonts.poppins(
                  fontSize: 14.sp, // Ukuran teks judul galeri
                  color: Colors.white,
                  fontWeight: FontWeight.w600, // Bold
                  shadows: [ // Shadow halus agar teks lebih terbaca
                      Shadow(color: Colors.black.withOpacity(0.6), blurRadius: 4, offset: const Offset(0, 1))
                  ]
                ),
                textAlign: TextAlign.center,
                maxLines: 2, // Maksimal 2 baris
                overflow: TextOverflow.ellipsis,
              ),
            ),
             // Opsional: Tambahkan efek ripple saat di-tap
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                     // TODO: Implementasikan aksi saat item galeri di-tap (misal: buka detail gambar)
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Membuka detail ${item['title']}', style: GoogleFonts.poppins()),
                       behavior: SnackBarBehavior.floating,
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                       margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                     ));
                  },
                  splashColor: Colors.white.withOpacity(0.2),
                  highlightColor: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}