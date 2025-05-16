import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:JogjaIstimewa/Screens/Views/chat_screen.dart'; // Pastikan import ini benar
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_animate/flutter_animate.dart';

// --- AppStyles: Palet Warna dan Gaya Terpusat ---
class AppStyles {
  // AppBar Gradient DIKEMBALIKAN ke versi awal yang Anda berikan
  static const LinearGradient appBarGradient = LinearGradient(
    colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 79, 5, 5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Gaya lain dari pembaruan "keren dan bagus" TETAP DIPERTAHANKAN untuk elemen body
  static const Color primaryColor = Color.fromARGB(255, 196, 0, 0);
  static const Color accentColor = Color(0xFF03BE96); // Digunakan di SnackBar notifikasi AppBar dan elemen body

  static const Color lightBackgroundColor = Color(0xFFF5F7FA);
  static const Color cardColor = Colors.white;
  
  static const Color onlineIndicatorColor = Color(0xFF4CAF50);
  static const Color offlineIndicatorColor = Colors.grey;

  static final BorderRadius cardBorderRadius = BorderRadius.circular(16.sp);

  static final List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 15,
      spreadRadius: 0,
      offset: const Offset(0, 5),
    ),
  ];
}

class MessageTabAll extends StatefulWidget {
  const MessageTabAll({super.key});

  @override
  MessageTabAllState createState() => MessageTabAllState();
}

class MessageTabAllState extends State<MessageTabAll> with TickerProviderStateMixin {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool _isLoading = true;
  late AnimationController _fabAnimationController;

  final List<Map<String, dynamic>> _allChats = [
    {
      'image': 'lib/icons/helpdesk1.png',
      'name': 'DISKOMINFO DIY',
      'message': 'Laporan Anda mengenai pohon tumbang telah diterima dan sedang diproses.',
      'time': '10:24',
      'messageCount': '2',
      'isOnline': true,
    },
    {
      'image': 'lib/icons/helpdesk2.png',
      'name': 'Budi Setiawan',
      'message': 'Terima kasih banyak atas bantuan dan respons cepatnya!',
      'time': '09:15',
      'messageCount': '0',
      'isOnline': false,
    },
    {
      'image': 'lib/icons/helpdesk3.png',
      'name': 'Citra Lestari',
      'message': 'Selamat pagi, apakah ada perkembangan terbaru mengenai permintaan saya?',
      'time': 'Kemarin',
      'messageCount': '1',
      'isOnline': true,
    },
    {
      'image': 'lib/icons/helpdesk4.png',
      'name': 'Tim Support Jogja',
      'message': 'PENTING: Akan ada maintenance sistem malam ini pukul 02:00 - 04:00 WIB.',
      'time': '1 Jam lalu',
      'messageCount': '0',
      'isOnline': true,
    },
     {
      'image': 'lib/icons/user_avatar.png',
      'name': 'Layanan Darurat 112',
      'message': 'Kejadian darurat apa yang bisa kami bantu? Mohon informasikan lokasi Anda.',
      'time': 'Baru saja',
      'messageCount': '3',
      'isOnline': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _simulateLoading();
  }

  Future<void> _simulateLoading() async {
    if (mounted) setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() => _isLoading = false);
      _fabAnimationController.forward();
    }
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    if (mounted) {
      _allChats.shuffle();
      setState(() {});
      _refreshController.refreshCompleted();
      if (!_isLoading) {
        _fabAnimationController.reset();
        _fabAnimationController.forward();
      }
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }

  Widget _buildShimmerChatItem() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[50]!,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 14.sp),
        margin: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 6.sp),
        decoration: BoxDecoration(
          color: AppStyles.cardColor,
          borderRadius: AppStyles.cardBorderRadius,
        ),
        child: Row(
          children: [
            CircleAvatar(radius: 28.sp, backgroundColor: Colors.white),
            SizedBox(width: 14.sp),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 60.w, height: 16.sp, color: Colors.white, margin: EdgeInsets.only(bottom: 6.sp)),
                  Container(width: 80.w, height: 14.sp, color: Colors.white),
                ],
              ),
            ),
            SizedBox(width: 8.sp),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Container(width: 40.sp, height: 12.sp, color: Colors.white, margin: EdgeInsets.only(bottom: 8.sp)),
                 CircleAvatar(radius: 12.sp, backgroundColor: Colors.white),
              ],
            )
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.lightBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(12.h), // PreferredSize dari kode asli Anda
        child: _buildAppBar(), // Memanggil _buildAppBar versi asli Anda
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        header: WaterDropHeader(
          waterDropColor: AppStyles.primaryColor,
          complete: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline_rounded, color: AppStyles.accentColor, size: 22.sp),
              SizedBox(width: 8.sp),
              Text("Berhasil dimuat", style: GoogleFonts.poppins(fontSize: 14.sp, color: AppStyles.accentColor)),
            ],
          ),
          idleIcon: Icon(Icons.autorenew_rounded, color: AppStyles.primaryColor.withOpacity(0.7), size: 22.sp),
        ),
        child: _isLoading
            ? ListView.builder(
                padding: EdgeInsets.only(top: 2.h, bottom: 12.h),
                itemCount: 5,
                itemBuilder: (_, __) => _buildShimmerChatItem(),
              )
            : _allChats.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    padding: EdgeInsets.only(top: 2.h, bottom: 12.h),
                    itemCount: _allChats.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 0.5,
                      thickness: 0.5,
                      color: Colors.grey[200],
                      indent: 20.w,
                      endIndent: 5.w,
                    ),
                    itemBuilder: (context, index) {
                      final chat = _allChats[index];
                      return _buildChatItem(
                        context: context,
                        image: chat['image'],
                        name: chat['name'],
                        message: chat['message'],
                        time: chat['time'],
                        messageCount: chat['messageCount'] ?? '0',
                        isOnline: chat['isOnline'] ?? false,
                        index: index,
                      )
                      .animate()
                      .fadeIn(delay: (50 * index).ms, duration: 350.ms)
                      .slideX(begin: 0.1, curve: Curves.easeOutCubic, duration: 350.ms);
                    },
                  ),
      ),
      floatingActionButton: Animate(
        controller: _fabAnimationController,
        effects: [
          FadeEffect(duration: 300.ms, curve: Curves.easeOut), 
          ScaleEffect(begin: Offset(0.8, 0.8), curve: Curves.elasticOut, duration: 500.ms)
        ],
        child: FloatingActionButton.extended(
          onPressed: () {
             ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Fitur "Buat Pesan Baru" segera hadir!', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500)),
                  backgroundColor: AppStyles.accentColor,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp)),
                  margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  elevation: 6,
                ),
              );
          },
          backgroundColor: AppStyles.primaryColor,
          icon: Icon(Icons.message_rounded, color: Colors.white, size: 19.sp),
          label: Text("Pesan Baru", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 13.5.sp)),
          elevation: 4,
          highlightElevation: 8,
        ),
      ),
    );
  }

  // _buildAppBar DIKEMBALIKAN ke versi yang Anda berikan di awal (sebelum pembaruan terakhir saya)
  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.only(top: 6.h, left: 5.w, right: 5.w, bottom: 2.h),
      decoration: BoxDecoration(
        gradient: AppStyles.appBarGradient, // Menggunakan gradient dari AppStyles yang sudah dikembalikan
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)), // Radius hardcoded versi awal
        boxShadow: const [ // Shadow hardcoded versi awal
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
          Row(
            children: [
              SizedBox(width: 3.w), // SizedBox dari versi Anda
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Helpdesk", // Teks Title dari versi Anda
                    style: GoogleFonts.inter(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Chat with support", // Teks Subtitle dari versi Anda
                    style: GoogleFonts.inter(
                      fontSize: 14.sp, // Ukuran font subtitle dari versi Anda
                      fontWeight: FontWeight.w400,
                      color: Colors.white70, // Warna subtitle dari versi Anda
                    ),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector( // Notifikasi dari versi Anda
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar( // SnackBar dari versi Anda
                  content: Text(
                    'Notifications Coming Soon!', // Teks SnackBar dari versi Anda
                    style: GoogleFonts.poppins(color: Colors.white), // Style teks SnackBar dari versi Anda
                  ),
                  backgroundColor: AppStyles.accentColor, // accentColor tetap dari AppStyles yang disempurnakan
                ),
              );
            },
            child: Stack( // Bell icon dari versi Anda
              children: [
                Container(
                  padding: EdgeInsets.all(2.w), // Padding dari versi Anda
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2), // Opacity dari versi Anda
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    "lib/icons/bell.png", // Image.asset dari versi Anda (Pastikan path ini benar)
                    width: 24, // Lebar tetap dari versi Anda
                    color: Colors.white,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.notifications, color: Colors.white, size: 24), // Fallback dari versi Anda
                  ),
                ),
                Positioned( // Notif dot dari versi Anda
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 10, // Lebar tetap dari versi Anda
                    height: 10, // Tinggi tetap dari versi Anda
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
    ).animate().fadeIn().slideY(begin: -0.2); // Animasi AppBar dari versi Anda
  }


  Widget _buildEmptyState() {
    return Center(
      heightFactor: 2.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_outline_rounded, size: 55.sp, color: Colors.grey[350]),
          SizedBox(height: 2.5.h),
          Text(
            "Belum Ada Pesan",
            style: GoogleFonts.poppins(fontSize: 17.sp, fontWeight: FontWeight.w600, color: Colors.grey[500]),
          ),
          SizedBox(height: 1.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              "Ayo mulai percakapan baru dengan menekan tombol 'Pesan Baru' di bawah!",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 13.5.sp, color: Colors.grey[400], height: 1.5),
            ),
          ),
        ],
      ).animate().fadeIn(duration: 600.ms).scale(delay: 250.ms, begin: Offset(0.9, 0.9), curve: Curves.elasticOut),
    );
  }

  Widget _buildChatItem({
    required BuildContext context,
    required String image,
    required String name,
    required String message,
    required String time,
    required String messageCount,
    required bool isOnline,
    required int index,
  }) {
    final bool hasUnreadMessages = messageCount.isNotEmpty && messageCount != '0';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(type: PageTransitionType.rightToLeftWithFade, duration: 300.ms, child: chat_screen()),
          );
        },
        splashColor: AppStyles.primaryColor.withOpacity(0.15),
        highlightColor: AppStyles.primaryColor.withOpacity(0.08),
        borderRadius: AppStyles.cardBorderRadius,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 14.sp),
          margin: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 6.sp),
          decoration: BoxDecoration(
            color: AppStyles.cardColor,
            borderRadius: AppStyles.cardBorderRadius,
            boxShadow: AppStyles.cardShadow,
          ),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 28.sp,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: AssetImage(image),
                    onBackgroundImageError: (exception, stackTrace) {
                      // Log error or handle UI update if needed
                    },
                    child: Icon(Icons.person_outline_rounded, size: 22.sp, color: Colors.grey[400]),
                  ),
                  if (isOnline)
                    Positioned(
                      right: 0.sp, bottom: 0.sp,
                      child: Container(
                        width: 12.sp, height: 12.sp,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppStyles.onlineIndicatorColor,
                          border: Border.all(color: AppStyles.cardColor, width: 2.sp),
                        ),
                      )
                      .animate(onPlay: (controller) => controller.repeat(reverse: true))
                       .scaleXY(end: 1.25, duration: 1000.ms, curve: Curves.easeInOutSine)
                       .then(delay: 200.ms)
                       .scaleXY(end: 1/1.25, duration: 1000.ms, curve: Curves.easeInOutSine),
                    ),
                ],
              ),
              SizedBox(width: 14.sp),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.poppins(fontSize: 15.5.sp, fontWeight: FontWeight.w600, color: Colors.black87),
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3.sp),
                    Text(
                      message,
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        color: hasUnreadMessages ? Colors.black.withOpacity(0.75) : Colors.grey[600],
                        fontWeight: hasUnreadMessages ? FontWeight.w500 : FontWeight.normal,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.sp),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    time,
                    style: GoogleFonts.poppins(fontSize: 11.sp, color: Colors.grey[500]),
                  ),
                  SizedBox(height: hasUnreadMessages ? 5.sp : 22.sp),
                  if (hasUnreadMessages)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 7.sp, vertical: 3.5.sp),
                      decoration: BoxDecoration(
                        color: AppStyles.primaryColor,
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: Text(
                        messageCount,
                        style: GoogleFonts.poppins(fontSize: 10.sp, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ).animate().scale(delay: 250.ms, duration: 400.ms, curve: Curves.elasticOut, begin: Offset(0.5,0.5))
                     .then().shimmer(delay: 600.ms, duration: 1000.ms, color: AppStyles.primaryColor.withOpacity(0.5)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}