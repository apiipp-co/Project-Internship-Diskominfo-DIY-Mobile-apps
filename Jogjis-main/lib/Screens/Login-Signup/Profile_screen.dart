import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Pastikan path ini benar
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:developer' as developer; // Untuk logging

// --- Konstanta Gaya ---
class AppStyles {
  // Gradient AppBar SAMA PERSIS seperti MessageTabAll.dart
  static const LinearGradient appBarGradient = LinearGradient(
    colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 79, 5, 5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Sisa AppStyles dari Profile_screen (tidak diubah jika tidak terkait AppBar)
  static const LinearGradient buttonGradient = LinearGradient(
    colors: [Color(0xFFD32F2F), Color(0xFFB71C1C)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Color primaryAccentColor = Color(0xFFD32F2F);
  // static const Color secondaryTextColor = Colors.white70; // Tidak perlu jika dipakai langsung
  static const Color primaryTextColorLight = Colors.black87;
  static const Color primaryTextColorDark = Colors.white;
  static const Color cardColorLight = Colors.white;
  static const Color cardColorDark = Color(0xFF424242);
  static const Color iconColorLight = Colors.black54;
  static const Color iconColorDark = Colors.white70;

  static final BorderRadius cardBorderRadius = BorderRadius.circular(15.sp);
  static final BorderRadius bottomSheetRadius = BorderRadius.vertical(top: Radius.circular(25.sp));

  // Radius AppBar SAMA PERSIS seperti MessageTabAll.dart (menggunakan const dan nilai literal)
  static const BorderRadius appBarActualRadius = BorderRadius.vertical(bottom: Radius.circular(30));


  static final BoxShadow cardShadow = BoxShadow(
    color: Colors.black.withOpacity(0.08),
    blurRadius: 10,
    offset: const Offset(0, 4),
  );

  static TextStyle getTitleStyle(BuildContext context, {double? size}) {
    return GoogleFonts.lato(
      fontSize: size ?? 22.sp,
      fontWeight: FontWeight.bold,
      color: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? primaryTextColorDark
          : primaryTextColorLight,
    );
  }

   static TextStyle getSubtitleStyle(BuildContext context, {double? size}) {
    return GoogleFonts.lato(
      fontSize: size ?? 15.sp,
      fontWeight: FontWeight.w500,
      color: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? Colors.white70
          : Colors.black54,
    );
  }

  static TextStyle getBodyStyle(BuildContext context, {double? size, Color? color, FontWeight? weight}) {
     return GoogleFonts.lato(
      fontSize: size ?? 14.sp,
      fontWeight: weight ?? FontWeight.normal,
      color: color ?? (MediaQuery.of(context).platformBrightness == Brightness.dark
          ? primaryTextColorDark
          : primaryTextColorLight),
    );
  }

   static TextStyle getButtonStyle(BuildContext context) {
     return GoogleFonts.lato(
      fontSize: 15.sp,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
   }
}

// --- Widget Utama ---
class Profile_screen extends StatefulWidget {
  const Profile_screen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<Profile_screen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool _isLoading = true;

  final Map<String, dynamic> _profileData = {
    'name': 'Adhitya Afif Ardana',
    'avatar': 'lib/icons/avatar.png',
    'nik': '3402XXXXXXXXXX',
    'pekerjaan': 'Software Engineer',
    'telepon': '0851 XXXXXXXX',
  };

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _fetchProfileData();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  Future<void> _fetchProfileData({bool isRefresh = false}) async {
    if (!isRefresh) {
       setState(() => _isLoading = true);
    }
    developer.log("Fetching profile data...");
    await Future.delayed(Duration(seconds: isRefresh ? 1 : 2));
    if (mounted) {
      setState(() => _isLoading = false);
      _animationController.forward(from: 0.0);
      if (isRefresh) _refreshController.refreshCompleted();
       developer.log("Profile data loaded (simulated).");
    }
  }

  Future<void> _onRefresh() async {
    await _fetchProfileData(isRefresh: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  BoxDecoration _cardDecoration(BuildContext context) {
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return BoxDecoration(
      color: isDarkMode ? AppStyles.cardColorDark : AppStyles.cardColorLight,
      borderRadius: AppStyles.cardBorderRadius,
      boxShadow: [AppStyles.cardShadow],
    );
  }

  Widget _buildShimmerProfile() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            SizedBox(height: 3.h), // Beri jarak dari appbar baru
            const CircleAvatar(radius: 55, backgroundColor: Colors.white),
            SizedBox(height: 2.h),
            Container(width: 45.w, height: 2.5.h, color: Colors.white, margin: EdgeInsets.only(bottom: 0.5.h)),
            Container(width: 35.w, height: 1.8.h, color: Colors.white),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                3,
                (_) => Container(
                  width: 28.w,
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: AppStyles.cardBorderRadius,
                  ),
                ),
              ),
            ),
             SizedBox(height: 4.h),
             Column(
               children: List.generate(5, (index) => Container(
                 height: 6.h,
                 margin: EdgeInsets.symmetric(vertical: 1.h),
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(10.sp),
                 ),
               )),
             )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final scaffoldColor = isDarkMode ? const Color(0xFF212121) : const Color(0xFFF5F5F5);
    final textColor = isDarkMode ? AppStyles.primaryTextColorDark : AppStyles.primaryTextColorLight;

    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(12.h), // SAMA PERSIS
        child: _buildExactAppBar(context), // Menggunakan AppBar yang baru dan SAMA PERSIS
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: AppStyles.primaryAccentColor),
          waterDropColor: AppStyles.primaryAccentColor,
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
             SliverToBoxAdapter(
               // Konten shimmer atau profil akan mulai sedikit di bawah AppBar
               child: Padding(
                 padding: EdgeInsets.only(top: 1.h), // Sesuaikan jika perlu jarak dari AppBar
                 child: _isLoading
                    ? _buildShimmerProfile()
                    : _buildProfileContent(context, textColor),
               )
             )
          ],
        ),
      ),
    );
  }

  // --- AppBar YANG SAMA PERSIS dengan MessageTabAll ---
  Widget _buildExactAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 6.h, left: 5.w, right: 5.w, bottom: 2.h), // SAMA PERSIS
      decoration: BoxDecoration(
        gradient: AppStyles.appBarGradient, // SAMA PERSIS (dari AppStyles Profile_screen yang sudah disamakan)
        borderRadius: AppStyles.appBarActualRadius, // SAMA PERSIS (Radius.circular(30))
        boxShadow: const [ // SAMA PERSIS
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row( // Struktur Kiri SAMA PERSIS
            children: [
              SizedBox(width: 3.w), // SAMA PERSIS
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text( // Judul SAMA PERSIS
                    "Profil",
                    style: GoogleFonts.inter(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  Text( // Subjudul SAMA PERSIS
                    "Chat with support",
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70, // Warna langsung SAMA PERSIS
                    ),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector( // Notifikasi SAMA PERSIS
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Notifications Coming Soon!',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  backgroundColor: const Color(0xFF03BE96),
                ),
              );
            },
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    "lib/icons/bell.png", // SAMA PERSIS
                    width: 24, // Ukuran width 24 (bukan .sp) SAMA PERSIS
                    color: Colors.white,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.notifications,
                        size: 24, // Ukuran size 24 (bukan .sp) SAMA PERSIS
                        color: Colors.white
                    ),
                  ),
                ),
                Positioned( // Badge SAMA PERSIS
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 10, // Ukuran width 10 SAMA PERSIS
                    height: 10, // Ukuran height 10 SAMA PERSIS
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.2); // Animasi SAMA PERSIS
  }


  // --- Konten Utama Profil (Setelah Loading) ---
   Widget _buildProfileContent(BuildContext context, Color textColor) {
     return Column(
       children: [
          // Padding atas sudah diatur di SliverToBoxAdapter di atas
          _buildProfileHeader(context, textColor)
              .animate(controller: _animationController)
              .fadeIn(duration: 500.ms)
              .slideY(begin: 0.2),
          SizedBox(height: 4.h),
          _buildProfileStats(context)
              .animate(controller: _animationController)
              .fadeIn(delay: 100.ms, duration: 500.ms)
              .slideY(begin: 0.2),
          SizedBox(height: 4.h),
          _buildProfileOptions(context)
             .animate(controller: _animationController)
             .fadeIn(delay: 200.ms, duration: 500.ms)
             .slideY(begin: 0.2),
          SizedBox(height: 4.h),
       ],
     );
   }


  // --- Header Profil ---
  Widget _buildProfileHeader(BuildContext context, Color textColor) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
                radius: 55.sp,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(_profileData['avatar']),
                onBackgroundImageError: (_, __) {
                  developer.log("Error loading avatar image.");
                },
                child: _profileData['avatar'] == null || _profileData['avatar'].isEmpty
                    ? Icon(Icons.person, size: 60.sp, color: Colors.grey[400])
                    : null,
            ),
            Positioned(
              bottom: -5,
              right: -5,
              child: InkWell(
                 onTap: () {
                    developer.log("Edit profile picture tapped");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Fitur ganti foto belum tersedia.", style: AppStyles.getBodyStyle(context))),
                    );
                  },
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  padding: EdgeInsets.all(6.sp),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppStyles.primaryAccentColor,
                    border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 2)
                  ),
                  child: Icon(Icons.edit_outlined, color: Colors.white, size: 16.sp),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Text(
          _profileData['name'],
          style: AppStyles.getTitleStyle(context, size: 19.sp),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // --- Statistik Profil ---
  Widget _buildProfileStats(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatCard(
            context: context,
            iconData: Icons.credit_card,
            title: "NIK",
            value: _profileData['nik'],
          ).animate().slideX(begin: -0.2, delay: 300.ms).fadeIn(),
          _buildStatCard(
            context: context,
            iconData: Icons.work_outline,
            title: "Pekerjaan",
            value: _profileData['pekerjaan'],
          ).animate().slideY(begin: 0.2, delay: 400.ms).fadeIn(),
          _buildStatCard(
            context: context,
            iconData: Icons.phone_outlined,
            title: "No Telepon",
            value: _profileData['telepon'],
          ).animate().slideX(begin: 0.2, delay: 500.ms).fadeIn(),
        ],
      ),
    );
  }

  // --- Card Statistik Individual ---
  Widget _buildStatCard({
      required BuildContext context,
      required IconData iconData,
      required String title,
      required String value}) {
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      width: 28.w,
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
      decoration: _cardDecoration(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, size: 28.sp, color: AppStyles.primaryAccentColor),
          SizedBox(height: 1.h),
          Text(
            title,
            style: AppStyles.getSubtitleStyle(context, size: 13.sp),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 0.5.h),
          Text(
            value,
            style: AppStyles.getBodyStyle(context,
                size: 14.sp,
                weight: FontWeight.w600,
                color: isDarkMode ? Colors.white : Colors.black87),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // --- Opsi-opsi Profil ---
 Widget _buildProfileOptions(BuildContext context) {
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final options = [
      {
        'icon': Icons.history_outlined,
        'title': 'Riwayat Aduan',
        'color': isDarkMode ? AppStyles.primaryTextColorDark : AppStyles.primaryTextColorLight,
        'route': () {
            _showComingSoonSnackbar(context, "Riwayat Aduan");
        }
      },
      {
        'icon': Icons.info_outline,
        'title': 'Informasi Aplikasi',
        'color': isDarkMode ? AppStyles.primaryTextColorDark : AppStyles.primaryTextColorLight,
        'route': () {
            _showComingSoonSnackbar(context, "Informasi Aplikasi");
        }
      },
       {
        'icon': Icons.help_outline,
        'title': 'Pusat Bantuan (FAQ)',
        'color': isDarkMode ? AppStyles.primaryTextColorDark : AppStyles.primaryTextColorLight,
        'route': () {
            _showComingSoonSnackbar(context, "Pusat Bantuan");
        }
      },
       {
        'icon': Icons.settings_outlined,
        'title': 'Pengaturan Akun',
        'color': isDarkMode ? AppStyles.primaryTextColorDark : AppStyles.primaryTextColorLight,
        'route': () {
            _showComingSoonSnackbar(context, "Pengaturan Akun");
        }
      },
      {
        'icon': Icons.logout,
        'title': 'Keluar Akun',
        'color': AppStyles.primaryAccentColor,
        'route': () => _showLogoutDialog(context)
      },
    ];

    return Material(
      color: isDarkMode ? AppStyles.cardColorDark : AppStyles.cardColorLight,
      shape: RoundedRectangleBorder(borderRadius: AppStyles.bottomSheetRadius),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Column(
          children: options.asMap().entries.map((entry) {
            int index = entry.key;
            final option = entry.value;
            final isLastItem = index == options.length - 1;

            return Column(
              children: [
                 _buildProfileOptionItem(
                   context: context,
                   icon: option['icon'] as IconData,
                   title: option['title'] as String,
                   color: option['color'] as Color,
                   onTap: option['route'] as VoidCallback,
                 ).animate()
                  .fadeIn(delay: (300 + index * 50).ms, duration: 400.ms)
                  .slideX(begin: 0.1, duration: 400.ms),

                if (!isLastItem)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0.5.h),
                    child: Divider(height: 1, thickness: 0.5, color: Colors.grey.withOpacity(0.3)),
                  ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  // --- Helper untuk membuat satu item opsi profil ---
  Widget _buildProfileOptionItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
       onTap: onTap,
       child: Padding(
         padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.8.h),
         child: Row(
           children: [
             Icon(icon, color: color, size: 22.sp),
             SizedBox(width: 4.w),
             Expanded(
               child: Text(
                 title,
                 style: AppStyles.getBodyStyle(context, color: color, weight: FontWeight.w500, size: 15.sp),
               ),
             ),
             Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.grey[400]),
           ],
         ),
       ),
     );
  }


  // --- Dialog Konfirmasi Keluar ---
  void _showLogoutDialog(BuildContext context) {
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp)),
        backgroundColor: isDarkMode ? AppStyles.cardColorDark : AppStyles.cardColorLight,
        title: Text(
          "Konfirmasi Keluar",
          style: AppStyles.getTitleStyle(context, size: 18.sp)
        ),
        content: Text(
            "Apakah Anda yakin ingin keluar dari akun ini?",
             style: AppStyles.getBodyStyle(context)
         ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal", style: AppStyles.getBodyStyle(context, color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              developer.log("Logout process started...");
              Navigator.pop(context);
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Anda telah keluar.", style: AppStyles.getBodyStyle(context))),
              );
            },
            child: Text("Keluar", style: AppStyles.getBodyStyle(context, color: AppStyles.primaryAccentColor, weight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

   // --- Helper Snackbar Coming Soon ---
   void _showComingSoonSnackbar(BuildContext context, String featureName) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Fitur "$featureName" segera hadir!',
              style: AppStyles.getButtonStyle(context).copyWith(color: AppStyles.primaryTextColorLight),
            ),
            backgroundColor: Colors.white,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.sp),
            ),
             margin: EdgeInsets.all(10.sp),
          ),
        );
   }
}