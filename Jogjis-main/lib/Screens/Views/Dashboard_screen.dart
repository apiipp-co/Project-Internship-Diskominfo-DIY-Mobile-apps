import 'package:JogjaIstimewa/Screens/Views/idmc_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:JogjaIstimewa/Screens/Views/articlePage.dart';
import 'package:JogjaIstimewa/Screens/Views/cctv_search.dart';
import 'package:JogjaIstimewa/Screens/Views/find_cctv.dart';
import 'package:JogjaIstimewa/Screens/Widgets/banner.dart';
import 'package:JogjaIstimewa/Screens/Widgets/event_carousel.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animations/animations.dart';
import 'package:JogjaIstimewa/Screens/Views/jogja_iy_page.dart'; // Tambahkan ini
import 'package:JogjaIstimewa/Screens/Views/dokumen_publik_page.dart';
import 'package:JogjaIstimewa/Screens/Views/jsp_page.dart';

class AppStyles {
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 79, 5, 5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient appBarGradient = LinearGradient(
    colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 79, 5, 5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient eventGradient = LinearGradient(
    colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 79, 5, 5)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static BoxDecoration cardDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 15,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool _isLoading = true;
  String _selectedCategory = 'All';

  final Map<String, String> _categoryDescriptions = {
    'Health': 'Akses layanan perawatan kesehatan, buat janji temu, dan temukan informasi medis.',
    'Education': 'Jelajahi sumber daya pendidikan, sekolah, dan kesempatan belajar.',
    'Social': 'Terhubung dengan acara komunitas, layanan sosial, dan pertemuan lokal.',
    'Government': 'Akses layanan pemerintah, pengumuman publik, dan informasi sipil.',
    'Citizen': 'Terlibat dalam layanan warga dan inisiatif komunitas.',
    'Jelajah Jogja': 'Jelajahi tempat-tempat menarik seperti ATM, hotel, restoran, dan wisma di Yogyakarta.',
    'One Data': 'Lihat data dan statistik terpusat untuk wilayah tersebut.',
    'More': 'Temukan layanan dan fitur tambahan.',
    'Tourism': 'Jelajahi destinasi wisata dan atraksi di Yogyakarta.',
    'Culture': 'Pelajari budaya dan tradisi lokal Yogyakarta.',
    'Transportation': 'Akses informasi transportasi umum dan layanan terkait.',
    'Emergency': 'Hubungi layanan darurat dengan cepat.',
    'Environment': 'Dapatkan informasi tentang inisiatif lingkungan dan keberlanjutan.',
    'Sports': 'Ikuti acara olahraga dan kegiatan rekreasi di Yogyakarta.',
    'Economy': 'Akses informasi ekonomi, peluang bisnis, dan statistik pasar.',
    'Technology': 'Jelajahi inovasi teknologi dan layanan digital di Yogyakarta.',
    'Informasi Keuangan Daerah': 'Akses informasi keuangan daerah, laporan anggaran, dan dokumen terkait.',
  };

final List<Map<String, dynamic>> _newsItems = [
  {
    'image': 'lib/icons/news1.jpeg', // Example path
    'title': 'Berita Terkini Jogja',
    'date': DateTime.now().subtract(const Duration(days: 1)),
    'category': 'Politik',
    'readTime': 5, // Assuming 'readTime' is an int (minutes)
  },
  // ... more news items
];

  final List<Map<String, dynamic>> _eventItems = [
    {
      'image': 'lib/icons/news2.jpeg',
      'title': 'Pertunjukan Wayang Kulit',
      'date': DateTime.now().add(const Duration(days: 9)),
      'location': 'Padepokan Seni Bagong Kussudiardja',
      'speaker': 'Ki Seno Nugroho',
      'category': 'Budaya',
    },
    {
      'image': 'lib/icons/event2.jpeg',
      'title': 'Festival Budaya Yogyakarta',
      'date': DateTime.now().add(const Duration(days: 12)),
      'location': 'Taman Budaya Yogyakarta',
      'speaker': 'Dr. Soedjarwo',
      'category': 'Budaya',
    },
    {
      'image': 'lib/icons/event3.jpeg',
      'title': 'Workshop Seni Lukis',
      'date': DateTime.now().add(const Duration(days: 5)),
      'location': 'Galeri Seni Yogyakarta',
      'speaker': 'Prof. Tono',
      'category': 'Seni',
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _simulateLoading();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  Future<void> _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {});
      _refreshController.refreshCompleted();
    }
  }

  Widget _buildSectionHeader(String title, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          _buildGradientButton(
            text: "Lihat Semua",
            onTap: onTap,
            fontSize: 14.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildGradientButton({
    required String text,
    required VoidCallback onTap,
    required double fontSize,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        decoration: BoxDecoration(
          gradient: AppStyles.primaryGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    final categories = ['All', 'Politik', 'Ekonomi', 'Lingkungan'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      child: Row(
        children: categories.map((category) {
          final isSelected = _selectedCategory == category;
          return Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: ChoiceChip(
              label: Text(
                category,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
              selected: isSelected,
              selectedColor: const Color.fromARGB(255, 255, 50, 50),
              backgroundColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onSelected: (_) => setState(() => _selectedCategory = category),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNewsCard(Map<String, dynamic> newsItem) {
    final formatter = DateFormat('MMM d, yyyy');
    final formattedDate = formatter.format(newsItem['date']);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const articlePage(),
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: 2.h),
          decoration: AppStyles.cardDecoration(context),
          child: Row(
            children: [
              _buildNewsImage(newsItem['image'], newsItem['title']),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCategoryTag(newsItem['category']),
                      SizedBox(height: 1.h),
                      Text(
                        newsItem['title'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      _buildNewsMeta(formattedDate, newsItem['readTime']),
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

  Widget _buildNewsImage(String imagePath, String title) {
    return Hero(
      tag: 'newsImage-$title',
      child: ClipRRect(
        borderRadius: const BorderRadius.horizontal(left: Radius.circular(15)),
        child: Image.asset(
          imagePath,
          width: 35.w,
          height: 20.h,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 50),
        ),
      ),
    );
  }

  Widget _buildCategoryTag(String category) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.7.h),
      decoration: BoxDecoration(
        gradient: AppStyles.primaryGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        category,
        style: GoogleFonts.poppins(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildNewsMeta(String date, int readTime) {
    return Row(
      children: [
        Icon(Icons.calendar_today_outlined, size: 14.sp, color: Colors.grey),
        SizedBox(width: 1.w),
        Text(date, style: GoogleFonts.poppins(fontSize: 13.sp, color: Colors.grey[600])),
        SizedBox(width: 2.w),
        Icon(Icons.access_time, size: 14.sp, color: Colors.grey),
        SizedBox(width: 1.w),
        Text(
          "$readTime min read",
          style: GoogleFonts.poppins(fontSize: 13.sp, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildEventCard(Map<String, dynamic> eventItem) {
    final dateFormatter = DateFormat('EEEE, d MMMM yyyy');
    final timeFormatter = DateFormat('h:mm a');
    final formattedDate = dateFormatter.format(eventItem['date']);
    final formattedTime = timeFormatter.format(eventItem['date']);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: EventDetailsPage(
                title: eventItem['title'],
                image: eventItem['image'],
                date: formattedDate,
                time: formattedTime,
                location: eventItem['location'],
                speaker: eventItem['speaker'],
                daysLeft: eventItem['date'].difference(DateTime.now()).inDays,
              ),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 2.h),
          decoration: AppStyles.cardDecoration(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEventImage(eventItem),
              Padding(
                padding: EdgeInsets.all(3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventItem['title'],
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    _buildEventInfo(Icons.event, formattedDate),
                    _buildEventInfo(Icons.access_time, formattedTime),
                    _buildEventInfo(Icons.location_on, eventItem['location']),
                    _buildEventInfo(Icons.person, eventItem['speaker']),
                    SizedBox(height: 2.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: _buildGradientButton(
                        text: 'Daftar',
                        onTap: () {},
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventImage(Map<String, dynamic> eventItem) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
      child: Stack(
        children: [
          Image.asset(
            eventItem['image'],
            height: 20.h,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 50),
          ),
          Positioned(
            top: 2.h,
            right: 2.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              decoration: BoxDecoration(
                gradient: AppStyles.primaryGradient,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.calendar_today, size: 14.sp, color: Colors.white),
                  SizedBox(width: 1.w),
                  Text(
                    '${eventItem['date'].difference(DateTime.now()).inDays} days left',
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventInfo(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        children: [
          Icon(icon, size: 16.sp, color: const Color(0xFF03BE96)),
          SizedBox(width: 1.w),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: EdgeInsets.only(bottom: 2.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        height: 20.h,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        brightness: MediaQuery.of(context).platformBrightness,
        cardColor: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? const Color.fromARGB(255, 0, 0, 0)
            : Colors.white,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showEmergencyDialog(),
          backgroundColor: const Color.fromARGB(255, 255, 50, 50),
          child: const Icon(Icons.phone, color: Colors.white),
        ),
        body: SmartRefresher(
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(),
                SizedBox(height: 3.h),
                _buildSearchBar(),
                SizedBox(height: 3.h),
                IconListWidget(categoryDescriptions: _categoryDescriptions),
                SizedBox(height: 3.h),
                const banner(),
                SizedBox(height: 4.h),
                _buildSectionHeader("CCTV", () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const cctv_search(),
                    ),
                  );
                }),
                SizedBox(height: 2.h),
                const event_carousel(),
                SizedBox(height: 4.h),
                _buildSectionHeader("News", () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const articlePage(),
                    ),
                  );
                }),
                _buildCategoryChips(),
                _buildNewsList(),
                SizedBox(height: 4.h),
                _buildSectionHeader("Event", () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: AllEventsPage(eventItems: _eventItems),
                    ),
                  );
                }),
                _buildEventList(),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.only(top: 6.h, left: 5.w, right: 5.w, bottom: 2.h),
      decoration: BoxDecoration(
        gradient: AppStyles.appBarGradient,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
        boxShadow: const [
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Jogja Istimewa",
                style: GoogleFonts.inter(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              Text(
                "Yogyakarta 31°C 🌤️",
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          GestureDetector(
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
            child: _buildNotificationIcon(),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationIcon() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            "lib/icons/bell.png",
            width: 24,
            color: Colors.white,
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.search_rounded, color: const Color.fromARGB(255, 255, 50, 50), size: 20.sp),
            SizedBox(width: 2.w),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Cari Aduan Kamu ...",
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    color: Colors.black54,
                  ),
                  border: InputBorder.none,
                ),
                onTap: () => Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const find_cctv(),
                  ),
                ),
              ),
            ),
            Icon(Icons.mic_rounded, color:const Color.fromARGB(255, 255, 50, 50), size: 20.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsList() {
    return _isLoading
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            itemCount: 3,
            itemBuilder: (_, __) => _buildShimmerCard(),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            itemCount: _newsItems.length,
            itemBuilder: (context, index) {
              final item = _newsItems[index];
              if (_selectedCategory == 'All' || item['category'] == _selectedCategory) {
                return _buildNewsCard(item);
              }
              return const SizedBox.shrink();
            },
          );
  }

  Widget _buildEventList() {
    return _isLoading
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            itemCount: 3,
            itemBuilder: (_, __) => _buildShimmerCard(),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            itemCount: _eventItems.length,
            itemBuilder: (_, index) => _buildEventCard(_eventItems[index]),
          );
  }

  void _showEmergencyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text("DARURAT", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        content: Text("Menelepon layanan darurat?", style: GoogleFonts.poppins()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel", style: GoogleFonts.poppins()),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Call", style: GoogleFonts.poppins(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class IconListWidget extends StatelessWidget {
  final Map<String, String> categoryDescriptions;

  const IconListWidget({super.key, required this.categoryDescriptions});

  List<Map<String, dynamic>> _getMainCategories() {
    return [
      {'name': 'Kesehatan', 'icon': Icons.local_hospital, 'color': const Color(0xFFFFE6E6)},
      {'name': 'Pendidikan', 'icon': Icons.school, 'color': const Color(0xFFE6F0FA)},
      {'name': 'Sosial Media', 'icon': Icons.group, 'color': const Color(0xFFF5E6FF)},
      {'name': 'Pemerintahan', 'icon': Icons.account_balance_wallet, 'color': const Color(0xFFE6F5FA)},
      {'name': 'Kependudukan', 'icon': Icons.person_outline, 'color': const Color(0xFFFFF5E6)},
      {'name': 'Jelajah Jogja', 'icon': Icons.explore, 'color': const Color(0xFFE6E6FF)},
      {'name': 'Satu Data', 'icon': Icons.data_usage, 'color': const Color(0xFFE6FAE6)},
      {'name': 'Lainnya', 'icon': Icons.more_horiz, 'color': const Color(0xFFF0F0F0)},
    ];
  }

  List<Map<String, dynamic>> _getMoreCategories() {
    return [
      {'name': 'Jogja IY', 'icon': Icons.map, 'color': const Color(0xFFE6F5FA)},
      {'name': 'Jogja Layanan Publik', 'icon': Icons.support_agent, 'color': const Color(0xFFFFE6E6)},
      {'name': 'Dokumen Publik', 'icon': Icons.description, 'color': const Color(0xFFE6FAE6)},
      {'name': 'Pemimpin Daerah', 'icon': Icons.account_circle, 'color': const Color(0xFFF5E6FF)},
      {'name': 'Keuangan Daerah', 'icon': Icons.account_balance_wallet, 'color': const Color(0xFFE6FFE6)},
      {'name': 'JSP', 'icon': Icons.sports, 'color': const Color(0xFFFFF0E6)},
      {'name': 'IDMC', 'icon': Icons.info, 'color': const Color(0xFFE6E6FA)},
      {'name': 'Sekolah', 'icon': Icons.school_outlined, 'color': const Color(0xFFF0E6FF)},
    ];
  }

  List<Map<String, dynamic>> _getSocialMediaOptions() {
    return [
      {
        'name': 'WhatsApp',
        'icon': FontAwesomeIcons.whatsapp,
        'color': const Color(0xFF25D366),
        'description': 'Terhubung dengan kami melalui WhatsApp untuk informasi dan dukungan cepat.',
        'action': () async {
          const url = 'http://bit.ly/4lRl2Pl';
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url));
          } else {
            print('Could not launch WhatsApp');
          }
        },
      },
      {
        'name': 'Instagram',
        'icon': FontAwesomeIcons.instagram,
        'color': const Color(0xFFE4405F),
        'description': 'Ikuti kami di Instagram untuk update terbaru dan konten menarik.',
        'action': () async {
          const url = 'https://www.instagram.com/kominfodiy?igsh=MWFxbmNqenpiMGQ1MA==';
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url));
          } else {
            print('Could not launch Instagram');
          }
        },
      },
      {
        'name': 'Twitter',
        'icon': FontAwesomeIcons.twitter,
        'color': const Color(0xFF1DA1F2),
        'description': 'Dapatkan berita terkini dan informasi penting melalui Twitter kami.',
        'action': () async {
          const url = 'https://x.com/kominfodiy?s=11';
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url));
          } else {
            print('Could not launch Twitter');
          }
        },
      },
    ];
  }

List<Map<String, dynamic>> _getHealthOptions() {
  return [
    {
      'name': 'Jogia Sehat',
      'icon': Icons.local_hospital,
      'color': const Color(0xFFD32F2F),
      'description': 'Menu ini menyediakan informasi mengenai lokasi fasilitas kesehatan yang terdapat di wilayah DIY.',
      'action': (BuildContext context) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const HealthPage(),
          ),
        );
      },
    },
    {
      'name': 'Sirenap',
      'icon': Icons.medical_services,
      'color': const Color(0xFF26A69A),
      'description': 'Menu ini menyediakan informasi mengenai jumlah ketersediaan ruangan pada fasilitas kesehatan yang terdapat di wilayah DIY.',
      'action': (BuildContext context) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const SirenapPage(),
          ),
        );
      },
    },
    {
      'name': 'Satu Sehat',
      'icon': Icons.health_and_safety,
      'color': const Color(0xFF4CAF50),
      'description': 'Menyediakan layanan kesehatan terintegrasi, seperti pengingat jadwal minum obat, sertifikat imunisasi, dan resume rekam medis.',
      'action': (BuildContext context) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const SatuSehatPage(),
          ),
        );
      },
    },
  ];
}

 List<Map<String, dynamic>> _getEducationOptions() {
  return [
    {
      'name': 'Jogja Belajar',
      'icon': Icons.school,
      'color': const Color(0xFF1976D2),
      'description': 'Platform pembelajaran online untuk siswa dan guru di wilayah DIY.',
      'action': (BuildContext context) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const JogjaBelajarPage(),
          ),
        );
      },
    },
    {
      'name': 'Beasiswa DIY',
      'icon': Icons.account_balance,
      'color': const Color(0xFFFBC02D),
      'description': 'Informasi mengenai program beasiswa yang tersedia di wilayah DIY.',
      'action': (BuildContext context) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const BeasiswaDIYPage(),
          ),
        );
      },
    },
    {
      'name': 'Peta Sekolah',
      'icon': Icons.map,
      'color': const Color(0xFF388E3C),
      'description': 'Peta lokasi sekolah-sekolah di DIY untuk memudahkan akses pendidikan.',
      'action': (BuildContext context) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const PetaSekolahPage(),
          ),
        );
      },
    },
  ];
}

List<Map<String, dynamic>> _getGovernmentOptions() {
  return [
    {
      'name': 'Layanan Publik',
      'icon': Icons.account_balance_wallet,
      'color': const Color(0xFF0288D1),
      'description': 'Informasi mengenai layanan publik yang disediakan pemerintah DIY.',
      'action': (BuildContext context) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const LayananPublikPage(),
          ),
        );
      },
    },
    {
      'name': 'Keuangan Daerah',
      'icon': Icons.monetization_on,
      'color': const Color(0xFF388E3C),
      'description': 'Data dan laporan keuangan daerah untuk transparansi pemerintahan.',
      'action': (BuildContext context) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const KeuanganDaerahPage(),
          ),
        );
      },
    },
    {
      'name': 'Pemimpin Daerah',
      'icon': Icons.person,
      'color': const Color(0xFF7B1FA2),
      'description': 'Profil dan informasi mengenai pemimpin daerah di wilayah DIY.',
      'action': (BuildContext context) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const PemimpinDaerahPage(),
          ),
        );
      },
    },
  ];
}

List<Map<String, dynamic>> _getCitizenOptions() {
  return [
    {
      'name': 'Layanan Kependudukan',
      'icon': Icons.person_outline,
      'color': const Color(0xFFF57C00),
      'description': 'Layanan administrasi kependudukan seperti pembuatan KTP dan KK di DIY.',
      'action': (BuildContext context) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const LayananKependudukanPage(),
          ),
        );
      },
    },
    {
      'name': 'Pengaduan Masyarakat',
      'icon': Icons.report_problem,
      'color': const Color(0xFFD32F2F),
      'description': 'Layanan untuk menyampaikan pengaduan masyarakat kepada pemerintah DIY.',
      'action': (BuildContext context) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const PengaduanMasyarakatPage(),
          ),
        );
      },
    },
    {
      'name': 'Partisipasi Warga',
      'icon': Icons.group,
      'color': const Color(0xFF388E3C),
      'description': 'Platform untuk partisipasi warga dalam pembangunan wilayah DIY.',
      'action': (BuildContext context) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const PartisipasiWargaPage(),
          ),
        );
      },
    },
  ];
}

List<Map<String, dynamic>> _getExploreJogjaOptions() {
  return [
    {
      'name': 'Terdekat',
      'icon': Icons.location_on,
      'color': const Color(0xFFAB47BC),
      'description': '',
      'action': (BuildContext context) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const TerdekatPage(),
          ),
        );
      },
    },
    {
      'name': 'Wisata',
      'icon': Icons.park,
      'color': const Color(0xFF388E3C),
      'description': '',
      'action': (BuildContext context) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const WisataPage(),
          ),
        );
      },
    },
{
  'name': 'Kuliner',
  'icon': Icons.restaurant,
  'color': const Color(0xFFF57C00),
  'description': 'Temukan kuliner terbaik di Yogyakarta',
  'action': (BuildContext context) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: const KulinerPage(),
      ),
    );
  },
},
    {
      'name': 'Hotel',
      'icon': Icons.brush,
      'color': const Color.fromARGB(255, 188, 71, 143),
      'description': '',
      'action': (BuildContext context) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const HotelJogjaPage(),
          ),
        );
      },
    },
    {
      'name': 'Rumah Ibadah',
      'icon': Icons.home,
      'color': const Color.fromARGB(255, 159, 188, 71),
      'description': '',
      'action': (BuildContext context) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const RumahIbadahJogjaPage(),
          ),
        );
      },
    },
    {
      'name': 'Jogja Bisnis',
      'icon': Icons.business,
      'color': const Color.fromARGB(255, 71, 118, 188),
      'description': '',
      'action': (BuildContext context) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const JogjaBisnisPage(),
          ),
        );
      },
    },
    {
      'name': 'Lokasi SPBU',
      'icon': Icons.local_gas_station,
      'color': const Color.fromARGB(255, 188, 71, 71),
      'description': '',
      'action': (BuildContext context) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const LokasiSPBU(),
          ),
        );
      },
    },
    {
      'name': 'Lokasi ATM',
      'icon': Icons.atm,
      'color': const Color.fromARGB(255, 71, 77, 188),
      'description': '',
      'action': (BuildContext context) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const LokasiATM(),
          ),
        );
      },
    },
    {
      'name': 'Budaya',
      'icon': Icons.local_library,
      'color': const Color.fromARGB(255, 71, 188, 89),
      'description': 'Temukan kerajinan khas Jogja seperti batik dan perak.',
      'action': (BuildContext context) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const BudayaJogjaPage(),
          ),
        );
      },
    },
  ];
}

List<Map<String, dynamic>> _getOneDataOptions() {
  return [
    {
      'name': 'Statistik Daerah',
      'icon': Icons.bar_chart,
      'color': const Color(0xFF0288D1),
      'description': 'Akses data statistik daerah DIY seperti demografi dan ekonomi.',
      'action': (BuildContext context) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const StatistikDaerahPage(),
          ),
        );
      },
    },
    {
      'name': 'Data Terbuka',
      'icon': Icons.dataset,
      'color': const Color(0xFF388E3C),
      'description': 'Portal data terbuka untuk informasi publik di wilayah DIY.',
      'action': (BuildContext context) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const DataTerbukaPage(),
          ),
        );
      },
    },
    {
      'name': 'Visualisasi Data',
      'icon': Icons.pie_chart,
      'color': const Color(0xFFF57C00),
      'description': 'Lihat visualisasi data interaktif untuk analisis lebih mudah.',
      'action': (BuildContext context) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const VisualisasiDataPage(),
          ),
        );
      },
    },
  ];
}

void _showSocialMediaDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      final socialMediaOptions = _getSocialMediaOptions();
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Social Media",
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black54),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              SizedBox(
                height: 50.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: socialMediaOptions.length,
                  itemBuilder: (context, index) {
                    final option = socialMediaOptions[index];
                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.only(bottom: 2.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          Navigator.pop(context);
                          option['action'](context);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(4.w),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(3.w),
                                decoration: BoxDecoration(
                                  color: option['color'].withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: FaIcon(
                                  option['icon'],
                                  size: 8.w,
                                  color: option['color'],
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      option['name'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    Text(
                                      option['description'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 13.sp,
                                        color: Colors.black54,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _showHealthDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      final healthOptions = _getHealthOptions();
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kesehatan",
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black54),
                    onPressed: () => Navigator.pop(dialogContext),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              SizedBox(
                height: 50.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: healthOptions.length,
                  itemBuilder: (context, index) {
                    final option = healthOptions[index];
                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.only(bottom: 2.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          Navigator.pop(dialogContext);
                          option['action'](context);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(4.w),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(3.w),
                                decoration: BoxDecoration(
                                  color: option['color'].withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  option['icon'],
                                  size: 8.w,
                                  color: option['color'],
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      option['name'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    Text(
                                      option['description'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 13.sp,
                                        color: Colors.black54,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _showEducationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      final educationOptions = _getEducationOptions();
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pendidikan",
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black54),
                    onPressed: () => Navigator.pop(dialogContext),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              SizedBox(
                height: 50.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: educationOptions.length,
                  itemBuilder: (context, index) {
                    final option = educationOptions[index];
                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.only(bottom: 2.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          Navigator.pop(dialogContext);
                          option['action'](context);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(4.w),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(3.w),
                                decoration: BoxDecoration(
                                  color: option['color'].withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  option['icon'],
                                  size: 8.w,
                                  color: option['color'],
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      option['name'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    Text(
                                      option['description'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 13.sp,
                                        color: Colors.black54,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _showGovernmentDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      final governmentOptions = _getGovernmentOptions();
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Government",
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black54),
                    onPressed: () => Navigator.pop(dialogContext),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              SizedBox(
                height: 50.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: governmentOptions.length,
                  itemBuilder: (context, index) {
                    final option = governmentOptions[index];
                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.only(bottom: 2.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          Navigator.pop(dialogContext);
                          option['action'](context);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(4.w),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(3.w),
                                decoration: BoxDecoration(
                                  color: option['color'].withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  option['icon'],
                                  size: 8.w,
                                  color: option['color'],
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      option['name'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    Text(
                                      option['description'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 13.sp,
                                        color: Colors.black54,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _showCitizenDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      final citizenOptions = _getCitizenOptions();
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Warga",
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black54),
                    onPressed: () => Navigator.pop(dialogContext),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              SizedBox(
                height: 50.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: citizenOptions.length,
                  itemBuilder: (context, index) {
                    final option = citizenOptions[index];
                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.only(bottom: 2.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          Navigator.pop(dialogContext);
                          option['action'](context);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(4.w),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(3.w),
                                decoration: BoxDecoration(
                                  color: option['color'].withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  option['icon'],
                                  size: 8.w,
                                  color: option['color'],
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      option['name'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    Text(
                                      option['description'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 13.sp,
                                        color: Colors.black54,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _showExploreJogjaDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      final exploreOptions = _getExploreJogjaOptions();
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Jelajah Jogja",
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black54),
                    onPressed: () => Navigator.pop(dialogContext),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              SizedBox(
                height: 65.h,
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    crossAxisSpacing: 3.w,
                    mainAxisSpacing: 2.h,
                  ),
                  itemCount: exploreOptions.length,
                  itemBuilder: (context, index) {
                    final option = exploreOptions[index];
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          Navigator.pop(dialogContext);
                          option['action'](context);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(3.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(3.w),
                                decoration: BoxDecoration(
                                  color: option['color'].withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  option['icon'],
                                  size: 10.w,
                                  color: option['color'],
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                option['name'],
                                style: GoogleFonts.poppins(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _showOneDataDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      final oneDataOptions = _getOneDataOptions();
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "One Data",
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black54),
                    onPressed: () => Navigator.pop(dialogContext),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              SizedBox(
                height: 50.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: oneDataOptions.length,
                  itemBuilder: (context, index) {
                    final option = oneDataOptions[index];
                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.only(bottom: 2.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          Navigator.pop(dialogContext);
                          option['action'](context);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(4.w),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(3.w),
                                decoration: BoxDecoration(
                                  color: option['color'].withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  option['icon'],
                                  size: 8.w,
                                  color: option['color'],
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      option['name'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    Text(
                                      option['description'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 13.sp,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// Di dalam kelas IconListWidget

Widget _buildIconItem(BuildContext context, Map<String, dynamic> category, {bool isMoreItem = false}) {
  return Expanded(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      child: GestureDetector(
        onTap: () {
          // Kondisi untuk item utama (bukan dari "More Categories")
          if (!isMoreItem) {
            if (category['name'] == 'Sosial Media') {
              _showSocialMediaDialog(context);
            } else if (category['name'] == 'Kesehatan') {
              _showHealthDialog(context);
            } else if (category['name'] == 'Pendidikan') {
              _showEducationDialog(context);
            } else if (category['name'] == 'Pemerintahan') {
              _showGovernmentDialog(context);
            } else if (category['name'] == 'Kependudukan') {
              _showCitizenDialog(context);
            } else if (category['name'] == 'Jelajah Jogja') {
              _showExploreJogjaDialog(context);
            } else if (category['name'] == 'Satu Data') {
              _showOneDataDialog(context);
            } else if (category['name'] == 'Lainnya') {
              _showMoreCategoriesBottomSheet(context);
            } else {
              // Fallback untuk item utama lain jika ada
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: Placeholder(fallbackWidth: 200, fallbackHeight: 200, child: Center(child: Text("Halaman untuk ${category['name']}"))),
                ),
              );
            }
          } else { // Ini adalah item dari "More Categories" (isMoreItem == true)
            Navigator.pop(context); // Selalu tutup BottomSheet dulu

            Widget destinationPage;
            switch (category['name']) {
              case 'Jogja IY':
                destinationPage = const JogjaIYPage();
                break;
              case 'Jogja Layanan Publik':
                destinationPage = const LayananPublikPage();
                break;
              case 'Dokumen Publik': // BARU
                destinationPage = const dokumen_publik_page();
                break;
              case 'Pemimpin Daerah': // SUDAH ADA HALAMANNYA
                destinationPage = const PemimpinDaerahPage();
                break;
              case 'Keuangan Daerah': // SUDAH ADA HALAMANNYA
                destinationPage = const KeuanganDaerahPage();
                break;
              case 'JSP': // BARU
                destinationPage = const jsp_page();
                break;
              case 'IDMC': // BARU
                destinationPage = const idmc_page();
                break;
              case 'Sekolah': // SUDAH ADA HALAMANNYA (PetaSekolahPage)
                destinationPage = const PetaSekolahPage();
                break;
              default:
                destinationPage = Placeholder(fallbackWidth: 200, fallbackHeight: 200, child: Center(child: Text("Halaman untuk ${category['name']}")));
            }

            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: destinationPage,
              ),
            );
          }
        },
        child: AnimatedContainer( // ... sisa kode _buildIconItem ...
          duration: const Duration(milliseconds: 200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                elevation: 5,
                shape: const CircleBorder(),
                child: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: category['color'],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    category['icon'],
                    size: 8.w,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                category['name'],
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

  void _showMoreCategoriesBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        final moreCategories = _getMoreCategories();
        return Container(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10.w,
                height: 0.5.h,
                margin: EdgeInsets.only(bottom: 2.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Text(
                "More Categories",
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal.shade800,
                ),
              ),
              SizedBox(height: 2.h),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 3.w,
                  mainAxisSpacing: 3.h,
                  childAspectRatio: 0.75,
                ),
                itemCount: moreCategories.length,
                itemBuilder: (context, index) {
                  return _buildIconItem(context, moreCategories[index], isMoreItem: true);
                },
              ),
              SizedBox(height: 2.h),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = _getMainCategories();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: categories.take(4).map((category) => _buildIconItem(context, category)).toList(),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: categories.skip(4).take(4).map((category) => _buildIconItem(context, category)).toList(),
          ),
        ],
      ),
    );
  }
}

class EventDetailsPage extends StatelessWidget {
  final String title;
  final String image;
  final String date;
  final String time;
  final String location;
  final String speaker;
  final int daysLeft;

  const EventDetailsPage({
    super.key,
    required this.title,
    required this.image,
    required this.date,
    required this.time,
    required this.location,
    required this.speaker,
    required this.daysLeft,
  });

  Widget _buildEventInfo(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        children: [
          Icon(icon, size: 16.sp, color: const Color(0xFF03BE96)),
          SizedBox(width: 1.w),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(12.h),
      child: Container(
        padding: EdgeInsets.only(top: 5.h, left: 5.w, right: 5.w, bottom: 2.h),
        decoration: BoxDecoration(
          gradient: AppStyles.appBarGradient,
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Text(
                  "Event Details",
                  style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Share Coming Soon!',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                    backgroundColor: const Color(0xFF03BE96),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white.withOpacity(0.2),
                child: const Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'eventImage-$title',
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                child: Image.asset(
                  image,
                  width: double.infinity,
                  height: 30.h,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 50),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      gradient: AppStyles.primaryGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$daysLeft days left',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  _buildEventInfo(Icons.event, date),
                  _buildEventInfo(Icons.access_time, time),
                  _buildEventInfo(Icons.location_on, location),
                  _buildEventInfo(Icons.person, speaker),
                  SizedBox(height: 3.h),
                  Text(
                    "About Event",
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "Join us for an enriching cultural experience featuring traditional performances and insightful talks. This event celebrates the rich heritage of Yogyakarta, offering attendees a chance to immerse themselves in local arts and traditions.",
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Center(
                    child: Container(
                      width: 60.w,
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      decoration: BoxDecoration(
                        gradient: AppStyles.primaryGradient,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Registration Coming Soon!',
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                              backgroundColor: const Color(0xFF03BE96),
                            ),
                          );
                        },
                        child: Text(
                          "Register Now",
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class HealthPage extends StatefulWidget {
  const HealthPage({super.key});

  @override
  _HealthPageState createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  final List<Map<String, dynamic>> _healthFacilities = [
    {
      'name': 'Klinik Mitra Medika',
      'image': 'lib/icons/klinikmitramerdika.jpeg',
      'address': 'Jl. Gedong Kuning No. 40 Yogyakarta',
      'phone': '(0274) 450110',
      'distance': '500m',
      'rating': 4.7,
      'open': '08:00 - 21:00',
      'services': ['Umum', 'Gigi', 'KIA', 'Laboratorium'],
      'accessibility': true,
      'isFavorite': false,
    },
    {
      'name': 'RSUP Dr. Sardjito',
      'image': 'lib/icons/rsudsarjito.jpeg',
      'address': 'Jl. Kesehatan No. 1 Yogyakarta',
      'phone': '(0274) 587333',
      'distance': '2.5km',
      'rating': 4.8,
      'open': '24 Jam',
      'services': ['Spesialis', 'UGD', 'Rawat Inap'],
      'accessibility': true,
      'isFavorite': false,
    },
    {
      'name': 'Klinik Permata Sari',
      'image': 'lib/icons/klinikpermatasari.jpeg',
      'address': 'Jl. Jodipati No. 3B Mancasan Kidul',
      'phone': '(0274) 887623',
      'distance': '800m',
      'rating': 4.3,
      'open': '24 Jam',
      'services': ['UGD', 'Umum', 'Anak'],
      'accessibility': true,
      'isFavorite': false,
    },
  ];

  String _selectedFilter = 'Semua';
  final List<String> _filters = ['Semua', 'Terdekat', 'Buka Sekarang', 'Favorit'];
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Jogja Sehat",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFD32F2F),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
            colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 79, 5, 5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.map, color: Colors.white),
            onPressed: () {
              // Action for map view
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Cari fasilitas kesehatan...",
                  hintStyle: GoogleFonts.poppins(),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15, 
                    horizontal: 20,
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
          ),
          
          // Filter Chips
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(
                      _filters[index],
                      style: GoogleFonts.poppins(
                        color: _selectedFilter == _filters[index]
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                    selected: _selectedFilter == _filters[index],
                    selectedColor: const Color(0xFFD32F2F),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = _filters[index];
                      });
                    },
                  ),
                );
              },
            ),
          ),
          
          // Facilities List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _healthFacilities.length,
              itemBuilder: (context, index) {
                final facility = _healthFacilities[index];
                
                if (_searchController.text.isNotEmpty && 
                    !facility['name'].toLowerCase().contains(
                      _searchController.text.toLowerCase())) {
                  return const SizedBox();
                }
                
                return _buildFacilityCard(facility);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFacilityCard(Map<String, dynamic> facility) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          _showFacilityDetail(context, facility);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Facility Image
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.asset(
                      facility['image'],
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 150,
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.medical_services,
                          size: 50,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                  
                  // Distance Badge
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8, 
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 14,
                            color: Color(0xFFD32F2F),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            facility['distance'],
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Favorite Button
                  Positioned(
                    top: 10,
                    left: 10,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          facility['isFavorite'] = !facility['isFavorite'];
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Icon(
                          facility['isFavorite']
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: facility['isFavorite']
                              ? const Color(0xFFD32F2F)
                              : Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              // Facility Info
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          facility['name'],
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              facility['rating'].toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Address
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            facility['address'],
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Phone and Hours
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                facility['phone'],
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                facility['open'],
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Services Tags
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: facility['services']
                          .map<Widget>((service) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD32F2F)
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            service,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFFD32F2F),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFacilityDetail(BuildContext context, Map<String, dynamic> facility) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              // Draggable Handle
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 4),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Facility Image
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    child: Image.asset(
                      facility['image'],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 200,
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.medical_services,
                          size: 50,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                  
                  // Back Button
                  Positioned(
                    top: 16,
                    left: 16,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              // Facility Details
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and Rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            facility['name'],
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                facility['rating'].toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Location Section
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 20,
                            color: Color(0xFFD32F2F),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Lokasi",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  facility['address'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () {
                                    // Open maps
                                  },
                                  child: Text(
                                    "Lihat di Peta",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: const Color(0xFFD32F2F),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const Divider(height: 32),
                      
                      // Contact Section
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.phone,
                            size: 20,
                            color: Color(0xFFD32F2F),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Kontak",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  facility['phone'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () {
                                    // Make phone call
                                  },
                                  child: Text(
                                    "Hubungi Sekarang",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: const Color(0xFFD32F2F),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const Divider(height: 32),
                      
                      // Hours Section
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 20,
                            color: Color(0xFFD32F2F),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Jam Operasional",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  facility['open'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const Divider(height: 32),
                      
                      // Services Section
                      Text(
                        "Layanan yang Tersedia",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: facility['services']
                            .map<Widget>((service) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD32F2F)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              service,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: const Color(0xFFD32F2F),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFD32F2F),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              onPressed: () {
                                // Book appointment
                              },
                              child: Text(
                                "Buat Janji",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFFD32F2F)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.directions,
                                color: Color(0xFFD32F2F),
                              ),
                              onPressed: () {
                                // Open directions
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SirenapPage extends StatelessWidget {
  const SirenapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sirenap", style: GoogleFonts.poppins()),
        backgroundColor: const Color.fromARGB(255, 255, 50, 50),
      ),
      body: Center(
        child: Text(
          "Informasi Ketersediaan Ruangan",
          style: GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class SatuSehatPage extends StatelessWidget {
  const SatuSehatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Satu Sehat", style: GoogleFonts.poppins()),
        backgroundColor: const Color.fromARGB(255, 255, 50, 50),
      ),
      body: Center(
        child: Text(
          "Layanan Kesehatan Terintegrasi",
          style: GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class JogjaBelajarPage extends StatefulWidget {
  const JogjaBelajarPage({super.key});

  @override
  _JogjaBelajarPageState createState() => _JogjaBelajarPageState();
}

class _JogjaBelajarPageState extends State<JogjaBelajarPage> {
  final List<Map<String, dynamic>> _learningMaterials = [
    {
      'thumbnail': 'lib/icons/atmosferdanefekrumahkaca.jpeg',
      'title': 'Atmosfer dan Efek Rumah Kaca',
      'category': 'Sains',
      'author': 'Balai Tekkomdik',
      'duration': '15 min',
      'views': '1.2K',
      'date': DateTime(2025, 5, 15),
      'isBookmarked': false,
    },
    {
      'thumbnail': 'lib/icons/ajiningrogosonobusono.jpeg',
      'title': 'Ajining Raga Saka Busana',
      'category': 'Budaya Jawa',
      'author': 'Ngatifudin Firdaus',
      'duration': '22 min',
      'views': '856',
      'date': DateTime(2025, 6, 2),
      'isBookmarked': true,
    },
    {
      'thumbnail': 'lib/icons/aksarajowo.jpeg',
      'title': 'Aksara Jawa Dasar',
      'category': 'Bahasa',
      'author': 'Dinas Pendidikan DIY',
      'duration': '35 min',
      'views': '2.4K',
      'date': DateTime(2025, 4, 18),
      'isBookmarked': false,
    },
    {
      'thumbnail': 'lib/icons/matematikasd4.jpeg',
      'title': 'Matematika Dasar Kelas 4',
      'category': 'Matematika',
      'author': 'Guru Keliling',
      'duration': '18 min',
      'views': '1.8K',
      'date': DateTime(2025, 7, 5),
      'isBookmarked': false,
    },
  ];

  String _selectedCategory = 'Semua';
  final List<String> _categories = ['Semua', 'Sains', 'Budaya', 'Matematika', 'Bahasa'];
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Jogja Belajar",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 50, 50),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
            colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 79, 5, 5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Search action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Cari materi pembelajaran...",
                      hintStyle: GoogleFonts.poppins(),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, 
                        horizontal: 20,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(height: 12),
                // Category Chips
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(
                            _categories[index],
                            style: GoogleFonts.poppins(
                              color: _selectedCategory == _categories[index]
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                          ),
                          selected: _selectedCategory == _categories[index],
                          selectedColor: const Color.fromARGB(255, 225, 50, 50),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onSelected: (selected) {
                            setState(() {
                              _selectedCategory = _categories[index];
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Learning Materials List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _learningMaterials.length,
              itemBuilder: (context, index) {
                final material = _learningMaterials[index];
                final dateFormat = DateFormat('dd MMM yyyy');
                final formattedDate = dateFormat.format(material['date']);
                
                if (_searchController.text.isNotEmpty && 
                    !material['title'].toLowerCase().contains(
                      _searchController.text.toLowerCase())) {
                  return const SizedBox();
                }
                
                if (_selectedCategory != 'Semua' && 
                    material['category'] != _selectedCategory) {
                  return const SizedBox();
                }
                
                return _buildMaterialCard(material, formattedDate);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialCard(Map<String, dynamic> material, String formattedDate) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          _showMaterialDetail(context, material);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail Image
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.asset(
                      material['thumbnail'],
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 180,
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.play_circle_filled,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        material['duration'],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          material['isBookmarked'] = !material['isBookmarked'];
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Icon(
                          material['isBookmarked']
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: material['isBookmarked']
                              ? const Color(0xFF1976D2)
                              : Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              // Material Info
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Category
                    Text(
                      material['title'],
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    
                    // Category Tag
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1976D2).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        material['category'],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF1976D2),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // Meta Info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Oleh: ${material['author']}",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              "Diunggah: $formattedDate",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.remove_red_eye,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              material['views'],
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMaterialDetail(BuildContext context, Map<String, dynamic> material) {
    final dateFormat = DateFormat('EEEE, dd MMMM yyyy');
    final formattedDate = dateFormat.format(material['date']);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              // Draggable Handle
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 4),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Video Thumbnail
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    child: Image.asset(
                      material['thumbnail'],
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 220,
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(
                            Icons.play_circle_filled,
                            size: 60,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        material['duration'],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              // Material Details
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Bookmark
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              material['title'],
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              material['isBookmarked']
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: const Color(0xFF1976D2),
                            ),
                            onPressed: () {
                              setState(() {
                                material['isBookmarked'] = !material['isBookmarked'];
                              });
                            },
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Category and Views
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1976D2).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              material['category'],
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: const Color(0xFF1976D2),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Row(
                            children: [
                              const Icon(
                                Icons.remove_red_eye,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${material['views']}x ditonton",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      const Divider(height: 32),
                      
                      // Author and Upload Date
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 24,
                            backgroundColor: Color(0xFF1976D2),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pembuat Materi",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  material['author'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Diunggah: $formattedDate",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const Divider(height: 32),
                      
                      // Description
                      Text(
                        "Deskripsi Materi",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Materi pembelajaran ini membahas tentang ${material['title']} yang sangat bermanfaat untuk siswa di Yogyakarta. Konten disajikan secara interaktif dan mudah dipahami.",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1976D2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              onPressed: () {
                                // Play video
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Putar Materi",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF1976D2)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.download,
                                color: Color(0xFF1976D2),
                              ),
                              onPressed: () {
                                // Download material
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BeasiswaDIYPage extends StatelessWidget {
  const BeasiswaDIYPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Beasiswa DIY", style: GoogleFonts.poppins()),
        backgroundColor: const Color.fromARGB(255, 255, 50, 50),
      ),
      body: Center(
        child: Text(
          "Informasi Beasiswa Daerah DIY",
          style: GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}


class PetaSekolahPage extends StatefulWidget {
  const PetaSekolahPage({super.key});

  @override
  _PetaSekolahPageState createState() => _PetaSekolahPageState();
}

class _PetaSekolahPageState extends State<PetaSekolahPage> {
  final List<Map<String, dynamic>> _schools = [
    {
      'name': 'SD Negeri 1 Yogyakarta',
      'image': 'lib/icons/sdnegri1yk.jpeg',
      'address': 'Jl. P. Mangkubumi No.1, Yogyakarta',
      'phone': '(0274) 512345',
      'type': 'SD',
      'distance': '1.2 km',
      'rating': 4.5,
      'facilities': ['Perpustakaan', 'Lapangan Olahraga', 'Lab Komputer'],
      'isFavorite': false,
    },
    {
      'name': 'SMP Negeri 2 Yogyakarta',
      'image': 'lib/icons/smp2yk.jpeg',
      'address': 'Jl. Cik Di Tiro No.1, Yogyakarta',
      'phone': '(0274) 512346',
      'type': 'SMP',
      'distance': '2.3 km',
      'rating': 4.7,
      'facilities': ['Lab IPA', 'Aula', 'Ruang Multimedia'],
      'isFavorite': true,
    },
    {
      'name': 'SMA Negeri 3 Yogyakarta',
      'image': 'lib/icons/sma3yk.jpeg',
      'address': 'Jl. Yos Sudarso No.7, Yogyakarta',
      'phone': '(0274) 512347',
      'type': 'SMA',
      'distance': '3.1 km',
      'rating': 4.8,
      'facilities': ['Lab Bahasa', 'Studio Musik', 'Kolam Renang'],
      'isFavorite': false,
    },
  ];

  String _selectedFilter = 'Semua';
  final List<String> _filters = ['Semua', 'SD', 'SMP', 'SMA'];
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Peta Sekolah",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 50, 50),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 79, 5, 5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.map_outlined, color: Colors.white),
            onPressed: () {
              _showMapView(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Cari sekolah...",
                      hintStyle: GoogleFonts.poppins(),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, 
                        horizontal: 20,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(height: 12),
                // Filter Chips
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _filters.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(
                            _filters[index],
                            style: GoogleFonts.poppins(
                              color: _selectedFilter == _filters[index]
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                          ),
                          selected: _selectedFilter == _filters[index],
                          selectedColor: const Color.fromARGB(255, 255, 50, 50),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onSelected: (selected) {
                            setState(() {
                              _selectedFilter = _filters[index];
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Schools List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _schools.length,
              itemBuilder: (context, index) {
                final school = _schools[index];
                
                if (_searchController.text.isNotEmpty && 
                    !school['name'].toLowerCase().contains(
                      _searchController.text.toLowerCase())) {
                  return const SizedBox();
                }
                
                if (_selectedFilter != 'Semua' && 
                    school['type'] != _selectedFilter) {
                  return const SizedBox();
                }
                
                return _buildSchoolCard(school);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSchoolCard(Map<String, dynamic> school) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          _showSchoolDetail(context, school);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // School Image
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.asset(
                      school['image'],
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 180,
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.school,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  // School Type Badge
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getSchoolTypeColor(school['type']),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        school['type'],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  // Favorite Button
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          school['isFavorite'] = !school['isFavorite'];
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Icon(
                          school['isFavorite']
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: school['isFavorite']
                              ? Colors.red
                              : Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  // Distance Badge
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 14,
                            color: Color(0xFF388E3C),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            school['distance'],
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              
              // School Info
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          school['name'],
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              school['rating'].toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    // Address
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            school['address'],
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    // Phone
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          school['phone'],
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    // Facilities Tags
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: school['facilities']
                          .map<Widget>((facility) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF388E3C).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            facility,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF388E3C),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getSchoolTypeColor(String type) {
    switch (type) {
      case 'SD':
        return Colors.orange;
      case 'SMP':
        return Colors.blue;
      case 'SMA':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  void _showSchoolDetail(BuildContext context, Map<String, dynamic> school) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              // Draggable Handle
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 4),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // School Image
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    child: Image.asset(
                      school['image'],
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 220,
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.school,
                          size: 60,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  // Back Button
                  Positioned(
                    top: 16,
                    left: 16,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  // School Type Badge
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _getSchoolTypeColor(school['type']),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        school['type'],
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              // School Details
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and Rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              school['name'],
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              school['isFavorite']
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                school['isFavorite'] = !school['isFavorite'];
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 20,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            school['rating'].toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      
                      const Divider(height: 24),
                      
                      // Location Section
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 20,
                            color: Color(0xFF388E3C),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Alamat Sekolah",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  school['address'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () {
                                    // Open maps
                                  },
                                  child: Text(
                                    "Lihat di Peta",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: const Color(0xFF388E3C),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const Divider(height: 24),
                      
                      // Contact Section
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.phone,
                            size: 20,
                            color: Color(0xFF388E3C),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Kontak Sekolah",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  school['phone'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () {
                                    // Make phone call
                                  },
                                  child: Text(
                                    "Hubungi Sekolah",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: const Color(0xFF388E3C),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const Divider(height: 24),
                      
                      // Facilities Section
                      Text(
                        "Fasilitas Sekolah",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: school['facilities']
                            .map<Widget>((facility) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF388E3C).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              facility,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: const Color(0xFF388E3C),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 255, 50, 13),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              onPressed: () {
                                // Open school website
                              },
                              child: Text(
                                "Kunjungi Website",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF388E3C)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.directions,
                                color: Color(0xFF388E3C),
                              ),
                              onPressed: () {
                                // Open directions
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showMapView(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Peta Sekolah",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.map,
                    size: 60,
                    color: Color(0xFF388E3C),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Fitur peta akan segera hadir",
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Tutup",
                style: GoogleFonts.poppins(
                  color: const Color(0xFF388E3C),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class LayananPublikPage extends StatefulWidget {
  const LayananPublikPage({super.key});

  @override
  _LayananPublikPageState createState() => _LayananPublikPageState();
}

class _LayananPublikPageState extends State<LayananPublikPage> {
  final List<Map<String, dynamic>> _publicServices = [
    {
      'name': 'Dinas Kependudukan dan Pencatatan Sipil',
      'image': 'lib/icons/disdukcapil.jpeg',
      'address': 'Jl. Kenari No. 14 Yogyakarta',
      'phone': '(0274) 512345',
      'hours': 'Senin-Jumat 08:00-15:00',
      'services': ['KTP', 'KK', 'Akte Kelahiran'],
      'isFavorite': false,
      'queue': 12,
      'waitTime': '30 menit',
    },
    {
      'name': 'Dinas Perizinan dan Investasi',
      'image': 'lib/icons/dpmppt.jpeg',
      'address': 'Jl. Cik Di Tiro No. 3 Yogyakarta',
      'phone': '(0274) 512346',
      'hours': 'Senin-Jumat 08:00-14:00',
      'services': ['Izin Usaha', 'Izin Bangunan', 'HO'],
      'isFavorite': true,
      'queue': 8,
      'waitTime': '20 menit',
    },
    {
      'name': 'Dinas Kesehatan',
      'image': 'lib/icons/dinaskesehatan.jpeg',
      'address': 'Jl. Gondosuli No. 6 Yogyakarta',
      'phone': '(0274) 512347',
      'hours': 'Setiap Hari 24 Jam',
      'services': ['BPJS', 'Vaksinasi', 'Kesehatan Masyarakat'],
      'isFavorite': false,
      'queue': 5,
      'waitTime': '15 menit',
    },
  ];

  String _selectedCategory = 'Semua';
  final List<String> _categories = ['Semua', 'Kependudukan', 'Perizinan', 'Kesehatan'];
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Layanan Publik",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF0288D1),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 255, 50, 50), Color.fromARGB(255, 79, 5, 5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
            onPressed: () {
              _showQRScanner(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Cari layanan publik...",
                      hintStyle: GoogleFonts.poppins(),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, 
                        horizontal: 20,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(height: 12),
                // Category Chips
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(
                            _categories[index],
                            style: GoogleFonts.poppins(
                              color: _selectedCategory == _categories[index]
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                          ),
                          selected: _selectedCategory == _categories[index],
                          selectedColor: const Color.fromARGB(255, 209, 2, 2),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onSelected: (selected) {
                            setState(() {
                              _selectedCategory = _categories[index];
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Services List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _publicServices.length,
              itemBuilder: (context, index) {
                final service = _publicServices[index];
                
                if (_searchController.text.isNotEmpty && 
                    !service['name'].toLowerCase().contains(
                      _searchController.text.toLowerCase())) {
                  return const SizedBox();
                }
                
                if (_selectedCategory != 'Semua' && 
                    !service['services'].any((s) => s.toLowerCase().contains(
                      _selectedCategory.toLowerCase()))) {
                  return const SizedBox();
                }
                
                return _buildServiceCard(service);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          _showServiceDetail(context, service);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service Image and Queue Info
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.asset(
                      service['image'],
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 150,
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.apartment,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  // Queue Status
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getQueueColor(service['queue']),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.people,
                            size: 14,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${service['queue']} antrian (${service['waitTime']})",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Favorite Button
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          service['isFavorite'] = !service['isFavorite'];
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Icon(
                          service['isFavorite']
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: service['isFavorite']
                              ? Colors.red
                              : Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              // Service Info
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      service['name'],
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Address
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            service['address'],
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    // Hours
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          service['hours'],
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    // Services Tags
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: service['services']
                          .map<Widget>((item) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0288D1).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            item,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF0288D1),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getQueueColor(int queue) {
    if (queue > 15) return Colors.red;
    if (queue > 8) return Colors.orange;
    return Colors.green;
  }

  void _showServiceDetail(BuildContext context, Map<String, dynamic> service) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              // Draggable Handle
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 4),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Service Image
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    child: Image.asset(
                      service['image'],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 200,
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.apartment,
                          size: 60,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  // Back Button
                  Positioned(
                    top: 16,
                    left: 16,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  // Queue Status
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _getQueueColor(service['queue']),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.people,
                            size: 16,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${service['queue']} antrian • ${service['waitTime']}",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              
              // Service Details
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and Favorite
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              service['name'],
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              service['isFavorite']
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                service['isFavorite'] = !service['isFavorite'];
                              });
                            },
                          ),
                        ],
                      ),
                      
                      const Divider(height: 24),
                      
                      // Location Section
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 20,
                            color: Color(0xFF0288D1),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Lokasi Layanan",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  service['address'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () {
                                    // Open maps
                                  },
                                  child: Text(
                                    "Lihat di Peta",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: const Color(0xFF0288D1),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const Divider(height: 24),
                      
                      // Hours and Contact
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      size: 20,
                                      color: Color(0xFF0288D1),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      "Jam Layanan",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.only(left: 32),
                                  child: Text(
                                    service['hours'],
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      size: 20,
                                      color: Color(0xFF0288D1),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      "Kontak",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.only(left: 32),
                                  child: Text(
                                    service['phone'],
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const Divider(height: 24),
                      
                      // Services Section
                      Text(
                        "Jenis Layanan",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: service['services']
                            .map<Widget>((item) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0288D1).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              item,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: const Color(0xFF0288D1),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0288D1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              onPressed: () {
                                // Take queue number
                              },
                              child: Text(
                                "Ambil Nomor Antrian",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF0288D1)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.qr_code,
                                color: Color(0xFF0288D1),
                              ),
                              onPressed: () {
                                _showQRScanner(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showQRScanner(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Scan QR Code",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF0288D1),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.qr_code_scanner,
                    size: 100,
                    color: Color(0xFF0288D1),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Arahkan kamera ke QR Code untuk mengambil nomor antrian",
                  style: GoogleFonts.poppins(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Tutup",
                style: GoogleFonts.poppins(
                  color: const Color(0xFF0288D1),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class KeuanganDaerahPage extends StatefulWidget {
  const KeuanganDaerahPage({super.key});

  @override
  _KeuanganDaerahPageState createState() => _KeuanganDaerahPageState();
}

class _KeuanganDaerahPageState extends State<KeuanganDaerahPage> {
  final List<Map<String, dynamic>> _documents = [
    {
      'name': 'Perda APBD Tahun 2025',
      'date': DateTime(2025, 1, 7),
      'category': 'APBD',
      'size': '2.4 MB',
      'icon': Icons.description,
      'color': Colors.blue,
      'downloads': 1245,
      'isBookmarked': false,
    },
    {
      'name': 'Penjabaran APBD Tahun 2025',
      'date': DateTime(2025, 1, 7),
      'category': 'APBD',
      'size': '3.1 MB',
      'icon': Icons.assignment,
      'color': Colors.green,
      'downloads': 987,
      'isBookmarked': true,
    },
    {
      'name': 'Laporan Realisasi Anggaran 2024',
      'date': DateTime(2025, 1, 1),
      'category': 'Laporan',
      'size': '5.2 MB',
      'icon': Icons.bar_chart,
      'color': Colors.orange,
      'downloads': 2156,
      'isBookmarked': false,
    },
    {
      'name': 'Laporan Realisasi Anggaran PPD 2024',
      'date': DateTime(2025, 1, 1),
      'category': 'Laporan',
      'size': '4.7 MB',
      'icon': Icons.pie_chart,
      'color': Colors.purple,
      'downloads': 876,
      'isBookmarked': false,
    },
    {
      'name': 'Realisasi Anggaran per SKPD 2024',
      'date': DateTime(2025, 1, 1),
      'category': 'Laporan',
      'size': '6.8 MB',
      'icon': Icons.table_chart,
      'color': Colors.teal,
      'downloads': 1532,
      'isBookmarked': false,
    },
    {
      'name': 'Ringkasan Rancangan APBD 2025',
      'date': DateTime(2024, 12, 2),
      'category': 'APBD',
      'size': '1.9 MB',
      'icon': Icons.summarize,
      'color': Colors.red,
      'downloads': 2043,
      'isBookmarked': true,
    },
    {
      'name': 'Perubahan APBD Tahun 2024',
      'date': DateTime(2024, 10, 9),
      'category': 'APBD',
      'size': '2.7 MB',
      'icon': Icons.edit_document,
      'color': Colors.indigo,
      'downloads': 765,
      'isBookmarked': false,
    },
    {
      'name': 'Penjabaran Perubahan APBD 2024',
      'date': DateTime(2024, 10, 9),
      'category': 'APBD',
      'size': '3.5 MB',
      'icon': Icons.note_alt,
      'color': Colors.deepOrange,
      'downloads': 654,
      'isBookmarked': false,
    },
  ];

  String _selectedFilter = 'Semua';
  final List<String> _filters = ['Semua', 'APBD', 'Laporan', 'Peraturan'];
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Informasi Keuangan Daerah",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF388E3C),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 79, 5, 5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              _showSearchDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header with Summary Cards
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color.fromARGB(255, 142, 56, 56), Color.fromARGB(255, 0, 9, 0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSummaryCard(
                      title: "APBD 2025",
                      value: "Rp 12,45 T",
                      icon: Icons.account_balance_wallet,
                      color: Colors.white,
                    ),
                    _buildSummaryCard(
                      title: "Realisasi 2024",
                      value: "78.3%",
                      icon: Icons.trending_up,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSummaryCard(
                      title: "Belanja Daerah",
                      value: "Rp 9,87 T",
                      icon: Icons.payments,
                      color: Colors.white,
                    ),
                    _buildSummaryCard(
                      title: "PAD",
                      value: "Rp 2,58 T",
                      icon: Icons.attach_money,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Filter and Search Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Cari dokumen keuangan...",
                      hintStyle: GoogleFonts.poppins(),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, 
                        horizontal: 20,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(height: 12),
                // Filter Chips
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _filters.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(
                            _filters[index],
                            style: GoogleFonts.poppins(
                              color: _selectedFilter == _filters[index]
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                          ),
                          selected: _selectedFilter == _filters[index],
                          selectedColor: const Color.fromARGB(255, 142, 56, 56),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onSelected: (selected) {
                            setState(() {
                              _selectedFilter = _filters[index];
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Documents List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _documents.length,
              itemBuilder: (context, index) {
                final doc = _documents[index];
                final dateFormat = DateFormat('dd MMM yyyy');
                final formattedDate = dateFormat.format(doc['date']);
                
                if (_searchController.text.isNotEmpty && 
                    !doc['name'].toLowerCase().contains(
                      _searchController.text.toLowerCase())) {
                  return const SizedBox();
                }
                
                if (_selectedFilter != 'Semua' && 
                    doc['category'] != _selectedFilter) {
                  return const SizedBox();
                }
                
                return _buildDocumentCard(doc, formattedDate);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentCard(Map<String, dynamic> doc, String formattedDate) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          _showDocumentDetail(context, doc);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Document Icon
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: doc['color'].withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    doc['icon'],
                    size: 24,
                    color: doc['color'],
                  ),
                ),
                const SizedBox(width: 16),
                
                // Document Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doc['name'],
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      
                      // Meta Info
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF388E3C).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              doc['category'],
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFF388E3C),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            formattedDate,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      
                      // Downloads and Size
                      Row(
                        children: [
                          const Icon(
                            Icons.download,
                            size: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${doc['downloads']}x",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Icon(
                            Icons.insert_drive_file,
                            size: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            doc['size'],
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Bookmark Button
                IconButton(
                  icon: Icon(
                    doc['isBookmarked'] ? Icons.bookmark : Icons.bookmark_border,
                    color: doc['isBookmarked'] ? const Color(0xFF388E3C) : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      doc['isBookmarked'] = !doc['isBookmarked'];
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDocumentDetail(BuildContext context, Map<String, dynamic> doc) {
    final dateFormat = DateFormat('EEEE, dd MMMM yyyy');
    final formattedDate = dateFormat.format(doc['date']);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              // Draggable Handle
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 4),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Document Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: doc['color'].withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        doc['icon'],
                        size: 32,
                        color: doc['color'],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doc['name'],
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            doc['category'],
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        doc['isBookmarked'] ? Icons.bookmark : Icons.bookmark_border,
                        color: const Color(0xFF388E3C),
                      ),
                      onPressed: () {
                        setState(() {
                          doc['isBookmarked'] = !doc['isBookmarked'];
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              
              // Document Details
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Meta Info
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tanggal Publikasi",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  formattedDate,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Ukuran File",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  doc['size'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 32),
                      
                      // Downloads
                      Row(
                        children: [
                          const Icon(
                            Icons.download,
                            size: 20,
                            color: Color.fromARGB(255, 142, 56, 56),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "${doc['downloads']} unduhan",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 32),
                      
                      // Description
                      Text(
                        "Deskripsi Dokumen",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Dokumen ini berisi informasi resmi mengenai ${doc['category']} Daerah Istimewa Yogyakarta. "
                        "Berisi data dan laporan yang telah diverifikasi oleh tim keuangan daerah.",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 142, 56, 56),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              onPressed: () {
                                _downloadDocument(doc['name']);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.download,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Unduh Dokumen",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 142, 56, 56)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.share,
                                color: Color(0xFF388E3C),
                              ),
                              onPressed: () {
                                _shareDocument(doc['name']);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _downloadDocument(String docName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Mengunduh $docName...',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF388E3C),
      ),
    );
  }

  void _shareDocument(String docName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Berbagi $docName...',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF388E3C),
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            "Cari Dokumen Keuangan",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Masukkan kata kunci...",
                  hintStyle: GoogleFonts.poppins(),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filters.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(
                          _filters[index],
                          style: GoogleFonts.poppins(
                            color: _selectedFilter == _filters[index]
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                        selected: _selectedFilter == _filters[index],
                        selectedColor: const Color(0xFF388E3C),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onSelected: (selected) {
                          setState(() {
                            _selectedFilter = _filters[index];
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Tutup",
                style: GoogleFonts.poppins(
                  color: const Color(0xFF388E3C),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class PemimpinDaerahPage extends StatelessWidget {
  const PemimpinDaerahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Pemimpin Daerah", style: GoogleFonts.poppins()),
          backgroundColor: const Color.fromARGB(255, 225, 50, 50),
          bottom: TabBar(
            labelStyle: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: const [
              Tab(text: "Gubernur"),
              Tab(text: "Wakil Gubernur"),
              Tab(text: "Sekda"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab Gubernur
            SingleChildScrollView(
              padding: EdgeInsets.all(5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profil Gubernur DIY",
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Card(
                    elevation: 3,
                    margin: EdgeInsets.only(bottom: 2.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'lib/icons/gubernurdiy.jpeg',
                              width: double.infinity,
                              height: 30.h,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 50),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "A. Data Pribadi",
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            "Nama Lengkap: BRM. Herjuno Darpito / KGPH. Mangkubumi",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Jumeneng Dalem: Sri Sultan Hamengku Buwono X",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Gelar: Ngarsa Dalem Sampeyan Dalem Hingkang Sinuhun Kanjeng Sultan Hamengku Buwono, Senapati Hing Ngalaga Ngabdurrahman Sayidin Panat Agama Kalifatullah Hingkang Jumeneng Kaping Sedoso",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Jabatan: Gubernur Daerah Istimewa Yogyakarta",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Alamat Tempat Tinggal: Kraton Yogyakarta",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Jenis Kelamin: Laki-laki",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Status Perkawinan: Kawin",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Agama: Islam",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "B. Data Pendidikan",
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            "SD: SD Keputran I, Yogyakarta (1959 - 1960)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "SLTP: SLTP Negeri 3, Yogyakarta (1962 - 1963)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "SLTA: SLTA Negeri 6, Yogyakarta (1965 - 1966)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "S1: UGM, Fak. Hukum, Jur. Ketatanegaraan (1982)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "C. Pengalaman Jabatan",
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            "Gubernur Kepala Daerah Tk. I Daerah Istimewa Yogyakarta (1998 - 2003)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Gubernur Propinsi Daerah Istimewa Yogyakarta (2003 - 2008)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Gubernur Propinsi Daerah Istimewa Yogyakarta (2008 - 2012)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Gubernur Daerah Istimewa Yogyakarta (2012 - 2017)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Gubernur Daerah Istimewa Yogyakarta (2017 - 2022)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "D. Pengalaman Organisasi",
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            "Ketua Golkar Propinsi DIY (1977 - 1998)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Ketua Kadinda Propinsi DIY (1983 - Sekarang)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Ketua KONI Propinsi DIY (1990 - 1998)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "E. Penghargaan",
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            "Grand Cross (1996, Austria)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Orde Van Oranje Nassau (1996, Belanda)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "The Order of Rising Sun, Gold and Silver Star (2022, Jepang)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Tab Wakil Gubernur
            SingleChildScrollView(
              padding: EdgeInsets.all(5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profil Wakil Gubernur DIY",
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Card(
                    elevation: 3,
                    margin: EdgeInsets.only(bottom: 2.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'lib/icons/wakilgubernur.jpeg',
                              width: double.infinity,
                              height: 30.h,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 50),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "A. Data Pribadi",
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            "Nama Lahir: Raden Mas Wijoseno Hario Bimo",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Nama Lengkap: Kanjeng Gusti Pangeran Adipati Aryo (KGPAA) Paku Alam X",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Gelar: Kanjeng Bendara Pangeran Haryo Prabu Suryodilogo atau KBPH Prabu Suryodilogo",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Jabatan: Wakil Gubernur Daerah Istimewa Yogyakarta",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Alamat Tempat Tinggal: Harjowinatan PA 2B Purwokinanti Pakualaman Yogyakarta",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Jenis Kelamin: Laki-laki",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Status Perkawinan: Kawin",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Agama: Islam",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "B. Riwayat Pendidikan",
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            "SD: Blok B II Pagi Jakarta (1975)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "SMP: SMP XI Jakarta (1979)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "SMA: SMA N 1 Yogyakarta (1982)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "S-1: UPN Veteran Yogyakarta Jurusan Manajemen (1989)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "C. Pengalaman Jabatan",
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            "Kepala Seksi Sarana Buruh dan Pekerja, Dinas Tenaga Kerja Propinsi DIY (1995)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Kepala Seksi Pemberian Kerja, Dinas Tenaga Kerja Propinsi DIY (1999)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Kepala Seksi Purna Kerja dan Sektor Informal, Dinas Tenaga Kerja Propinsi DIY (2002)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Kepala Seksi Pelatihan dan Produktifitas Tenaga Kerja, Dinas Tenaga Kerja Propinsi DIY (2003)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Kepala Seksi Pelatihan, Standarisasi dan Sertifikasi, Dinas Tenaga Kerja Propinsi DIY (2003)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Pj. Kepala Bidang Pendayagunaan Tenaga Kerja, Dinas Tenaga Kerja Propinsi DIY (2006)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Kepala Bidang Investasi dan Pemasaran Potensi Wilayah, Badan Perencanaan Daerah Provinsi DIY (2008)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Kepala Bidang Pemerintahan, Badan Perencanaan Pembangunan Daerah Provinsi DIY (2009)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Kepala Biro Administrasi Kesejahteraan Rakyat dan Kemasyarakatan, Sekretariat Daerah DIY (2011)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Wakil Gubernur, Daerah Istimewa Yogyakarta (2017)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Tab Sekda
            SingleChildScrollView(
              padding: EdgeInsets.all(5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profil Sekda DIY",
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Card(
                    elevation: 3,
                    margin: EdgeInsets.only(bottom: 2.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'lib/icons/sekda.jpeg',
                              width: double.infinity,
                              height: 30.h,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 50),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "A. Data Pribadi",
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            "Nama Lengkap: Drs. Beny Suharsono, M. Si.",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "NIP: 19650512 198602 1 002",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Pangkat/Gol. Ruang: IVc / Pembina Utama Muda",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Jabatan: Sekretaris Daerah Daerah Istimewa Yogyakarta",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Alamat Tempat Tinggal: Tamanmartani, Kalasan, Sleman",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "NIK: -",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Usia: 58 Tahun",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Jenis Kelamin: Laki-laki",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Status Perkawinan: Kawin",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "Agama: Islam",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "NPWP: -",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "B. Riwayat Pendidikan",
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            "SLTA: SMA Negeri Bumiayu (1984)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "S1: Institut Ilmu Pemerintahan Departemen Dalam Negeri (1994)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "S2: Sekolah Tinggi Pembangunan Masyarakat Desa “APMD” Yogyakarta (2011)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "C. Pengalaman Jabatan",
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            "1. Staf, Biro Kepegawaian Setwilda DIY (1986)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "2. Staf, Subbag Pengembangan Pegawai Setwilda DIY (1988)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "3. Staf, Sekretariat Kotamadya Daerah Tk II Yogyakarta (1990)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "4. Sekretaris, Kelurahan Giwangan, Kec. Umbul Harjo, Kodya Dati II Yogyakarta (1990)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "5. Sekretaris, Kelurahan Tahunan, Kec. Umbul Harjo Yogyakarta (1995)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "6. Kasubbag TU, Biro Kepegawaian Setwilda Prop. DIY (1997)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "7. Kasubbag Mutasi Jabatan, Biro Kepegawaian Setwilda Prop. DIY (1998)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "8. Kepala Subbag Sistem dan Prosedur, Biro Organisasi Setda DIY (2005)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "9. Kepala Subbag TU, Biro Umum Setda DIY (2007)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "10. Kepala Subbag TU Pimpinan, Biro Umum Humas dan Protokol Setda DIY (2009)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "11. Kepala Bagian Otonomi, Biro Tapem Sekretariat Daerah DIY (2010)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "12. Kepala Bidang Pemerintahan, BAPPEDA DIY (2011)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "13. Kepala Bidang Perencanaan dan Statistik, BAPPEDA DIY (2013)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "14. Kepala, Biro Tata Pemerintahan Sekretariat Daerah DIY (2015)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "15. Plt. Sekretaris, Sekretariat Dewan Perwakilan Rakyat Daerah DIY (2016)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "16. Sekretaris, Sekretariat Dewan Perwakilan Rakyat Daerah DIY (2018)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "17. Paniradyo Pati, Paniradyo Kaistimewan (2019)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "18. Plt. Kepala, BKD DIY (2020)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "19. Kepala, BAPPEDA DIY (2020)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "20. Plt. Kepala, BPKA DIY (2020)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "21. Plh. Asisten Setda DIY, Asisten Setda DIY Bidang Pemerintahan dan Administrasi Umum (2022)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                          Text(
                            "22. Sekretaris Daerah DIY, Pemda DIY (2023)",
                            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman Warga
class LayananKependudukanPage extends StatelessWidget {
  const LayananKependudukanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Layanan Kependudukan", style: GoogleFonts.poppins()),
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
      ),
      body: Center(
        child: Text(
          "Layanan Administrasi Kependudukan DIY",
          style: GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class PengaduanMasyarakatPage extends StatelessWidget {
  const PengaduanMasyarakatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengaduan Masyarakat", style: GoogleFonts.poppins()),
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
      ),
      body: Center(
        child: Text(
          "Layanan Pengaduan Masyarakat DIY",
          style: GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class PartisipasiWargaPage extends StatelessWidget {
  const PartisipasiWargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Partisipasi Warga", style: GoogleFonts.poppins()),
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
      ),
      body: Center(
        child: Text(
          "Platform Partisipasi Warga DIY",
          style: GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}



class TerdekatPage extends StatelessWidget {
  const TerdekatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Di sekitar anda",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFFF0000),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 79, 5, 5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded, color: Colors.white),
            onPressed: () => _showFilterOptions(context),
            tooltip: 'Filter Options',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.sp),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Cari tempat wisata, kuliner...",
                  hintStyle: GoogleFonts.poppins(
                    color: Colors.grey[500],
                    fontSize: 14.sp,
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.red[600], size: 20.sp),
                  suffixIcon: Icon(Icons.mic, color: Colors.red[600], size: 20.sp),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.sp),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 14.sp,
                    horizontal: 16.sp,
                  ),
                ),
                style: GoogleFonts.poppins(fontSize: 14.sp),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_pin, size: 18.sp, color: const Color(0xFF6A1B9A)),
                      SizedBox(width: 8.sp),
                      Text(
                        "Lokasi Anda: Yogyakarta",
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.sp),
                  Text(
                    "Kategori Populer",
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 12.sp),
                  SizedBox(
                    height: 44.sp,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _buildCategoryChip("Wisata", Icons.landscape),
                        SizedBox(width: 8.sp),
                        _buildCategoryChip("Kuliner", Icons.restaurant),
                        SizedBox(width: 8.sp),
                        _buildCategoryChip("Belanja", Icons.shopping_bag),
                        SizedBox(width: 8.sp),
                        _buildCategoryChip("Sejarah", Icons.history),
                        SizedBox(width: 8.sp),
                        _buildCategoryChip("Alam", Icons.nature),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.sp),
                  _buildSectionHeader("PENDIDIKAN"),
                  SizedBox(height: 12.sp),
                  _buildLocationCard(
                    image: "lib/icons/terdekat1.jpeg",
                    name: "SMP Muhammadiyah 1 Yogyakarta",
                    address: "Jl. Purwodiningratan NG 1/902B, Ngampilan",
                    category: "Sekolah",
                    rating: 4.5,
                    distance: "0.5 Km",
                    onTap: () => _launchURL("http://smpmuh1-yog.sch.id"),
                  ),
                  SizedBox(height: 16.sp),
                  _buildLocationCard(
                    image: "lib/icons/terdekat2.jpeg",
                    name: "SD Muhammadiyah Purwodiningratan 2",
                    address: "Jl. Kir. Ahmad Dahlan Purwodiningratan NG 1 / 902",
                    category: "Sekolah",
                    rating: 4.2,
                    distance: "0.7 Km",
                    onTap: () => _launchURL("http://sdmupurwodiningratan.sch.id"),
                  ),
                  SizedBox(height: 24.sp),
                  _buildSectionHeader("FASILITAS UMUM"),
                  SizedBox(height: 12.sp),
                  _buildLocationCard(
                    image: "lib/icons/terdekat3.jpeg",
                    name: "Polresta Yogyakarta",
                    address: "Jalan Reksobayan No.1, Gondomanan",
                    category: "Kantor Polisi",
                    rating: 4.0,
                    distance: "1.2 Km",
                    onTap: () => _launchURL("http://polresjogja.com/"),
                  ),
                  SizedBox(height: 24.sp),
                  _buildSectionHeader("WISATA TERDEKAT"),
                  SizedBox(height: 12.sp),
                  _buildLocationCard(
                    image: "lib/icons/terdekat5.jpeg",
                    name: "Malioboro",
                    address: "Jl. Malioboro, Gondomanan",
                    category: "Wisata Kota",
                    rating: 4.7,
                    distance: "1.5 Km",
                    onTap: () => _launchURL("https://visitingjogja.jogjaprov.go.id"),
                  ),
                  SizedBox(height: 16.sp),
                  _buildLocationCard(
                    image: "lib/icons/terdekat1.jpeg",
                    name: "Keraton Yogyakarta",
                    address: "Jl. Rotowijayan Blok No. 1",
                    category: "Wisata Sejarah",
                    rating: 4.8,
                    distance: "1.8 Km",
                    onTap: () => _launchURL("https://kratonjogja.id"),
                  ),
                  SizedBox(height: 30.sp),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFFF0000),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.sp)),
        child: const Icon(Icons.my_location, color: Colors.white, size: 24),
      ),
    );
  }

  Widget _buildCategoryChip(String label, IconData icon) {
    return GestureDetector(
      onTap: () {},
      child: Chip(
        avatar: Icon(icon, size: 18.sp, color: const Color(0xFF6A1B9A)),
        label: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF6A1B9A),
          ),
        ),
        backgroundColor: Colors.white,
        side: const BorderSide(color: Color(0xFFE0E0E0)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.sp),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF6A1B9A),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {},
          child: Text(
            "Lihat Semua",
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              color: const Color(0xFF6A1B9A),
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationCard({
    required String image,
    required String name,
    required String address,
    required String category,
    required double rating,
    required String distance,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.sp),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.sp)),
              child: Image.asset(
                image,
                height: 80.sp,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 80.sp,
                  color: Colors.grey[200],
                  child: Icon(Icons.image, size: 50.sp, color: Colors.grey[400]),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8.sp),
                      Row(
                        children: [
                          Icon(Icons.star, size: 16.sp, color: Colors.amber),
                          SizedBox(width: 4.sp),
                          Text(
                            rating.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.sp),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on, size: 14.sp, color: Colors.grey[600]),
                      SizedBox(width: 4.sp),
                      Expanded(
                        child: Text(
                          address,
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.sp),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3E5F5),
                          borderRadius: BorderRadius.circular(6.sp),
                        ),
                        child: Text(
                          category,
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF6A1B9A),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(6.sp),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.directions_walk, size: 14.sp, color: const Color(0xFF2E7D32)),
                            SizedBox(width: 4.sp),
                            Text(
                              distance,
                              style: GoogleFonts.poppins(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF2E7D32),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.sp)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.sp,
                height: 4.sp,
                decoration: BoxDecoration(
                  color: Colors.red[300],
                  borderRadius: BorderRadius.circular(2.sp),
                ),
              ),
              SizedBox(height: 16.sp),
              Text(
                "Filter Lokasi",
                style: GoogleFonts.poppins(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 24.sp),
              _buildFilterSection(
                title: "Kategori",
                options: const ["Wisata", "Kuliner", "Belanja", "Pendidikan", "Fasilitas Umum"],
              ),
              SizedBox(height: 20.sp),
              _buildFilterSection(
                title: "Jarak Maksimal",
                options: const ["1 Km", "3 Km", "5 Km", "10 Km", "Semua"],
              ),
              SizedBox(height: 20.sp),
              _buildFilterSection(
                title: "Rating Minimal",
                options: const ["3.0+", "4.0+", "4.5+"],
                isRating: true,
              ),
              SizedBox(height: 24.sp),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.sp),
                        side: const BorderSide(color: Color(0xFF6A1B9A)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.sp),
                        ),
                      ),
                      child: Text(
                        "Reset",
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF6A1B9A),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.sp),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6A1B9A),
                        padding: EdgeInsets.symmetric(vertical: 14.sp),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.sp),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        "Terapkan",
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.sp),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterSection({
    required String title,
    required List<String> options,
    bool isRating = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12.sp),
        Wrap(
          spacing: 8.sp,
          runSpacing: 8.sp,
          children: options.map((option) {
            return FilterChip(
              label: isRating
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, size: 16.sp, color: Colors.amber),
                        SizedBox(width: 4.sp),
                        Text(
                          option,
                          style: GoogleFonts.poppins(fontSize: 13.sp),
                        ),
                      ],
                    )
                  : Text(
                      option,
                      style: GoogleFonts.poppins(fontSize: 13.sp),
                    ),
              selected: false,
              onSelected: (bool selected) {},
              backgroundColor: Colors.white,
              selectedColor: const Color(0xFFE1BEE7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.sp),
                side: BorderSide(color: Colors.grey[300]!),
              ),
              labelStyle: GoogleFonts.poppins(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
              elevation: 1,
            );
          }).toList(),
        ),
      ],
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}



class WisataPage extends StatefulWidget {
  const WisataPage({super.key});

  @override
  State<WisataPage> createState() => _WisataPageState();
}

class _WisataPageState extends State<WisataPage> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  bool _showSearchClear = false;
  final bool _isLoading = false;
  List<String> _searchSuggestions = [];
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  void _onSearchChanged() {
    setState(() {
      _showSearchClear = _searchController.text.isNotEmpty;
      _updateSearchSuggestions(_searchController.text);
    });
  }

  void _updateSearchSuggestions(String query) {
    if (query.isEmpty) {
      _searchSuggestions = [];
      return;
    }
    _searchSuggestions = [
      'Desa Pentingsari',
      'Desa Wisata Kinalrejo',
      'Candi Borobudur',
      'Pantai Parangtritis',
    ].where((suggestion) => suggestion.toLowerCase().contains(query.toLowerCase())).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: const Color(0xFFF57C00)))
          : FadeTransition(
              opacity: _fadeAnimation,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchBar(),
                    SizedBox(height: 24.sp),
                    _buildCategoriesSection(),
                    SizedBox(height: 24.sp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Popular Destinations",
                          style: GoogleFonts.poppins(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "See All",
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: const Color(0xFFF57C00),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.sp),
                    _buildDestinationCard(
                      context,
                      title: "Desa Pentingsari",
                      description: "Experience local traditions with integrated attractions and accommodations.",
                      rating: 4.8,
                      distance: 12.5,
                      imagePath: "assets/images/desa_pentingsari.jpg",
                    ),
                    SizedBox(height: 16.sp),
                    _buildDestinationCard(
                      context,
                      title: "Desa Wisata Kinalrejo",
                      description: "Home of the late Mbah Mariqian, guardian of Mount Merapi.",
                      rating: 4.5,
                      distance: 18.2,
                      imagePath: "assets/images/kinalrejo.jpg",
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Search destinations or activities...",
          hintStyle: GoogleFonts.poppins(
            color: Colors.grey[500],
            fontSize: 14.sp,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Colors.grey[600],
            size: 20.sp,
          ),
          suffixIcon: _showSearchClear
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    size: 20.sp,
                    color: Colors.grey[600],
                  ),
                  onPressed: () {
                    _searchController.clear();
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.sp),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 14.sp,
            horizontal: 16.sp,
          ),
        ),
        style: GoogleFonts.poppins(fontSize: 14.sp),
        onSubmitted: (value) {
          // Implement search functionality
        },
      ),
    );
  }

  Widget _buildCategoriesSection() {
    final categories = [
      {'icon': Icons.landscape, 'label': 'Nature', 'color': Colors.green[700]},
      {'icon': Icons.history, 'label': 'History', 'color': Colors.orange[700]},
      {'icon': Icons.food_bank, 'label': 'Culinary', 'color': Colors.red[700]},
      {'icon': Icons.beach_access, 'label': 'Beach', 'color': Colors.blue[700]},
      {'icon': Icons.temple_buddhist, 'label': 'Culture', 'color': Colors.purple[700]},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Travel Categories",
          style: GoogleFonts.poppins(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12.sp),
        SizedBox(
          height: 90.sp,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return OpenContainer(
                transitionType: ContainerTransitionType.fade,
                transitionDuration: const Duration(milliseconds: 500),
                openBuilder: (context, _) => CategoryDetailPage(category: categories[index]['label'] as String),
                closedBuilder: (context, openContainer) {
                  return GestureDetector(
                    onTap: openContainer,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 80.sp,
                        margin: EdgeInsets.only(right: 12.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.sp),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 50.sp,
                              height: 50.sp,
                              decoration: BoxDecoration(
                                color: categories[index]['color'] as Color,
                                borderRadius: BorderRadius.circular(12.sp),
                              ),
                              child: Center(
                                child: Icon(
                                  categories[index]['icon'] as IconData,
                                  color: Colors.white,
                                  size: 24.sp,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.sp),
                            Text(
                              categories[index]['label'] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDestinationCard(
    BuildContext context, {
    required String title,
    required String description,
    required double rating,
    required double distance,
    required String imagePath,
  }) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: const Duration(milliseconds: 500),
      openBuilder: (context, _) => DestinationDetailPage(
        title: title,
        description: description,
        rating: rating,
        imagePath: imagePath,
      ),
      closedBuilder: (context, openContainer) {
        return GestureDetector(
          onTap: openContainer,
          child: Hero(
            tag: title,
            child: Container(
              margin: EdgeInsets.only(bottom: 12.sp),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.sp),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16.sp)),
                    child: Stack(
                      children: [
                        Image.asset(
                          imagePath,
                          height: 140.sp,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 140.sp,
                            color: Colors.grey[300],
                            child: Icon(Icons.broken_image, size: 40.sp, color: Colors.grey[600]),
                          ),
                        ),
                        Positioned(
                          top: 8.sp,
                          right: 8.sp,
                          child: GestureDetector(
                            onTap: () {
                              // Handle favorite
                            },
                            child: Container(
                              padding: EdgeInsets.all(6.sp),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.red[400],
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8.sp),
                        Text(
                          description,
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 12.sp),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
                              decoration: BoxDecoration(
                                color: Colors.amber.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(6.sp),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber, size: 16.sp),
                                  SizedBox(width: 4.sp),
                                  Text(
                                    rating.toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12.sp),
                            Icon(Icons.location_on, color: Colors.grey[600], size: 16.sp),
                            SizedBox(width: 4.sp),
                            Text(
                              "${distance.toStringAsFixed(1)} km from city center",
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: WisataSearchDelegate(),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.sp)),
        title: Text(
          "Filter Destinations",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
            color: Colors.black87,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Sort By",
                labelStyle: GoogleFonts.poppins(fontSize: 14.sp),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.sp),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
              ),
              items: ["Rating", "Distance: Near to Far", "Distance: Far to Near"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e, style: GoogleFonts.poppins(fontSize: 14.sp))))
                  .toList(),
              onChanged: (value) {},
            ),
            SizedBox(height: 16.sp),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Distance Range (km)",
                labelStyle: GoogleFonts.poppins(fontSize: 14.sp),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.sp),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
              ),
              keyboardType: TextInputType.number,
              style: GoogleFonts.poppins(fontSize: 14.sp),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: const Color(0xFFF57C00),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF57C00),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.sp),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
            ),
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Apply",
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WisataSearchDelegate extends SearchDelegate {
  final List<String> suggestions = [
    'Desa Pentingsari',
    'Desa Wisata Kinalrejo',
    'Candi Borobudur',
    'Pantai Parangtritis',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, size: 24.sp, color: Colors.grey[600]),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, size: 24.sp, color: Colors.grey[600]),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.sp),
      children: [
        Text(
          "Search results for: $query",
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16.sp),
        _buildSearchResultCard(context, "Desa Pentingsari"),
        _buildSearchResultCard(context, "Desa Wisata Kinalrejo"),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredSuggestions = suggestions
        .where((suggestion) => suggestion.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      padding: EdgeInsets.all(16.sp),
      itemCount: filteredSuggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
          leading: Icon(Icons.search, color: Colors.grey[600], size: 20.sp),
          title: Text(
            filteredSuggestions[index],
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          onTap: () {
            query = filteredSuggestions[index];
            showResults(context);
          },
        );
      },
    );
  }

  Widget _buildSearchResultCard(BuildContext context, String title) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.sp),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp)),
      elevation: 2,
      child: ListTile(
        contentPadding: EdgeInsets.all(12.sp),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.sp),
          child: Image.asset(
            "assets/images/wisata_banner.jpg",
            width: 50.sp,
            height: 50.sp,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[300],
              child: Icon(Icons.broken_image, size: 24.sp, color: Colors.grey[600]),
            ),
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          "Popular destination in Yogyakarta",
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
        onTap: () {},
      ),
    );
  }
}

class DestinationDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final double rating;
  final String imagePath;

  const DestinationDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.rating,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260.sp,
            pinned: true,
            backgroundColor: const Color(0xFFF57C00),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: title,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: Icon(Icons.broken_image, size: 40.sp, color: Colors.grey[600]),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.share, size: 24.sp, color: Colors.white),
                onPressed: () {
                  // Implement share functionality
                },
              ),
              IconButton(
                icon: Icon(Icons.favorite_border, size: 24.sp, color: Colors.white),
                onPressed: () {
                  // Implement favorite functionality
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 12.sp),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.sp,
                          vertical: 4.sp,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16.sp),
                            SizedBox(width: 4.sp),
                            Text(
                              rating.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.sp),
                      Icon(Icons.location_on, color: Colors.grey[600], size: 16.sp),
                      SizedBox(width: 4.sp),
                      Text(
                        "Yogyakarta, Indonesia",
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.sp),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 24.sp),
                  Text(
                    "Gallery",
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 12.sp),
                  SizedBox(
                    height: 80.sp,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 80.sp,
                          margin: EdgeInsets.only(right: 8.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.sp),
                            image: DecorationImage(
                              image: AssetImage(imagePath),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF57C00),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.sp),
            ),
            padding: EdgeInsets.symmetric(vertical: 16.sp),
            elevation: 0,
          ),
          onPressed: () {
            // Implement booking functionality
          },
          child: Text(
            "Book Now",
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryDetailPage extends StatelessWidget {
  final String category;

  const CategoryDetailPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category,
          style: GoogleFonts.poppins(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFF57C00),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 79, 5, 5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Explore $category Destinations",
              style: GoogleFonts.poppins(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16.sp),
            Text(
              "Discover the best $category experiences in Yogyakarta.",
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}






class KulinerPage extends StatelessWidget {
  const KulinerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Kuliner Jogja Terbaik",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFF57C00),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 79, 5, 5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Cari kuliner...",
                  hintStyle: GoogleFonts.poppins(),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Categories
            Text(
              "Kategori Kuliner",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryCard("Masakan Barat", Icons.emoji_food_beverage),
                  _buildCategoryCard("Khas Nusantara", Icons.restaurant),
                  _buildCategoryCard("Jajanan", Icons.local_cafe),
                  _buildCategoryCard("Minuman", Icons.local_bar),
                  _buildCategoryCard("Korea", Icons.ramen_dining),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Popular Restaurants
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rekomendasi Kuliner",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Lihat Semua",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFF57C00),
                    ),
                  ),
                ),
              ],
            ),
            
            // Restaurant Cards
            _buildRestaurantCard(
              context,
              "Dae Jang Geum",
              "Korean Restaurant",
              "4.8",
              "Jl. Affandi No.12, Sleman",
              "lib/icons/kuliner1.jpeg", // Replace with actual image
              "Dae Jang Geum menawarkan menu masakan Korea seperti olahan mie, ayam, daging sapi, sup seafood, Kimbab dan Tteokpoki. Menu spesial: Ayam Cemani, Gurami Terbang dan Angelo ne Tause.",
            ),
            
            _buildRestaurantCard(
              context,
              "Nanamia Pizzeria",
              "Italian Restaurant",
              "4.7",
              "Jl. Kaliurang Km.5, Sleman",
              "lib/icons/kuliner2.jpeg", // Replace with actual image
              "Nanamia Pizzeria menawarkan pizza autentik Italia dengan tekstur sempurna dan topping lezat. Tempat yang sempurna untuk pecinta makanan Italia di Jogja.",
            ),
            
            _buildRestaurantCard(
              context,
              "Mr. Shake Tea",
              "Bubble Tea",
              "4.5",
              "Jl. Gejayan No.15, Sleman",
              "lib/icons/kuliner3.jpeg", // Replace with actual image
              "Mr Shake Tea menyajikan bubble tea asli dari Taiwan dengan berbagai varian rasa. Minuman kekinian yang menjadi favorit anak muda Jogja.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String name, IconData icon) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: const Color(0xFFF57C00)),
          const SizedBox(height: 5),
          Text(
            name,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantCard(
    BuildContext context,
    String name,
    String type,
    String rating,
    String location,
    String imagePath,
    String description,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: RestaurantDetailPage(
              name: name,
              type: type,
              rating: rating,
              location: location,
              imagePath: imagePath,
              description: description,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Stack(
                children: [
                  Image.asset(
                    imagePath,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 150,
                      color: Colors.grey[200],
                      child: const Icon(Icons.restaurant, size: 50, color: Colors.grey),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            rating,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Restaurant Info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    type,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantDetailPage extends StatelessWidget {
  final String name;
  final String type;
  final String rating;
  final String location;
  final String imagePath;
  final String description;

  const RestaurantDetailPage({
    super.key,
    required this.name,
    required this.type,
    required this.rating,
    required this.location,
    required this.imagePath,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.restaurant, size: 50, color: Colors.grey),
                ),
              ),
            ),
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF57C00).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, size: 16, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              rating,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    type,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Location
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Color(0xFFF57C00)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          location,
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Open Hours
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Color(0xFFF57C00)),
                      const SizedBox(width: 8),
                      Text(
                        "10:00 - 22:00",
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Description
                  Text(
                    "Deskripsi",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  
                  // Popular Menu
                  Text(
                    "Menu Populer",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildMenuItem("Kimbab", "Rp 35.000"),
                        _buildMenuItem("Tteokbokki", "Rp 45.000"),
                        _buildMenuItem("Bibimbap", "Rp 55.000"),
                        _buildMenuItem("Bubble Tea", "Rp 25.000"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: const BorderSide(color: Color(0xFFF57C00)),
                          ),
                          onPressed: () {
                            // Open maps
                          },
                          child: Text(
                            "Lihat Lokasi",
                            style: GoogleFonts.poppins(
                              color: const Color(0xFFF57C00),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF57C00),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () {
                            // Call restaurant
                          },
                          child: Text(
                            "Hubungi",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String name, String price) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.fastfood, size: 40, color: Color(0xFFF57C00)),
          const SizedBox(height: 8),
          Text(
            name,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            price,
            style: GoogleFonts.poppins(
              color: const Color(0xFFF57C00),
            ),
          ),
        ],
      ),
    );
  }
}




class HotelJogjaPage extends StatelessWidget {
  const HotelJogjaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Luxury Hotels in Jogja",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFF57C00),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 79, 5, 5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.sp),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                readOnly: true, // Make it tap-to-search
                onTap: () => showSearch(
                  context: context,
                  delegate: HotelSearchDelegate(),
                ),
                decoration: InputDecoration(
                  hintText: "Cari hotel...",
                  hintStyle: GoogleFonts.poppins(fontSize: 12.sp),
                  prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20.sp),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 10.sp),
                ),
              ),
            ),
            SizedBox(height: 12.sp),
            // Hotel Cards
            _buildHotelCard(
              context,
              name: "Melia Purosani Hotel Yogyakarta",
              address: "JL Suryotomo no 31, Yogyakarta 55122",
              phone: "+0274-59892",
              email: "i.melia.purosani@melia.com",
              website: "https://www.melia.com",
              image: "lib/icons/hotel2.jpeg",
              rating: 4.8,
              price: "Rp 1.200.000",
              amenities: ["Free WiFi", "Spa", "Pool", "Gym"],
            ),
            SizedBox(height: 10.sp),
            _buildHotelCard(
              context,
              name: "Royal Ambarrukmo Yogyakarta Hotel",
              address: "JL Laksda Adisucipto No.81 Yogyakarta",
              phone: "+62-274 488 488",
              email: "info@royalambarrukmo.com",
              website: "http://www.royalambarrukmo.com",
              image: "lib/icons/hotel3.jpeg",
              rating: 4.9,
              price: "Rp 1.500.000",
              amenities: ["Free WiFi", "Restaurant", "Pool", "Bar"],
            ),
            SizedBox(height: 10.sp),
            _buildHotelCard(
              context,
              name: "Hyatt Regency Yogyakarta Hotel",
              address: "Jl. Palagan Tentara Pelajar, Yogyakarta",
              phone: "+62-274 869123",
              email: "yogyakarta.regency@hyatt.com",
              website: "https://www.hyatt.com",
              image: "lib/icons/hotel4.jpeg",
              rating: 4.7,
              price: "Rp 1.350.000",
              description:
                  "Nestled in the cultural heart of Java, Hyatt Regency Yogyakarta offers luxurious accommodations surrounded by 22 hectares of beautifully landscaped gardens.",
              amenities: ["Free WiFi", "Golf Course", "Spa", "Pool"],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHotelCard(
    BuildContext context, {
    required String name,
    required String address,
    required String phone,
    required String email,
    required String website,
    required String image,
    required double rating,
    required String price,
    String? description,
    List<String>? amenities,
  }) {
    return Card(
      elevation: 6,
      shadowColor: Colors.grey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.sp),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: BorderRadius.circular(14.sp),
        onTap: () => _showHotelDetail(context, name, description ?? address, amenities),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 100.sp,
                  width: double.infinity,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[200],
                      child: Icon(Icons.error, size: 20.sp, color: Colors.grey),
                    ),
                  ),
                ),
                Positioned(
                  top: 5.sp,
                  left: 5.sp,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.sp, vertical: 2.sp),
                    decoration: BoxDecoration(
                      color: Colors.amber[700],
                      borderRadius: BorderRadius.circular(6.sp),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star, size: 10.sp, color: Colors.white),
                        SizedBox(width: 2.sp),
                        Text(
                          rating.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5.sp,
                  right: 5.sp,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6D2077), Color(0xFFAB47BC)],
                      ),
                      borderRadius: BorderRadius.circular(6.sp),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Text(
                      "From $price",
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 5.sp),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on, size: 12.sp, color: const Color(0xFF6D2077)),
                      SizedBox(width: 5.sp),
                      Expanded(
                        child: Text(
                          address,
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.sp),
                  if (amenities != null)
                    Wrap(
                      spacing: 5.sp,
                      runSpacing: 5.sp,
                      children: amenities
                          .map(
                            (amenity) => Container(
                              padding: EdgeInsets.symmetric(horizontal: 6.sp, vertical: 3.sp),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3E5F5),
                                borderRadius: BorderRadius.circular(8.sp),
                              ),
                              child: Text(
                                amenity,
                                style: GoogleFonts.poppins(
                                  fontSize: 9.sp,
                                  color: const Color(0xFF6D2077),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  SizedBox(height: 8.sp),
                  Wrap(
                    spacing: 5.sp,
                    runSpacing: 5.sp,
                    children: [
                      _buildContactChip(
                        icon: Icons.phone,
                        label: phone,
                        onTap: () => _launchURL("tel:$phone"),
                      ),
                      _buildContactChip(
                        icon: Icons.email,
                        label: "Email",
                        onTap: () => _launchURL("mailto:$email"),
                      ),
                      _buildContactChip(
                        icon: Icons.language,
                        label: "Website",
                        onTap: () => _launchURL(website),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.sp),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 8.sp),
                            side: const BorderSide(color: Color(0xFF6D2077)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                          ),
                          icon: Icon(Icons.map, size: 12.sp, color: const Color(0xFF6D2077)),
                          label: Text(
                            "Location",
                            style: GoogleFonts.poppins(
                              fontSize: 11.sp,
                              color: const Color(0xFF6D2077),
                            ),
                          ),
                          onPressed: () => _openMaps(address),
                        ),
                      ),
                      SizedBox(width: 5.sp),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6D2077),
                            padding: EdgeInsets.symmetric(vertical: 8.sp),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                            elevation: 2,
                          ),
                          icon: Icon(Icons.hotel, size: 12.sp, color: Colors.white),
                          label: Text(
                            "Book Now",
                            style: GoogleFonts.poppins(
                              fontSize: 11.sp,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () => _openBooking(website),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactChip({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.sp),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 5.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.sp),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12.sp, color: const Color(0xFF6D2077)),
            SizedBox(width: 3.sp),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 9.sp,
                color: Colors.grey[800],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showHotelDetail(
      BuildContext context, String title, String description, List<String>? amenities) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(18.sp)),
          ),
          padding: EdgeInsets.all(10.sp),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 30.sp,
                    height: 3.sp,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2.sp),
                    ),
                  ),
                ),
                SizedBox(height: 10.sp),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.sp),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 12.sp),
                if (amenities != null) ...[
                  Text(
                    "Amenities",
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5.sp),
                  Wrap(
                    spacing: 5.sp,
                    runSpacing: 5.sp,
                    children: amenities
                        .map(
                          (amenity) => Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 5.sp),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3E5F5),
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                            child: Text(
                              amenity,
                              style: GoogleFonts.poppins(
                                fontSize: 9.sp,
                                color: const Color(0xFF6D2077),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
                SizedBox(height: 18.sp),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6D2077),
                    minimumSize: Size(double.infinity, 40.sp),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Book Now",
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  void _openMaps(String address) async {
    final encodedAddress = Uri.encodeComponent(address);
    final url = 'https://www.google.com/maps/search/?api=1&query=$encodedAddress';
    await _launchURL(url);
  }

  void _openBooking(String url) {
    _launchURL(url);
  }
}

class HotelSearchDelegate extends SearchDelegate {
  final List<String> suggestions = [
    "Melia Purosani",
    "Royal Ambarrukmo",
    "Hyatt Regency",
    "Luxury Hotels",
    "5-Star Hotels",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, size: 20.sp),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, size: 20.sp),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10.sp),
      children: [
        Text(
          "Search results for: $query",
          style: GoogleFonts.poppins(fontSize: 13.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10.sp),
        _buildSearchResultCard(context, "Melia Purosani Hotel Yogyakarta"),
        _buildSearchResultCard(context, "Royal Ambarrukmo Yogyakarta Hotel"),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredSuggestions = suggestions
        .where((suggestion) => suggestion.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      padding: EdgeInsets.all(10.sp),
      itemCount: filteredSuggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            filteredSuggestions[index],
            style: GoogleFonts.poppins(fontSize: 12.sp),
          ),
          onTap: () {
            query = filteredSuggestions[index];
            showResults(context);
          },
        );
      },
    );
  }

  Widget _buildSearchResultCard(BuildContext context, String title) {
    return Card(
      margin: EdgeInsets.only(bottom: 8.sp),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.sp)),
      child: ListTile(
        contentPadding: EdgeInsets.all(8.sp),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(6.sp),
          child: Image.asset(
            "assets/images/hotel_banner.jpg",
            width: 40.sp,
            height: 40.sp,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[200],
              child: Icon(Icons.error, size: 20.sp, color: Colors.grey),
            ),
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          "Luxury 5-star hotel",
          style: GoogleFonts.poppins(fontSize: 10.sp, color: Colors.grey[600]),
        ),
        onTap: () {},
      ),
    );
  }
}





class RumahIbadahJogjaPage extends StatelessWidget {
  const RumahIbadahJogjaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Rumah Ibadah di Jogja",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 79, 5, 5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.sp),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                readOnly: true,
                onTap: () => showSearch(
                  context: context,
                  delegate: PlaceOfWorshipSearchDelegate(),
                ),
                decoration: InputDecoration(
                  hintText: "Cari rumah ibadah...",
                  hintStyle: GoogleFonts.poppins(fontSize: 12.sp),
                  prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20.sp),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 10.sp),
                ),
              ),
            ),
            SizedBox(height: 16.sp),
            // Header
            Text(
              "Fasilitas Rumah Ibadah di Jogja",
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16.sp),
            // Pura Section
            _buildReligionSection(
              title: "Pura",
              subtitle: "Yogyakarta Istimewa",
              items: [
                _buildPlaceOfWorship(
                  context,
                  name: "Pura Catur Binuvono Sakti",
                  address: "JL Mawar No.2, Baciro, Condokusuman, Kota Yogyakarta, Daerah Istimewa Yogyakarta 55225",
                  image: "lib/icons/ibadah1.jpeg",
                ),
                _buildPlaceOfWorship(
                  context,
                  name: "Pura Jagatnata",
                  address: "JL Pura, Banguntapan, Bantul, Daerah Istimewa Yogyakarta 55198",
                  image: "lib/icons/ibadah2.jpeg",
                ),
                _buildPlaceOfWorship(
                  context,
                  name: "Pura Vaikuntha Vyomantara",
                  address: "Banguntapan, Bantul, Daerah Istimewa Yogyakarta 55198",
                  image: "lib/icons/ibadah3.jpeg",
                ),
              ],
            ),
            SizedBox(height: 20.sp),
            // Masjid Section
            _buildReligionSection(
              title: "Masjid",
              subtitle: "Keindahan Spiritual",
              items: [
                _buildPlaceOfWorship(
                  context,
                  name: "Masjid Gedhe Kauman",
                  address: "Jl. Kauman, Ngupasan, Gondomanan, Kota Yogyakarta, Daerah Istimewa Yogyakarta 55132",
                  image: "lib/icons/ibadah5.jpeg",
                ),
                _buildPlaceOfWorship(
                  context,
                  name: "Masjid Jogokariyan",
                  address: "Jl. Jogokaryan No.36, Mantrijeron, Kota Yogyakarta, Daerah Istimewa Yogyakarta 55143",
                  image: "lib/icons/ibadah6.jpeg",
                ),
              ],
            ),
            SizedBox(height: 20.sp),
            // Gereja Section
            _buildReligionSection(
              title: "Gereja",
              subtitle: "Warisan Bersejarah",
              items: [
                _buildPlaceOfWorship(
                  context,
                  name: "Gereja Santo Fransiskus Xaverius",
                  address: "Jl. K.H. Ahmad Dahlan No.22, Yogyakarta, Daerah Istimewa Yogyakarta 55122",
                  image: "lib/icons/ibadah7.jpeg",
                ),
                _buildPlaceOfWorship(
                  context,
                  name: "Gereja Ganjuran",
                  address: "Ganjuran, Bambanglipuro, Bantul, Daerah Istimewa Yogyakarta 55764",
                  image: "lib/icons/ibadah8.jpeg",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReligionSection({
    required String title,
    String? subtitle,
    required List<Widget> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF5C6BC0),
              ),
            ),
            if (subtitle != null) ...[
              SizedBox(width: 8.sp),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
            const Spacer(),
            Icon(Icons.arrow_drop_down, color: const Color(0xFF5C6BC0), size: 20.sp),
          ],
        ),
        SizedBox(height: 12.sp),
        Column(
          children: [
            for (var item in items) ...[
              item,
              SizedBox(height: 16.sp),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildPlaceOfWorship(
    BuildContext context, {
    required String name,
    required String address,
    required String image,
  }) {
    return Card(
      elevation: 6,
      shadowColor: Colors.grey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.sp),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: BorderRadius.circular(14.sp),
        onTap: () => _showDetail(context, name, address),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 80.sp, // Reduced from 120.sp
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) => const AssetImage("assets/placeholder.jpg"),
                    ),
                  ),
                ),
                Container(
                  height: 80.sp,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 6.sp,
                  left: 10.sp,
                  child: Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp, // Reduced from 14.sp
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  top: 6.sp,
                  right: 6.sp,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.sp, vertical: 2.sp),
                    decoration: BoxDecoration(
                      color: Colors.amber[700],
                      borderRadius: BorderRadius.circular(5.sp),
                    ),
                    child: Text(
                      "Populer",
                      style: GoogleFonts.poppins(
                        fontSize: 9.sp, // Reduced from 10.sp
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on, size: 14.sp, color: const Color(0xFF5C6BC0)),
                      SizedBox(width: 6.sp),
                      Expanded(
                        child: Text(
                          address,
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.sp),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 10.sp),
                            side: const BorderSide(color: Color(0xFF5C6BC0)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                          ),
                          icon: Icon(Icons.directions, size: 14.sp, color: const Color(0xFF5C6BC0)),
                          label: Text(
                            "Petunjuk Arah",
                            style: GoogleFonts.poppins(
                              fontSize: 11.sp,
                              color: const Color(0xFF5C6BC0),
                            ),
                          ),
                          onPressed: () => _openMaps(address),
                        ),
                      ),
                      SizedBox(width: 8.sp),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5C6BC0),
                            padding: EdgeInsets.symmetric(vertical: 10.sp),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                            elevation: 2,
                          ),
                          icon: Icon(Icons.info, size: 14.sp, color: Colors.white),
                          label: Text(
                            "Detail",
                            style: GoogleFonts.poppins(
                              fontSize: 11.sp,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () => _showDetail(context, name, address),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDetail(BuildContext context, String name, String address) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(18.sp)),
          ),
          padding: EdgeInsets.all(12.sp),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 30.sp,
                    height: 3.sp,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2.sp),
                    ),
                  ),
                ),
                SizedBox(height: 12.sp),
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.sp),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, size: 14.sp, color: const Color(0xFF5C6BC0)),
                    SizedBox(width: 6.sp),
                    Expanded(
                      child: Text(
                        address,
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.sp),
                Text(
                  "Tentang",
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.sp),
                Text(
                  "Tempat ibadah ini merupakan salah satu destinasi spiritual di Yogyakarta yang menawarkan ketenangan dan keindahan arsitektur tradisional.",
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 16.sp),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5C6BC0),
                    minimumSize: Size(double.infinity, 40.sp),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                  ),
                  onPressed: () => _openMaps(address),
                  child: Text(
                    "Lihat di Peta",
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openMaps(String address) async {
    final encodedAddress = Uri.encodeComponent(address);
    final url = 'https://www.google.com/maps/search/?api=1&query=$encodedAddress';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      // Handle error (e.g., show a snackbar)
    }
  }
}

class PlaceOfWorshipSearchDelegate extends SearchDelegate {
  final List<String> suggestions = [
    "Pura Catur Binuvono Sakti",
    "Pura Jagatnata",
    "Pura Vaikuntha Vyomantara",
    "Masjid Gedhe Kauman",
    "Masjid Jogokariyan",
    "Gereja Santo Fransiskus Xaverius",
    "Gereja Ganjuran",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, size: 20.sp),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, size: 20.sp),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = suggestions
        .where((suggestion) => suggestion.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      padding: EdgeInsets.all(12.sp),
      itemCount: results.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(bottom: 8.sp),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.sp)),
          child: ListTile(
            contentPadding: EdgeInsets.all(8.sp),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(6.sp),
              child: Image.asset(
                "assets/placeholder.jpg",
                width: 40.sp,
                height: 40.sp,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[200],
                  child: Icon(Icons.error, size: 20.sp, color: Colors.grey),
                ),
              ),
            ),
            title: Text(
              results[index],
              style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              "Rumah Ibadah di Yogyakarta",
              style: GoogleFonts.poppins(fontSize: 10.sp, color: Colors.grey[600]),
            ),
            onTap: () {
              close(context, results[index]);
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredSuggestions = suggestions
        .where((suggestion) => suggestion.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      padding: EdgeInsets.all(12.sp),
      itemCount: filteredSuggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            filteredSuggestions[index],
            style: GoogleFonts.poppins(fontSize: 12.sp),
          ),
          onTap: () {
            query = filteredSuggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}


class JogjaBisnisPage extends StatelessWidget {
  const JogjaBisnisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Jogja Bisnis",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFD32F2F),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFFD32F2F), const Color(0xFFF44336)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[100]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                "Eksplorasi Fasilitas Bisnis di Yogyakarta",
                style: GoogleFonts.poppins(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF212121),
                ),
              ),
              SizedBox(height: 8.sp),
              Text(
                "Temukan berbagai peluang bisnis dan fasilitas pendukung di Jogja",
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 24.sp),

              // UKM Section
              _buildSectionHeader("UKM Jogja"),
              SizedBox(height: 12.sp),
              _buildInfoCard(
                title: "Informasi Bisnis UKM",
                imagePath: "lib/icons/bisnis1.jpeg", // Replace with your asset path
                items: [
                  "Toko Oleh-oleh Khas Jogja",
                  "Pasar Modern Berbasis Digital",
                  "Pasar Tradisional Autentik",
                  "Dinas Perindustrian, Perdagangan, Koperasi dan UKM DIY",
                  "Program Pengembangan Bisnis",
                  "Pengelolaan Kekayaan Intelektual",
                  "Alamat: Jl. Nob. Corraminhoje 101-102",
                  "Telp/Fax: (0274) 512437, 574847",
                ],
              ),
              SizedBox(height: 24.sp),

              // Dinas Section
              _buildSectionHeader("Dinas Perindustrian & Perdagangan"),
              SizedBox(height: 12.sp),
              _buildContactCard(
                address: "Jl. Kusuma Negara No.9, Umbulharjo, Yogyakarta 55164",
                website: "http://disperindagkop.jogjaprov.go.id",
                phone: "(0274) 512437",
                imagePath: "lib/icons/bisnis2.jpeg", // Replace with your asset path
              ),
              SizedBox(height: 24.sp),

              // Kopma Instiper Section
              _buildSectionHeader("Kopma Instiper Yogyakarta"),
              SizedBox(height: 12.sp),
              _buildContactCard(
                address: "Jl. Nangka II, Depok, Sleman, DI Yogyakarta",
                phone: "0852-0394-8096",
                email: "deyongay@gmail.com",
                facebook: "https://www.facebook.com/kopma.instiper",
                imagePath: "lib/icons/bisnis3.jpeg", // Replace with your asset path
              ),
              SizedBox(height: 24.sp),

              // UKM Mart Section
              _buildSectionHeader("UKM Mart"),
              SizedBox(height: 12.sp),
              _buildContactCard(
                address: "Jl. Raya Purwomartani, Kalasan, Sleman 55571",
                imagePath: "lib/icons/bisnis4.jpeg", // Replace with your asset path
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),
      decoration: BoxDecoration(
        color: const Color(0xFF1976D2).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.sp),
      ),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF1976D2),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required List<String> items,
    String? imagePath,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.sp),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.sp),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey[50]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imagePath != null)
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.sp)),
                child: Image.asset(
                  imagePath,
                  height: 80.sp,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF212121),
                    ),
                  ),
                  SizedBox(height: 12.sp),
                  ...items.map((item) => Padding(
                        padding: EdgeInsets.only(bottom: 8.sp),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.circle, size: 6.sp, color: const Color(0xFF1976D2)),
                            SizedBox(width: 8.sp),
                            Expanded(
                              child: Text(
                                item,
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required String address,
    String? website,
    String? phone,
    String? email,
    String? facebook,
    String? imagePath,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.sp),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.sp),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey[50]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imagePath != null)
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.sp)),
                child: Image.asset(
                  imagePath,
                  height: 80.sp,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Address
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on, size: 18.sp, color: const Color(0xFF1976D2)),
                      SizedBox(width: 8.sp),
                      Expanded(
                        child: Text(
                          address,
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.sp),

                  // Website
                  if (website != null)
                    _buildContactRow(
                      icon: Icons.language,
                      text: "Kunjungi Website",
                      onTap: () => _launchURL(website),
                    ),

                  // Phone
                  if (phone != null)
                    _buildContactRow(
                      icon: Icons.phone,
                      text: phone,
                      onTap: () => _launchURL("tel:$phone"),
                    ),

                  // Email
                  if (email != null)
                    _buildContactRow(
                      icon: Icons.email,
                      text: email,
                      onTap: () => _launchURL("mailto:$email"),
                    ),

                  // Facebook
                  if (facebook != null)
                    _buildContactRow(
                      icon: Icons.facebook,
                      text: "Lihat Facebook",
                      onTap: () => _launchURL(facebook),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.sp),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.sp),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),
          decoration: BoxDecoration(
            color: const Color(0xFF1976D2).withOpacity(0.05),
            borderRadius: BorderRadius.circular(8.sp),
          ),
          child: Row(
            children: [
              Icon(icon, size: 18.sp, color: const Color(0xFF1976D2)),
              SizedBox(width: 12.sp),
              Expanded(
                child: Text(
                  text,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: const Color(0xFF1976D2),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}



class LokasiATM extends StatelessWidget {
  const LokasiATM({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ATM di Jogja",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFF57C00),
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFFD32F2F), const Color(0xFFF44336)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[100]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                "Lokasi ATM di Yogyakarta",
                style: GoogleFonts.poppins(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF212121),
                ),
              ),
              SizedBox(height: 8.sp),
              Text(
                "Temukan ATM terdekat untuk kebutuhan transaksi Anda",
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 24.sp),

              // ATM Cards
              _buildAtmCard(
                name: "ATM BNI Yogyakarta",
                address: "Jl. Malioboro No.45, Sosromenduran, Gedong Tengen, Kota Yogyakarta, Daerah Istimewa Yogyakarta 55271",
                phone: "(0274) 512345",
                imagePath: "lib/icons/atm1.jpeg", // Replace with your asset path
                is24Hours: true,
              ),
              SizedBox(height: 16.sp),

              _buildAtmCard(
                name: "ATM Mandiri UGM",
                address: "Jl. Kaliurang Km 5, Caturtunggal, Depok, Sleman, Daerah Istimewa Yogyakarta 55281",
                phone: "(0274) 567890",
                imagePath: "lib/icons/atm2.jpeg", // Replace with your asset path
                is24Hours: true,
              ),
              SizedBox(height: 16.sp),

              _buildAtmCard(
                name: "ATM BCA Gejayan",
                address: "Jl. Gejayan No.12, Condongcatur, Depok, Sleman, Daerah Istimewa Yogyakarta 55283",
                imagePath: "lib/icons/atm3.jpeg", // Replace with your asset path
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAtmCard({
    required String name,
    required String address,
    String? phone,
    String? imagePath,
    bool is24Hours = false,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.sp),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.sp),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey[50]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imagePath != null)
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.sp)),
                child: Image.asset(
                  imagePath,
                  height: 100.sp,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4.sp),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                        child: Icon(
                          Icons.account_balance,
                          size: 20.sp,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(width: 12.sp),
                      Expanded(
                        child: Text(
                          name,
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF212121),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.sp),

                  // Address
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on, size: 18.sp, color: const Color(0xFF1976D2)),
                      SizedBox(width: 8.sp),
                      Expanded(
                        child: Text(
                          address,
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.sp),

                  // Phone and Operating Hours
                  if (phone != null || is24Hours)
                    Row(
                      children: [
                        if (phone != null)
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _launchURL("tel:$phone"),
                              child: Row(
                                children: [
                                  Icon(Icons.phone, size: 18.sp, color: const Color(0xFF1976D2)),
                                  SizedBox(width: 8.sp),
                                  Text(
                                    phone,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      color: const Color(0xFF1976D2),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (is24Hours)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.access_time, size: 12.sp, color: Colors.green),
                                SizedBox(width: 4.sp),
                                Text(
                                  "24 Jam",
                                  style: GoogleFonts.poppins(
                                    fontSize: 10.sp,
                                    color: Colors.green[800],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}



class LokasiSPBU extends StatelessWidget {
  const LokasiSPBU({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SPBU di Jogja",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFF44336),
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFFF44336), const Color(0xFFD32F2F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[100]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                "Pilihan Fasilitas SPBU di Jogja",
                style: GoogleFonts.poppins(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF212121),
                ),
              ),
              SizedBox(height: 8.sp),
              Text(
                "Temukan SPBU terdekat di Yogyakarta",
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 24.sp),

              // SPBU Cards
              _buildSpbuCard(
                name: "SPBU Shell 44.552.06",
                address: "JL C Simanjuntak No.17, Terban, Gondokusuman, Kota Yogyakarta, Daerah Istimewa Yogyakarta 55223",
                phone: "(0274) 511800",
                imagePath: "lib/icons/spbu1.jpeg", // Replace with your asset path
                is24Hours: true,
              ),
              SizedBox(height: 16.sp),

              _buildSpbuCard(
                name: "SPBU Pertamina 44.552.15",
                address: "Jalan Am Sangaji No.14, Cokrodiningratan, Jetis, Kota Yogyakarta, Daerah Istimewa Yogyakarta 55233",
                imagePath: "lib/icons/spbu2.jpeg", // Replace with your asset path
                is24Hours: true,
              ),
              SizedBox(height: 16.sp),

              _buildSpbuCard(
                name: "SPBU Vivo 41.551.01",
                address: "Jalan Kompol Suprapto, Lempuyangan, Baciro, Gondokusuman, Kota Yogyakarta, Da`Daerah Istimewa Yogyakarta 55225",
                imagePath: "lib/icons/spbu3.jpeg", // Replace with your asset path
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpbuCard({
    required String name,
    required String address,
    String? phone,
    String? imagePath,
    bool is24Hours = false,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.sp),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.sp),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey[50]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imagePath != null)
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.sp)),
                child: Image.asset(
                  imagePath,
                  height: 100.sp,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4.sp),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                        child: Icon(
                          Icons.local_gas_station,
                          size: 20.sp,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(width: 12.sp),
                      Expanded(
                        child: Text(
                          name,
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF212121),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.sp),

                  // Address
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on, size: 18.sp, color: const Color(0xFF1976D2)),
                      SizedBox(width: 8.sp),
                      Expanded(
                        child: Text(
                          address,
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.sp),

                  // Phone and Operating Hours
                  if (phone != null || is24Hours)
                    Row(
                      children: [
                        if (phone != null)
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _launchURL("tel:$phone"),
                              child: Row(
                                children: [
                                  Icon(Icons.phone, size: 18.sp, color: const Color(0xFF1976D2)),
                                  SizedBox(width: 8.sp),
                                  Text(
                                    phone,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      color: const Color(0xFF1976D2),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (is24Hours)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.access_time, size: 12.sp, color: Colors.green),
                                SizedBox(width: 4.sp),
                                Text(
                                  "24 Jam",
                                  style: GoogleFonts.poppins(
                                    fontSize: 10.sp,
                                    color: Colors.green[800],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}



class BudayaJogjaPage extends StatelessWidget {
  const BudayaJogjaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Budaya Jogja", 
               style: GoogleFonts.poppins(
                 fontWeight: FontWeight.w600,
                 color: Colors.white,
               )),
        backgroundColor: const Color(0xFFAB47BC), // Purple color
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _showSearch(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              "Pilihan Budaya Terbaik di Jogja",
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24.sp),
            
            // Kavvasan Section
            _buildCultureSection(
              title: "Kavvasan",
              items: [
                "Benda",
                "Seni Rupa",
                "Pertunjukan",
                "Sinematografi",
                "Kolonialisme",
                "Mataram Kuno",
                "Mataram Islam",
                "Jejak Akulturasi Budaya",
                "Jejak Revolusi Perjuangan",
                "Ngayogyakarta Hadiningrat",
                "Desa Budaya",
              ],
              description: "Situs Sukuh Permeturasedakutor II\nBerdasarkan sejarah, situs dengan luas kurang lebih 9.000 m² merupakan pesanggrahan peninggalan Sultan Hamengkubuwono II.",
            ),
            SizedBox(height: 24.sp),
            
            // Candi Section
            _buildCultureSection(
              title: "Candi Ganjuran",
              subtitle: "Kavvasan Cagar Budaya",
              year: "1926",
              description: "Candi Hati Kudus Tuhan Yesus di Ganjuran Bantul Yogyakarta adalah salah satu tempat ziarah rohani umat Katolik, yang...",
            ),
            SizedBox(height: 24.sp),
            
            // Imogiri Section
            _buildCultureSection(
              title: "Imogiri",
              subtitle: "Kavvasan Cagar Budaya",
              year: "1632",
              description: "Permakaman Imogiri, Pasarean Imogiri, atau Pajimatan Girirejo Imogiri merupakan kompleks permakaman yang...",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCultureSection({
    required String title,
    String? subtitle,
    String? year,
    List<String>? items,
    String? description,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.sp),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title with optional subtitle and year
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFAB47BC),
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(width: 8.sp),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
                if (year != null) ...[
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.sp,
                      vertical: 4.sp,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber[50],
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                    child: Text(
                      year,
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        color: Colors.amber[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            SizedBox(height: 12.sp),
            
            // Items list if available
            if (items != null) Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8.sp,
                  runSpacing: 8.sp,
                  children: items.map((item) => Chip(
                    label: Text(item),
                    backgroundColor: Colors.purple[50],
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 10.sp,
                      color: const Color(0xFFAB47BC),
                    ),
                  )).toList(),
                ),
                SizedBox(height: 12.sp),
              ],
            ),
            
            // Description
            if (description != null) Text(
              description,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
              ),
              textAlign: TextAlign.justify,
            ),
            
            // Explore button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFAB47BC),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Jelajahi"),
                    SizedBox(width: 4.sp),
                    Icon(Icons.arrow_forward, size: 16.sp),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: CultureSearchDelegate(),
    );
  }
}

class CultureSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text("Hasil pencarian: $query"));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text("Ketik untuk mencari budaya Jogja"));
  }
}

// Navigation item
final Map<String, dynamic> budayaItem = {
  'name': 'Budaya Jogja',
  'icon': Icons.account_balance,
  'color': const Color(0xFFAB47BC),
  'description': '',
  'action': (BuildContext context) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: const BudayaJogjaPage(),
      ),
    );
  },
};

// Halaman One Data
class StatistikDaerahPage extends StatelessWidget {
  const StatistikDaerahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Statistik Daerah", style: GoogleFonts.poppins()),
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
      ),
      body: Center(
        child: Text(
          "Data Statistik Daerah DIY",
          style: GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class DataTerbukaPage extends StatelessWidget {
  const DataTerbukaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Terbuka", style: GoogleFonts.poppins()),
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
      ),
      body: Center(
        child: Text(
          "Portal Data Terbuka DIY",
          style: GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class VisualisasiDataPage extends StatelessWidget {
  const VisualisasiDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visualisasi Data", style: GoogleFonts.poppins()),
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
      ),
      body: Center(
        child: Text(
          "Visualisasi Data DIY",
          style: GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}


class AllEventsPage extends StatelessWidget {
  final List<Map<String, dynamic>> eventItems;

  const AllEventsPage({super.key, required this.eventItems});

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(16.h),
      child: Container(
        padding: EdgeInsets.only(top: 6.h, left: 5.w, right: 5.w, bottom: 2.h),
        decoration: BoxDecoration(
          gradient: AppStyles.appBarGradient,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "All Events",
                      style: GoogleFonts.inter(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Explore cultural events in Yogyakarta",
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white.withOpacity(0.2),
              child: IconButton(
                icon: const Icon(Icons.filter_list, color: Colors.white, size: 24),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Filter Options Coming Soon!',
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                      backgroundColor: const Color(0xFF00C4B4),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        itemCount: eventItems.length,
        itemBuilder: (context, index) {
          final event = eventItems[index];
          final dateFormatter = DateFormat('EEEE, d MMMM yyyy');
          final timeFormatter = DateFormat('h:mm a');
          final formattedDate = dateFormatter.format(event['date']);
          final formattedTime = timeFormatter.format(event['date']);

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: EventDetailsPage(
                    title: event['title'],
                    image: event['image'],
                    date: formattedDate,
                    time: formattedTime,
                    location: event['location'],
                    speaker: event['speaker'],
                    daysLeft: event['date'].difference(DateTime.now()).inDays,
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 2.h),
              decoration: AppStyles.cardDecoration(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.asset(
                      event['image'],
                      height: 20.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 50),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event['title'],
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            Icon(Icons.event, size: 16.sp, color: const Color(0xFF03BE96)),
                            SizedBox(width: 1.w),
                            Text(
                              formattedDate,
                              style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black87),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 16.sp, color: const Color(0xFF03BE96)),
                            SizedBox(width: 1.w),
                            Text(
                              event['location'],
                              style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black87),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}