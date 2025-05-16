import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_animate/flutter_animate.dart';

// --- Impor Halaman/Widget Anda (Sesuaikan nama jika sudah di-refactor) ---
// Mungkin tidak perlu jika ini halaman terpisah
// Ganti nama class -> CctvDetailsScreen
// import 'package:JogjaIstimewa/Screens/Widgets/cctvList.dart'; // Tidak terpakai di kode ini?
// import 'package:JogjaIstimewa/Screens/Widgets/listicons.dart'; // Tidak terpakai di kode ini?

// --- Gunakan AppColors dan AppStyles yang sudah dibuat sebelumnya ---
// Diasumsikan file ini sudah ada dan diimpor
// import 'path/to/app_styles.dart';

// --- Konstanta Lokal & Asset Paths ---
class _FindCctvScreenConstants {
  // Asset Paths (Lebih aman jika path salah)
  static const String bellIcon = "lib/icons/bell.png";
  static const String newsPlaceholderImage = "lib/icons/jogjaprovnews.png"; // Sesuaikan path

  // Durations
  static const Duration loadingDuration = Duration(seconds: 2);
  static const Duration refreshDuration = Duration(seconds: 1);
  static const Duration animationDuration = Duration(milliseconds: 500);
  static const Duration staggerDuration = Duration(milliseconds: 80);

  // Data Kategori (Contoh)
  static const List<String> categories = [
    'Semua',
    'Infrastruktur',
    'Pelayanan Publik',
    'Keamanan',
    'Lingkungan', // Contoh tambahan
  ];

  // Data Fitur (Contoh) - Gunakan AppColors jika memungkinkan
  static const List<Map<String, dynamic>> features = [
    {'name': 'Layanan 1', 'icon': 'lib/icons/icon1sch.png', 'color': Color(0xFFFFF0F0)}, // Warna lebih soft
    {'name': 'Layanan 2', 'icon': 'lib/icons/icon2sch.png', 'color': Color(0xFFE6F0FA)},
    {'name': 'Layanan 3', 'icon': 'lib/icons/icon3sch.png', 'color': Color(0xFFF5E6FF)},
    {'name': 'Layanan 4', 'icon': 'lib/icons/icon4sch.png', 'color': Color(0xFFE6F5FA)},
    {'name': 'Layanan 5', 'icon': 'lib/icons/icon5sch.png', 'color': Color(0xFFFFF5E6)},
    {'name': 'Layanan 6', 'icon': 'lib/icons/icon6sch.png', 'color': Color(0xFFF0F0FF)}, // Warna lebih soft
    {'name': 'Layanan 7', 'icon': 'lib/icons/icon7sch.png', 'color': Color(0xFFE6FAE6)},
    {'name': 'Layanan 8', 'icon': 'lib/icons/icon8sch.png', 'color': Color(0xFFF5F5F5)}, // Warna lebih soft
  ];

  // Data Aduan/Berita (Contoh) - Ganti nama 'doctors'
  static const List<Map<String, dynamic>> reports = [
    {
      'title': 'Pentingnya Keterlibatan Masyarakat dalam Optimalisasi Layanan Aduan', // Ganti 'name' -> 'title'
      'source': 'Warga Kota Jogja', // Ganti 'specialty' -> 'source' atau 'reporter'
      'image': 'lib/icons/aduan1.webp',
      'location_info': '800m dari sini', // Ganti 'distance' -> 'location_info'
      'category': 'Pelayanan Publik',
    },
    {
      'title': 'Infrastruktur Jalan di Yogyakarta Membutuhkan Perhatian Segera',
      'source': 'Warga Sleman',
      'image': 'lib/icons/aduan2.jpg',
     'location_info': '800m dari sini', 
      'category': 'Infrastruktur',
    },
    {
      'title': 'Keamanan di Area Pasar Tradisional Perlu Ditingkatkan',
      'source': 'Warga Bantul',
      'image': 'lib/icons/aduan3.jpg',
      'location_info': '2.5km dari sini',
      'category': 'Keamanan',
    },
    {
      'title': 'Penumpukan Sampah Liar di Tepi Sungai Code Meresahkan',
      'source': 'Komunitas Peduli Lingkungan',
      'image': 'lib/icons/aduan4.jpeg',
      'location_info': '3.1km dari sini',
      'category': 'Lingkungan',
    },
  ];
}

// --- Widget Utama (Ganti Nama Class) ---
class find_cctv extends StatefulWidget { // Ganti find_cctv -> FindCctvScreen
  const find_cctv({super.key});

  @override
  // Ganti _FindvidioState -> _FindCctvScreenState
  State<find_cctv> createState() => _FindCctvScreenState();
}

class _FindCctvScreenState extends State<find_cctv> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool _isLoading = true;
  String _selectedCategory = _FindCctvScreenConstants.categories.first; // Default 'Semua'

  @override
  void initState() {
    super.initState();
    _simulateLoading();
  }

  // Simulasi loading data
  Future<void> _simulateLoading() async {
    await Future.delayed(_FindCctvScreenConstants.loadingDuration);
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  // Logika refresh data
  Future<void> _onRefresh() async {
    setState(() => _isLoading = true); // Tampilkan loading saat refresh
    // TODO: Tambahkan logika fetch data sebenarnya di sini
    await Future.delayed(_FindCctvScreenConstants.refreshDuration);
    if (mounted) {
      setState(() => _isLoading = false); // Sembunyikan loading
      _refreshController.refreshCompleted();
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  // --- Build Methods ---

  @override
  Widget build(BuildContext context) {
    // Menggunakan warna background dari tema
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface, // Gunakan warna tema
      appBar: _buildAppBar(context), // Kirim context jika perlu tema
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        header: WaterDropHeader( // Header refresh yang lebih menarik
           waterDropColor: AppColors.primaryRed, // Gunakan warna dari AppColors
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 3.h),
              _buildSearchBar(context),
              SizedBox(height: 3.h),
              _buildSectionHeader("Fitur Populer", () { /* TODO: Navigasi Lihat Semua Fitur */ }),
              _buildFeatureGrid(), // Grid sudah di dalam Padding
              SizedBox(height: 3.h),
              _buildSectionHeader("Aduan Terbaru", () { /* TODO: Navigasi Lihat Semua Aduan */ }),
              _buildCategoryFilter(),
              SizedBox(height: 1.h),
              _buildReportList(), // List sudah di dalam Padding
              SizedBox(height: 4.h), // Padding bawah
            ],
          ),
        ),
      ),
    );
  }

  // AppBar yang Ditingkatkan
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return PreferredSize(
      preferredSize: Size.fromHeight(12.h),
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 1.h, left: 5.w, right: 5.w, bottom: 2.h),
        decoration: BoxDecoration(
          gradient: AppStyles.appBarGradient, // Gunakan gradient dari AppStyles
          borderRadius: AppStyles.appBarRadius, // Gunakan radius dari AppStyles
          boxShadow: const [
            BoxShadow(
              color: AppColors.black12, // Gunakan warna dari AppColors
              blurRadius: AppStyles.shadowBlurRadius, // Gunakan konstanta blur
              offset: AppStyles.shadowOffset, // Gunakan konstanta offset
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Tombol Back & Judul
            Row(
              children: [
                // Tombol Back yang lebih menarik
                Material(
                  color: AppColors.white.withOpacity(0.2), // Gunakan AppColors
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(30),
                    child: Padding(
                      padding: EdgeInsets.all(2.w),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.white, // Gunakan AppColors
                        size: 18.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                // Judul & Subjudul
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Layanan", // Judul lebih jelas
                      style: AppStyles.appBarTitleStyle, // Gunakan gaya dari AppStyles
                    ),
                    Text(
                      "Fitur & aduan terkini", // Subjudul lebih sesuai
                      style: AppStyles.appBarSubtitleStyle, // Gunakan gaya dari AppStyles
                    ),
                  ],
                ),
              ],
            ),
            // Tombol Notifikasi
            _buildNotificationButton(context),
          ],
        ),
      ).animate().fadeIn(duration: _FindCctvScreenConstants.animationDuration), // Animasi AppBar
    );
  }

   // Widget untuk Tombol Notifikasi (Sama seperti di ScheduleScreen)
  Widget _buildNotificationButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Fitur Notifikasi Segera Hadir!',
              style: GoogleFonts.poppins(color: AppColors.white),
            ),
            backgroundColor: AppColors.primaryRed, // Gunakan warna konsisten
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(2.5.w),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_outlined,
              size: 24.sp,
              color: AppColors.notificationBell,
            ),
          ),
          Positioned(
            right: 4, top: 4,
            child: Container(
              width: 2.w, height: 2.w,
              decoration: const BoxDecoration(
                color: AppColors.notificationBadge,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ).animate().scale(delay: 200.ms, duration: 300.ms),
    );
  }

  // Search Bar yang Ditingkatkan
  Widget _buildSearchBar(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w), // Padding vertikal dihapus agar lebih ramping
        decoration: BoxDecoration(
          // Gunakan warna surface dari tema untuk adaptasi dark mode
          color: theme.colorScheme.surface,
          borderRadius: AppStyles.cardBorderRadius, // Gunakan radius dari AppStyles
          boxShadow: [
            BoxShadow(
              color: AppColors.black12.withOpacity(0.08), // Shadow lebih halus
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            color: theme.colorScheme.onSurface, // Warna teks sesuai tema
          ),
          decoration: InputDecoration(
            icon: Icon(Icons.search_rounded, color: AppColors.primaryRed, size: 20.sp),
            hintText: "Cari fitur atau aduan...", // Hint lebih jelas
            hintStyle: GoogleFonts.poppins(
              fontSize: 16.sp,
              color: theme.hintColor, // Gunakan warna hint dari tema
            ),
            border: InputBorder.none, // Hilangkan border default
            suffixIcon: Icon(Icons.mic_rounded, color: AppColors.primaryRed.withOpacity(0.8), size: 20.sp),
            contentPadding: EdgeInsets.symmetric(vertical: 1.8.h), // Sesuaikan padding vertikal
          ),
          // TODO: Implement search functionality (onChanged or onSubmitted)
        ),
      ).animate().fadeIn(delay: 100.ms, duration: _FindCctvScreenConstants.animationDuration), // Animasi Search Bar
    );
  }

   // Section Header yang Ditingkatkan
  Widget _buildSectionHeader(String title, VoidCallback onSeeAllTap) {
     final theme = Theme.of(context);
     return Padding(
       padding: EdgeInsets.only(left: 5.w, right: 3.w, top: 1.h, bottom: 0.5.h), // Sesuaikan padding
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         crossAxisAlignment: CrossAxisAlignment.center, // Align vertikal
         children: [
           Text(
             title,
             style: GoogleFonts.poppins(
               fontSize: 18.sp,
               fontWeight: FontWeight.w600, // Sedikit lebih tebal
               color: theme.colorScheme.onSurface, // Warna teks sesuai tema
             ),
           ),
           TextButton( // Gunakan TextButton untuk aksesibilitas
             onPressed: onSeeAllTap,
             style: TextButton.styleFrom(
               foregroundColor: AppColors.primaryRed, // Warna teks tombol
               textStyle: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
               padding: EdgeInsets.symmetric(horizontal: 2.w),
             ),
             child: const Text("Lihat Semua"),
           ),
         ],
       ),
     );
   }

  // Feature Grid yang Ditingkatkan
  Widget _buildFeatureGrid() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w), // Padding horizontal
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _isLoading ? 8 : _FindCctvScreenConstants.features.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // 4 ikon per baris
          crossAxisSpacing: 2.w, // Jarak antar kolom
          mainAxisSpacing: 1.5.h, // Jarak antar baris
          childAspectRatio: 0.85, // Sesuaikan rasio agar teks tidak terpotong
        ),
        itemBuilder: (context, index) {
          if (_isLoading) {
            return _buildShimmerFeatureItem();
          }
          final feature = _FindCctvScreenConstants.features[index];
          return _buildFeatureItem(feature)
            .animate(delay: _FindCctvScreenConstants.staggerDuration * index)
            .fadeIn(duration: _FindCctvScreenConstants.animationDuration)
            .slideY(begin: 0.3, curve: Curves.easeOut); // Animasi staggered
        },
      ),
    );
  }

  // Feature Item yang Ditingkatkan
  Widget _buildFeatureItem(Map<String, dynamic> feature) {
    final theme = Theme.of(context);
    return Material( // Bungkus dengan Material untuk InkWell
       color: Colors.transparent, // Transparan agar tidak menutupi background
       child: InkWell( // Gunakan InkWell untuk efek ripple
         onTap: () { /* TODO: Implement feature tap */
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Fitur ${feature['name']} diklik!', style: GoogleFonts.poppins(color: AppColors.white)),
                backgroundColor: AppColors.primaryRed,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              ),
            );
         },
         borderRadius: BorderRadius.circular(12), // Bentuk ripple
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             // Icon Container
             Container(
               padding: EdgeInsets.all(3.w),
               decoration: BoxDecoration(
                 // Gunakan warna dari data, pastikan cukup kontras
                 color: feature['color'] as Color? ?? theme.colorScheme.primaryContainer,
                 shape: BoxShape.circle,
                 boxShadow: [ // Shadow lebih halus
                   BoxShadow(
                     color: AppColors.black12.withOpacity(0.06),
                     blurRadius: 8,
                     offset: const Offset(0, 3),
                   ),
                 ],
               ),
               child: Image.asset(
                 feature['icon'],
                 height: 8.w,
                 width: 8.w,
                 // Tambahkan error builder jika ikon tidak ada
                 errorBuilder: (_, __, ___) => Icon(Icons.interests_rounded, size: 8.w, color: AppColors.primaryRed),
               ),
             ),
             SizedBox(height: 1.h),
             // Teks Nama Fitur
             Text(
               feature['name'],
               style: GoogleFonts.poppins(
                 fontSize: 12.sp,
                 fontWeight: FontWeight.w500,
                 color: theme.colorScheme.onSurface, // Warna teks sesuai tema
               ),
               textAlign: TextAlign.center,
               maxLines: 1, // Pastikan satu baris
               overflow: TextOverflow.ellipsis, // Atasi teks panjang
             ),
           ],
         ),
       ),
     );
  }

 // Shimmer untuk Feature Item
  Widget _buildShimmerFeatureItem() {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).brightness == Brightness.light ? Colors.grey[300]! : Colors.grey[700]!,
      highlightColor: Theme.of(context).brightness == Brightness.light ? Colors.grey[100]! : Colors.grey[600]!,
      child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           const CircleAvatar(radius: 25), // Placeholder ikon
           SizedBox(height: 1.h),
           Container(
             height: 10,
             width: 50,
             color: Colors.white, // Warna dasar shimmer
             margin: EdgeInsets.symmetric(horizontal: 1.w),
           ),
         ],
       ),
    );
  }


  // Filter Kategori yang Ditingkatkan
  Widget _buildCategoryFilter() {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      // Menghilangkan padding horizontal agar bisa dimulai dari tepi
      padding: EdgeInsets.only(left: 5.w, right: 3.w, top: 1.h, bottom: 1.h),
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: _FindCctvScreenConstants.categories.map((category) {
          final isSelected = _selectedCategory == category;
          return Padding(
            padding: EdgeInsets.only(right: 2.w), // Jarak antar chip
            child: FilterChip( // Gunakan FilterChip untuk visual yang lebih standar
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                 if (selected) {
                   setState(() => _selectedCategory = category);
                 }
              },
              labelStyle: GoogleFonts.poppins(
                 fontSize: 14.sp,
                 fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                 color: isSelected ? AppColors.white : theme.colorScheme.onSurfaceVariant, // Warna teks chip
              ),
              backgroundColor: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5), // Warna background chip non-aktif
              selectedColor: AppColors.primaryRed, // Warna background chip aktif
              checkmarkColor: AppColors.white, // Warna centang (jika showCheckmark=true)
              // showCheckmark: false, // Sembunyikan centang jika tidak perlu
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide( // Tambahkan border tipis
                  color: isSelected ? AppColors.primaryRed : theme.dividerColor.withOpacity(0.5),
                  width: 1,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h), // Padding internal chip
            ).animate(target: isSelected ? 1 : 0) // Animate based on selection
               .scale(duration: 200.ms, begin: const Offset(0.95, 0.95), curve: Curves.easeOut)
               .fade(duration: 200.ms), // Animasi saat terpilih
          );
        }).toList(),
      ),
    );
  }


  // List Aduan/Berita (Ganti Nama dan Tingkatkan)
  Widget _buildReportList() {
    // Filter data berdasarkan kategori terpilih
    final filteredReports = _selectedCategory == _FindCctvScreenConstants.categories.first // 'Semua'
        ? _FindCctvScreenConstants.reports
        : _FindCctvScreenConstants.reports.where((report) => report['category'] == _selectedCategory).toList();

    // Tampilkan loading atau list
    return _isLoading
        ? _buildShimmerReportList() // Tampilkan Shimmer List
        : filteredReports.isEmpty
            ? _buildEmptyState() // Tampilkan pesan jika kosong
            : ListView.builder(
                shrinkWrap: true, // Penting di dalam SingleChildScrollView
                physics: const NeverScrollableScrollPhysics(), // Non-scrollable
                padding: EdgeInsets.symmetric(horizontal: 5.w), // Padding list
                itemCount: filteredReports.length,
                itemBuilder: (context, index) {
                   final report = filteredReports[index];
                   return _buildReportCard(report) // Bangun kartu untuk setiap item
                     .animate(delay: _FindCctvScreenConstants.staggerDuration * index)
                     .fadeIn(duration: _FindCctvScreenConstants.animationDuration)
                     .slideY(begin: 0.3, curve: Curves.easeOut); // Animasi staggered
                 },
               );
  }


 // Kartu Aduan/Berita yang Ditingkatkan (Ganti nama Doctor -> Report)
  Widget _buildReportCard(Map<String, dynamic> report) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h), // Jarak antar kartu
      child: Material( // Bungkus dengan Material untuk InkWell & elevation
        borderRadius: AppStyles.cardBorderRadius,
        elevation: 2, // Sedikit elevasi
        shadowColor: AppColors.black12.withOpacity(0.1), // Warna shadow
        color: theme.cardColor, // Warna kartu sesuai tema
        child: InkWell( // Gunakan InkWell
          borderRadius: AppStyles.cardBorderRadius,
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeftWithFade, // Transisi halus
                child: CctvDetailsScreen(reportData: report), // Kirim data ke detail screen jika perlu
              ),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start, // Align ke atas
            children: [
              // Gambar di Kiri
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(15)),
                child: Image.asset(
                  report['image'] ?? _FindCctvScreenConstants.newsPlaceholderImage,
                  width: 30.w, // Lebar gambar disesuaikan
                  height: 18.h, // Tinggi gambar disesuaikan
                  fit: BoxFit.cover,
                  // Error builder jika gambar gagal load
                  errorBuilder: (_, __, ___) => Container(
                     width: 30.w, height: 18.h, color: Colors.grey[300],
                     child: Icon(Icons.broken_image_outlined, size: 30, color: Colors.grey[600])
                  ),
                ),
              ),
              // Konten Teks di Kanan
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h), // Padding konten
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Kategori Tag
                      _buildCategoryTag(report['category'] ?? 'Umum'),
                      SizedBox(height: 1.h),
                      // Judul Aduan/Berita
                      Text(
                        report['title'] ?? 'Tidak ada judul', // Ganti 'name' -> 'title'
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface, // Warna teks sesuai tema
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      // Sumber/Pelapor
                      Text(
                        report['source'] ?? 'Anonim', // Ganti 'specialty' -> 'source'
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          color: theme.colorScheme.onSurfaceVariant, // Warna teks sekunder
                        ),
                         maxLines: 1,
                         overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 1.5.h),
                      // Info Lokasi/Jarak
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, size: 14.sp, color: AppColors.primaryRed),
                          SizedBox(width: 1.w),
                          Text(
                            report['location_info'] ?? 'Lokasi tidak diketahui', // Ganti 'distance' -> 'location_info'
                            style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                             maxLines: 1,
                             overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 // Tag Kategori yang Ditingkatkan
  Widget _buildCategoryTag(String category) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 0.6.h), // Padding tag
      decoration: BoxDecoration(
        // Gunakan warna solid agar lebih mudah dibaca
        color: AppColors.primaryRed.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6), // Radius lebih kecil untuk tag
      ),
      child: Text(
        category,
        style: GoogleFonts.poppins(
          fontSize: 11.sp, // Font lebih kecil
          fontWeight: FontWeight.w500,
          color: AppColors.primaryRed, // Warna teks tag
        ),
      ),
    );
  }

  // Shimmer untuk List Aduan/Berita
  Widget _buildShimmerReportList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      itemCount: 3, // Jumlah shimmer card
      itemBuilder: (_, __) => _buildShimmerReportCard(),
    );
  }

 // Shimmer untuk satu kartu aduan/berita
  Widget _buildShimmerReportCard() {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Shimmer.fromColors(
         baseColor: isLight ? Colors.grey[300]! : Colors.grey[700]!,
         highlightColor: isLight ? Colors.grey[100]! : Colors.grey[600]!,
         child: Container(
            height: 18.h, // Sesuaikan tinggi
            decoration: BoxDecoration(
              color: Colors.white, // Warna dasar shimmer
              borderRadius: AppStyles.cardBorderRadius,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Placeholder Gambar
                Container(
                  width: 30.w, height: 18.h,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
                  ),
                ),
                // Placeholder Teks
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(width: 8.w, height: 1.5.h, color: Colors.white), // Tag
                        SizedBox(height: 1.5.h),
                        Container(width: double.infinity, height: 1.8.h, color: Colors.white), // Judul
                        SizedBox(height: 0.5.h),
                        Container(width: 60.w, height: 1.8.h, color: Colors.white), // Judul baris 2
                        SizedBox(height: 1.h),
                        Container(width: 20.w, height: 1.5.h, color: Colors.white), // Sumber
                        SizedBox(height: 2.h),
                        Container(width: 30.w, height: 1.5.h, color: Colors.white), // Lokasi
                      ],
                    ),
                  ),
                ),
              ],
            ),
         ),
      ),
    );
  }

 // Tampilan ketika list kosong
  Widget _buildEmptyState() {
    final theme = Theme.of(context);
    return Container(
       padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
       alignment: Alignment.center,
       child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(Icons.search_off_rounded, size: 50.sp, color: Colors.grey[400]),
             SizedBox(height: 2.h),
             Text(
               "Oops!",
               style: GoogleFonts.poppins(
                 fontSize: 18.sp,
                 fontWeight: FontWeight.w600,
                 color: theme.colorScheme.onSurface,
               ),
             ),
             SizedBox(height: 1.h),
             Text(
               "Belum ada aduan untuk kategori\n'$_selectedCategory' saat ini.",
               textAlign: TextAlign.center,
               style: GoogleFonts.poppins(
                 fontSize: 14.sp,
                 color: theme.colorScheme.onSurfaceVariant,
               ),
             ),
          ],
       ),
    ).animate().fade(duration: 300.ms);
  }
}


// --- Dummy Classes/Widgets (Hapus/Ganti dengan implementasi Anda) ---
class AppColors {
  static const Color primaryRed = Color.fromARGB(255, 255, 50, 50);
  static const Color darkRed = Color.fromARGB(255, 79, 5, 5);
  static const Color lightGrey = Color(0xFFF1F1F1);
  static const Color darkGreyText = Color(0xFF202020);
  static const Color white = Colors.white;
  static const Color white70 = Colors.white70;
  static const Color black12 = Colors.black12;
  static const Color black54 = Colors.black54;
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color notificationBell = Colors.white;
  static const Color notificationBadge = Colors.red;
  static const Color tealAccent = Color(0xFF00C4B4);
}

class AppStyles {
  static const LinearGradient appBarGradient = LinearGradient(
    colors: [AppColors.primaryRed, AppColors.darkRed],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static final BorderRadius cardBorderRadius = BorderRadius.circular(15.0);
  static final BorderRadius tabBarIndicatorRadius = BorderRadius.circular(8.0);
  static final BorderRadius tabBarContainerRadius = BorderRadius.circular(10.0);
  static final BorderRadius appBarRadius = const BorderRadius.vertical(bottom: Radius.circular(30));
  static const double fabElevation = 6.0;
  static const double shadowBlurRadius = 10.0;
  static const Offset shadowOffset = Offset(0, 4);

  static TextStyle appBarTitleStyle = GoogleFonts.inter(fontSize: 22.sp, fontWeight: FontWeight.w800, color: AppColors.white);
  static TextStyle appBarSubtitleStyle = GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w400, color: AppColors.white70);
   static TextStyle searchHintStyle = GoogleFonts.poppins(fontSize: 16.sp, color: AppColors.black54);
}

class CctvDetailsScreen extends StatelessWidget { // Dummy Detail Screen
  final Map<String, dynamic>? reportData; // Menerima data
  const CctvDetailsScreen({super.key, this.reportData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(reportData?['title'] ?? 'Detail Aduan')),
      body: Center(child: Text('Detail untuk: ${reportData?['title'] ?? 'Tidak ada data'}')),
    );
  }
}