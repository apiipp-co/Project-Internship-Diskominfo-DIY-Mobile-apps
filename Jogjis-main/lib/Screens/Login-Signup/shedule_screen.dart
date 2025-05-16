import 'package:JogjaIstimewa/Screens/Views/shedule_tab1.dart';
import 'package:JogjaIstimewa/Screens/Views/shedule_tab2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_animate/flutter_animate.dart';

// Diasumsikan file-file ini ada dan namanya sudah diperbaiki
// Ganti nama file
// Ganti nama file
import 'package:JogjaIstimewa/Screens/Views/add_complaint_page.dart';
// Ganti nama file

// --- Konstanta Warna dan Gaya ---
class AppColors {
  static const Color primaryRed = Color.fromARGB(255, 255, 0, 0);
  static const Color darkRed = Color.fromARGB(255, 79, 5, 5);
  static const Color accentRed = Color.fromARGB(255, 255, 50, 50);
  static const Color lightGrey = Color(0xFFF1F1F1);
  static const Color mediumGrey = Color(0xFFEBEBEB);
  static const Color darkGrey = Color(0xFF202020);
  static const Color white = Colors.white;
  static const Color white70 = Colors.white70;
  static const Color black = Colors.black;
  static const Color black12 = Colors.black12;
  static const Color black54 = Colors.black54;
  static const Color grey300 = Color(0xFFE0E0E0); // Warna dasar shimmer
  static const Color grey100 = Color(0xFFF5F5F5); // Warna highlight shimmer

  // Warna dari cctv_search.dart (jika masih relevan)
  // static const Color primaryTeal = Color(0xFF00C4B4);
}

class AppStyles {
  static const LinearGradient appBarGradient = LinearGradient(
    colors: [AppColors.primaryRed, AppColors.darkRed],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final BorderRadius borderRadiusMedium = BorderRadius.circular(15);
  static final BorderRadius borderRadiusSmall = BorderRadius.circular(10);
  static final BorderRadius borderRadiusXSmall = BorderRadius.circular(8);

  static const BoxShadow shadow = BoxShadow(
    color: AppColors.black12,
    blurRadius: 10,
    offset: Offset(0, 4),
  );

   static const BoxShadow searchBarShadow = BoxShadow(
      color: AppColors.black12,
      blurRadius: 15,
      offset: Offset(0, 5),
   );
}

class AppTextStyles {
  static final TextStyle appBarTitle = GoogleFonts.inter(
    fontSize: 22.sp, // Ukuran font responsif
    fontWeight: FontWeight.w800,
    color: AppColors.white,
  );

  static final TextStyle appBarSubtitle = GoogleFonts.inter(
    fontSize: 14.sp, // Ukuran font responsif
    fontWeight: FontWeight.w400,
    color: AppColors.white70,
  );

   static final TextStyle searchHint = GoogleFonts.poppins(
    fontSize: 16.sp, // Ukuran font responsif
    color: AppColors.black54,
  );

  static final TextStyle tabLabel = GoogleFonts.poppins( // Atau Inter, sesuaikan
    fontWeight: FontWeight.w600, // Sedikit tebal
  );

  static final TextStyle snackbarText = GoogleFonts.poppins(
    color: AppColors.white,
  );
}

// --- Widget Utama ---
class shedule_screen extends StatefulWidget {
  const shedule_screen({super.key});

  @override
  State<shedule_screen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<shedule_screen> with TickerProviderStateMixin {
  late TabController _tabController;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _simulateLoading();
  }

  // Simulasi loading data
  Future<void> _simulateLoading() async {
    // Tunda untuk efek loading
    await Future.delayed(const Duration(seconds: 2));
    // Pastikan widget masih ada sebelum update state
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  // Logika saat pull-to-refresh
  Future<void> _onRefresh() async {
    // Di sini Anda akan memanggil API atau logika refresh data
    await Future.delayed(const Duration(seconds: 1)); // Simulasi delay network
    if (mounted) {
      setState(() {
        // Update data jika perlu (misalnya memuat ulang data dari API)
      });
      _refreshController.refreshCompleted(); // Selesaikan indikator refresh
    }
  }

  @override
  void dispose() {
    _tabController.dispose(); // Wajib dispose controller
    _refreshController.dispose(); // Wajib dispose controller
    super.dispose();
  }

  // --- Build Methods ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // Menggunakan PreferredSize agar AppBar bisa punya tinggi custom
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(12.h), // Tinggi AppBar responsif
        child: _buildAppBar(),
      ),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // SmartRefresher untuk fitur pull-to-refresh
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        header: const WaterDropHeader( // Header refresh yang menarik
           waterDropColor: AppColors.accentRed,
        ),
        child: Column( // Menggunakan Column agar SearchBar tetap di atas
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              _buildSearchBar().animate().fadeIn(delay: 200.ms).slideX(begin: 0.1),
              SizedBox(height: 1.h), // Mengurangi jarak sedikit
              _buildTabBarSection(),
              Expanded( // Agar TabBarView mengisi sisa ruang
                 child: _buildContent(),
              ),
            ],
          ),
        ),
    );
  }

  // Widget untuk AppBar Kustom
  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.only(top: 6.h, left: 5.w, right: 5.w, bottom: 2.h),
      decoration: BoxDecoration(
        gradient: AppStyles.appBarGradient,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
        boxShadow: const [AppStyles.shadow],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Kolom untuk Teks Judul dan Subjudul
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("List Pengaduan", style: AppTextStyles.appBarTitle),
              Text("Lacak Aduan Kamu", style: AppTextStyles.appBarSubtitle),
            ],
          ),
          // Tombol Notifikasi
          _buildNotificationButton(),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2); // Animasi AppBar
  }

  // Widget Tombol Notifikasi di AppBar
  Widget _buildNotificationButton() {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fitur Notifikasi Segera Hadir!', style: AppTextStyles.snackbarText),
            backgroundColor: AppColors.accentRed, // Gunakan warna aksen
            behavior: SnackBarBehavior.floating, // SnackBar mengambang
            shape: RoundedRectangleBorder(borderRadius: AppStyles.borderRadiusSmall),
            margin: EdgeInsets.all(3.w),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.2), // Transparansi
              shape: BoxShape.circle,
            ),
            child: Image.asset( // Lebih baik gunakan Icon
              "lib/icons/bell.png", // Pastikan path ini benar
              width: 6.w, // Ukuran ikon responsif
              height: 6.w,
              color: AppColors.white,
              // Fallback jika gambar gagal dimuat
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.notifications_none_outlined, // Icon outline
                color: AppColors.white,
                size: 6.w,
              ),
            ),
          ),
          // Indikator notifikasi (dot merah)
          Container(
            width: 2.5.w,
            height: 2.5.w,
            margin: EdgeInsets.all(0.5.w),
            decoration: const BoxDecoration(
              color: AppColors.primaryRed, // Warna merah solid
              shape: BoxShape.circle,
              border: Border.fromBorderSide( // Tambahkan border putih kecil
                BorderSide(color: AppColors.darkRed, width: 1)
              )
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk Search Bar Kustom
  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: InkWell( // Gunakan InkWell untuk efek ripple saat diketuk
         borderRadius: AppStyles.borderRadiusMedium, // Ripple mengikuti border radius
         onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade, // Transisi fade
                duration: const Duration(milliseconds: 300),
                child: const AddComplaintPage(), // Ganti ke nama screen yang benar
              ),
            );
          },
         child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: AppStyles.borderRadiusMedium,
              boxShadow: const [AppStyles.searchBarShadow], // Gunakan shadow dari AppStyles
            ),
            child: Row(
              children: [
                Icon(Icons.search_rounded, color: AppColors.accentRed, size: 20.sp),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text( // Gunakan Text karena tidak bisa diedit langsung
                    "Cari Aduan Kamu ...",
                    style: AppTextStyles.searchHint,
                  ),
                ),
                 // Icon Mic bisa ditambahkan jika ada fitur voice search
                // Icon(Icons.mic_none_outlined, color: AppColors.accentRed, size: 20.sp),
              ],
            ),
          ),
      ),
    );
  }

  // Widget untuk bagian TabBar
  Widget _buildTabBarSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: Container(
        padding: EdgeInsets.all(1.w), // Padding dalam container
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.mediumGrey),
          color: AppColors.lightGrey,
          borderRadius: AppStyles.borderRadiusSmall,
        ),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: AppColors.accentRed, // Warna indikator aktif
            borderRadius: AppStyles.borderRadiusXSmall, // Sesuaikan radius
             boxShadow: const [ // Tambahkan shadow halus pada indikator
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                  )
                ]
          ),
          indicatorSize: TabBarIndicatorSize.tab, // Indikator selebar tab
          labelColor: AppColors.white, // Warna teks tab aktif
          unselectedLabelColor: AppColors.darkGrey, // Warna teks tab tidak aktif
          labelStyle: AppTextStyles.tabLabel.copyWith(fontSize: 14.sp), // Sedikit lebih kecil
          unselectedLabelStyle: AppTextStyles.tabLabel.copyWith(fontSize: 14.sp),
          tabs: const [
            Tab(text: "Mendatang"), // Ganti teks jika perlu
            Tab(text: "Selesai"),
            Tab(text: "Dibatalkan"),
          ],
        ),
      ),
    );
  }

 // Widget untuk konten utama (TabBarView atau Shimmer)
 Widget _buildContent() {
   return Padding(
      // Padding bawah agar tidak tertutup FAB jika konten panjang
      padding: EdgeInsets.only(bottom: 10.h),
      child: _isLoading
          ? _buildShimmerTab() // Tampilkan shimmer saat loading
          : TabBarView(
              controller: _tabController,
              // Isi dengan widget tab yang sesungguhnya
              children: const [
                shedule_tab1(), // Pastikan widget ini ada
                shedule_tab1(), // Mungkin seharusnya ScheduleTab2 atau yang lain?
                shedule_tab2(), // Pastikan widget ini ada
              ],
            ),
    );
  }


  // Widget Shimmer untuk efek loading pada tab
  Widget _buildShimmerTab() {
    return Shimmer.fromColors(
      baseColor: AppColors.grey300, // Warna dasar shimmer
      highlightColor: AppColors.grey100, // Warna highlight shimmer
      child: ListView( // Gunakan ListView agar bisa discroll jika shimmer tinggi
         physics: const NeverScrollableScrollPhysics(), // Nonaktifkan scroll shimmer
         padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
         children: List.generate(3, (index) => // Buat beberapa item shimmer
             Container(
                margin: EdgeInsets.only(bottom: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.white, // Warna background item shimmer
                  borderRadius: AppStyles.borderRadiusMedium,
                ),
                height: 15.h, // Tinggi item shimmer
                width: double.infinity,
           ),
         )
      ),
    );
  }

  // Widget untuk Floating Action Button
  Widget _buildFloatingActionButton() {
    return Padding(
      // Padding bawah agar tidak terlalu mepet ke tepi
      padding: EdgeInsets.only(bottom: 2.h, right: 1.w),
      child: FloatingActionButton.extended( // Gunakan extended FAB
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeftWithFade, // Transisi kombinasi
              child: const AddComplaintPage(),
            ),
          );
        },
        backgroundColor: AppColors.accentRed,
        icon: const Icon(Icons.add_comment_outlined, color: AppColors.white), // Icon yang relevan
        label: Text("Buat Aduan", style: GoogleFonts.poppins(color: AppColors.white, fontWeight: FontWeight.w600)),
        elevation: 8, // Beri shadow lebih jelas
        tooltip: 'Buat Aduan Baru',
      ),
    ).animate().scale(delay: 500.ms); // Animasi scale untuk FAB
  }
}