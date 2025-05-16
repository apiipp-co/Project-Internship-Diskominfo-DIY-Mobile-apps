// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';

// --- Detail Screen Class Definition ---
class CctvDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> cctvData;

  // Konstruktor const aman selama tidak ada nilai default parameter yang menggunakan .sp/.h/.w
  const CctvDetailsScreen({super.key, required this.cctvData});

  // Gaya untuk AppBar baru (disamakan dengan MessageTabAll AppBar "Helpdesk")
  // Ini adalah konstanta waktu kompilasi, jadi tidak boleh menggunakan .sp/.h/.w di sini.
  static const LinearGradient detailAppBarGradient = LinearGradient(
    colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 79, 5, 5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const BorderRadius detailAppBarBorderRadius = BorderRadius.vertical(bottom: Radius.circular(30));
  static const List<BoxShadow> detailAppBarShadow = [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 10,
      offset: Offset(0, 4),
    ),
  ];

  // Warna yang digunakan di body content
  static const Color primaryColorBody = Color.fromARGB(255, 196, 0, 0);
  static const Color textDarkColor = Color(0xFF212121);
  static const Color textLightColor = Color(0xFF757575);
  static const Color backgroundColorBody = Color(0xFFF5F7FA);


  Widget _buildCustomAppBar(BuildContext context, String title, String subtitle) {
    // Container ini TIDAK BOLEH const jika padding/child menggunakan .sp/.h/.w
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 0.5.h,
          left: 2.w,
          right: 3.w,
          bottom: 1.5.h),
      decoration: BoxDecoration( // BoxDecoration TIDAK const jika gradient/borderRadius/boxShadow bukan const (tapi di sini mereka const)
        gradient: detailAppBarGradient,
        borderRadius: detailAppBarBorderRadius,
        boxShadow: detailAppBarShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                // IconButton TIDAK BOLEH const jika child/padding/iconSize menggunakan .sp/.h/.w
                IconButton(
                  icon: Container( // Container TIDAK BOLEH const jika padding menggunakan .sp
                    padding: EdgeInsets.all(Device.screenType == ScreenType.tablet ? 6.sp : 7.sp),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.2), width: 1)
                    ),
                    // Icon ini bisa const JIKA size-nya literal, JANGAN .sp
                    // Jika size pakai .sp, Icon tidak boleh const.
                    child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: Device.screenType == ScreenType.tablet ? 16.sp : 17.sp),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  splashRadius: 22.sp, // Nilai ini dinamis
                  constraints: BoxConstraints(),
                  padding: EdgeInsets.zero, // EdgeInsets.zero adalah const
                ),
                // SizedBox TIDAK BOLEH const jika width/height menggunakan .w/.h
                SizedBox(width: 2.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text TIDAK BOLEH const jika style/fontSize menggunakan .sp
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: Device.screenType == ScreenType.tablet ? 20.sp : 19.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subtitle.isNotEmpty && subtitle != 'Lokasi tidak tersedia')
                        // Padding TIDAK BOLEH const jika padding menggunakan .h
                        Padding(
                          padding: EdgeInsets.only(top: 0.3.h),
                          child: Text(
                            subtitle,
                            style: GoogleFonts.inter(
                              fontSize: Device.screenType == ScreenType.tablet ? 13.sp : 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withOpacity(0.85),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                // SnackBar TIDAK const jika margin/shape/content style menggunakan .sp/.w/.h
                SnackBar(
                  content: Text('Membagikan lokasi CCTV: $title...', style: GoogleFonts.inter(color: Colors.white)),
                  backgroundColor: primaryColorBody.withOpacity(0.9),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.sp)),
                  margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                ),
              );
            },
            child: Container( // Container TIDAK BOLEH const jika padding menggunakan .sp
              padding: EdgeInsets.all(Device.screenType == ScreenType.tablet ? 9.sp : 10.sp),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.2), width: 1)
              ),
              child: Icon(Icons.share_outlined, color: Colors.white, size: Device.screenType == ScreenType.tablet ? 18.sp : 19.sp),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.15, duration: 400.ms, curve: Curves.easeOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    final mainText = cctvData['maintext'] as String? ?? 'Detail CCTV';
    final subText = cctvData['subtext'] as String? ?? 'Lokasi tidak tersedia';
    final imagePathOrUrl = cctvData['image'] as String?;
    final status = cctvData['status'] as String? ?? '-';
    final type = cctvData['type'] as String? ?? '-';
    final distance = cctvData['distance'] as String? ?? '-';
    final lastUpdated = cctvData['lastUpdated'] as String? ?? '-';
    final lat = cctvData['lat']?.toString() ?? '-';
    final lng = cctvData['lng']?.toString() ?? '-';
    final isOnline = status == 'Online';

    Widget imageDisplayWidget;
    if (imagePathOrUrl != null && imagePathOrUrl.isNotEmpty) {
      if (imagePathOrUrl.startsWith('http')) {
        imageDisplayWidget = CachedNetworkImage( // TIDAK const
          imageUrl: imagePathOrUrl,
          height: 30.h,
          width: double.infinity,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container( // TIDAK const
            height: 30.h,
            color: Colors.grey[200],
            child: Center(child: CircularProgressIndicator(color: primaryColorBody)),
          ),
          errorWidget: (context, url, error) => Container( // TIDAK const
            height: 30.h,
            color: Colors.grey[200],
            child: Icon(Icons.broken_image_outlined, color: Colors.grey[400], size: 15.w),
          ),
        );
      } else {
        imageDisplayWidget = Image.asset( // TIDAK const
          imagePathOrUrl,
          height: 30.h,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container( // TIDAK const
              height: 30.h,
              color: Colors.grey[200],
              child: Icon(Icons.broken_image_outlined, color: Colors.grey[400], size: 15.w),
            );
          },
        );
      }
    } else {
      imageDisplayWidget = Container( // TIDAK const
        height: 20.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15.sp),
        ),
        child: Icon(Icons.videocam_off_outlined, color: Colors.grey[400], size: 15.w),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColorBody,
      appBar: PreferredSize( // TIDAK const
        preferredSize: Size.fromHeight(Device.screenType == ScreenType.tablet ? 11.h : 9.h),
        child: _buildCustomAppBar(context, mainText, subText),
      ),
      body: SingleChildScrollView( // TIDAK const
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero( // TIDAK const
              tag: 'cctv_image_${cctvData['id'] ?? imagePathOrUrl}',
              child: ClipRRect( // TIDAK const
                borderRadius: BorderRadius.circular(15.sp),
                child: imageDisplayWidget,
              ),
            ),
            SizedBox(height: 2.5.h), // TIDAK const
            Text( // TIDAK const
              mainText,
              style: GoogleFonts.inter(fontSize: 20.sp, fontWeight: FontWeight.w700, color: textDarkColor),
            ),
            SizedBox(height: 0.8.h), // TIDAK const
            Text( // TIDAK const
              subText,
              style: GoogleFonts.inter(fontSize: 15.sp, color: textLightColor),
            ),
            Divider(height: 3.5.h, thickness: 0.8, color: Colors.grey[300]), // TIDAK const
            _buildDetailRow(Icons.online_prediction_rounded, "Status", status, isOnline ? Colors.green.shade600 : Colors.red.shade700),
            _buildDetailRow(Icons.video_camera_back_outlined, "Tipe", type, primaryColorBody),
            _buildDetailRow(Icons.pin_drop_outlined, "Jarak", distance, textLightColor),
            _buildDetailRow(Icons.access_time_filled_rounded, "Terakhir Update", lastUpdated, textLightColor),
            _buildDetailRow(Icons.map_outlined, "Koordinat", "$lat, $lng", textLightColor),
            SizedBox(height: 3.5.h), // TIDAK const
            Center(
              child: ElevatedButton.icon( // TIDAK const
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Fitur Live View untuk $mainText segera hadir!', style: GoogleFonts.inter())),
                  );
                },
                // Icon ini bisa const JIKA size nya literal. Jika size pakai .sp, tidak boleh const
                icon: Icon(Icons.play_circle_outline_rounded, color: Colors.white, size: 20.sp),
                label: Text("Lihat Live Streaming", style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 14.sp)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColorBody,
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.6.h),
                  textStyle: TextStyle(fontSize: 14.sp), // fontSize menggunakan .sp
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.sp)), // borderRadius menggunakan .sp
                  elevation: 3,
                ),
              ).animate().scale(delay: 200.ms, duration: 400.ms, curve: Curves.elasticOut),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, Color valueColor) {
    // Padding TIDAK BOLEH const jika padding menggunakan .h
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon TIDAK BOLEH const jika size menggunakan .sp
          Icon(icon, color: textLightColor, size: 19.sp),
          // SizedBox TIDAK BOLEH const jika width menggunakan .w
          SizedBox(width: 4.w),
          Text(
            "$label:",
            style: GoogleFonts.inter(fontSize: 13.5.sp, color: textLightColor, fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(fontSize: 13.5.sp, color: valueColor, fontWeight: FontWeight.w600),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

// --- Main Search Screen Class (TETAP SAMA, TIDAK DIUBAH KECUALI DIPERLUKAN UNTUK KOMPILASI) ---
class cctv_search extends StatefulWidget {
  // Konstruktor bisa const jika tidak ada field yang diinisialisasi dengan non-const
  const cctv_search({super.key});

  @override
  _CctvSearchState createState() => _CctvSearchState();
}

class _CctvSearchState extends State<cctv_search> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool _isLoading = true;
  List<Map<String, dynamic>> _cctvLocations = [];
  List<Map<String, dynamic>> _filteredCctvLocations = [];
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchFocused = false;

  // Warna ini didefinisikan sebagai static const, jadi aman
  static const primaryColor = Color.fromARGB(255, 196, 0, 0);
  static const secondaryColor = Color.fromARGB(255, 166, 38, 38);
  static const backgroundColor = Color(0xFFF5F7FA);
  static const textDarkColor = Color(0xFF212121);
  static const textLightColor = Color(0xFF757575);
  static const cardBackgroundColor = Colors.white;
  static const shimmerBaseColor = Color(0xFFE0E0E0);
  static const shimmerHighlightColor = Color(0xFFF5F5F5);

  final List<Map<String, dynamic>> _sampleCctvData = [
    {
      'id': 'cctv_001', 'maintext': 'Titik Nol Kilometer Yogyakarta', 'subtext': 'Jl. Malioboro, Pusat Kota',
      'image': 'lib/icons/cctv1.jpeg',
      'distance': '1.2 km', 'status': 'Online', 'lastUpdated': '2 menit lalu', 'type': 'Publik Strategis',
      'lat': -7.7925, 'lng': 110.3657,
    },
    {
      'id': 'cctv_002', 'maintext': 'Simpang Empat Gondomanan', 'subtext': 'Dekat Alun-Alun Utara',
      'image': 'lib/icons/cctv2.jpeg',
      'distance': '3.5 km', 'status': 'Offline', 'lastUpdated': '15 menit lalu', 'type': 'Lalu Lintas Vital',
      'lat': -7.8183, 'lng': 110.3621,
    },
    {
      'id': 'cctv_003', 'maintext': 'Jalan Magelang (Jombor Flyover)', 'subtext': 'Sleman, Akses Utara',
      'image': 'lib/icons/cctv3.jpeg',
      'distance': '2.8 km', 'status': 'Online', 'lastUpdated': 'Baru saja', 'type': 'Keamanan Publik',
      'lat': -7.7471, 'lng': 110.3554,
    },
    {
      'id': 'cctv_004', 'maintext': 'Bundaran Universitas Gadjah Mada', 'subtext': 'Bulaksumur, Area Kampus',
      'image': 'lib/icons/cctv4.jpeg',
      'distance': '4.0 km', 'status': 'Online', 'lastUpdated': '5 menit lalu', 'type': 'Lalu Lintas Kampus',
      'lat': -7.7972, 'lng': 110.3705,
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _fetchData();
    _searchController.addListener(() {
      _filterCctvLocations(_searchController.text);
    });
    _searchFocusNode.addListener(_onSearchFocusChange);
  }

  void _onSearchFocusChange() {
    if (mounted) {
      setState(() {
        _isSearchFocused = _searchFocusNode.hasFocus;
      });
    }
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800), // const Duration aman
    )..forward();
  }

  Future<void> _fetchData({bool isRefresh = false}) async {
    if (!isRefresh && mounted) {
      setState(() => _isLoading = true);
    }
    await Future.delayed(Duration(seconds: isRefresh ? 1 : 2)); // Duration tidak const di sini, tapi aman
    final newData = List<Map<String, dynamic>>.from(_sampleCctvData);
    if (mounted) {
      setState(() {
        _cctvLocations = newData;
        _filterCctvLocations(_searchController.text);
        _isLoading = false;
      });
    }
  }

  Future<void> _onRefresh() async {
    await _fetchData(isRefresh: true);
    if (mounted) {
      _searchController.clear();
    }
    _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _refreshController.dispose();
    _searchController.removeListener(() { _filterCctvLocations(_searchController.text); });
    _searchController.dispose();
    _searchFocusNode.removeListener(_onSearchFocusChange);
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _filterCctvLocations(String query) {
    final lowerCaseQuery = query.toLowerCase().trim();
    final filtered = lowerCaseQuery.isEmpty
        ? List<Map<String, dynamic>>.from(_cctvLocations)
        : _cctvLocations.where((cctv) {
            final mainText = cctv['maintext']?.toLowerCase() ?? '';
            final subText = cctv['subtext']?.toLowerCase() ?? '';
            final type = cctv['type']?.toLowerCase() ?? '';
            return mainText.contains(lowerCaseQuery) ||
                   subText.contains(lowerCaseQuery) ||
                   type.contains(lowerCaseQuery);
          }).toList();

    if (mounted) {
      setState(() {
        _filteredCctvLocations = filtered;
      });
    }
  }

  Widget _buildShimmerCard() {
    // Container dan widget di dalamnya TIDAK const jika menggunakan .sp/.h/.w
    return Shimmer.fromColors(
      baseColor: shimmerBaseColor,
      highlightColor: shimmerHighlightColor,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: cardBackgroundColor,
          borderRadius: BorderRadius.circular(15.sp),
        ),
        child: Row(
          children: [
            Container(
              width: 24.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: shimmerBaseColor,
                borderRadius: BorderRadius.circular(12.sp),
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(height: 2.h, width: 60.w, color: shimmerBaseColor), SizedBox(height: 1.h),
                  Container(height: 1.5.h, width: 40.w, color: shimmerBaseColor), SizedBox(height: 1.h),
                  Container(height: 1.5.h, width: 50.w, color: shimmerBaseColor), SizedBox(height: 1.h),
                  Container(height: 1.5.h, width: 30.w, color: shimmerBaseColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    // TIDAK const jika borderRadius menggunakan .sp
    return BoxDecoration(
      color: cardBackgroundColor,
      borderRadius: BorderRadius.circular(15.sp),
      boxShadow: [ // List ini BISA const JIKA BoxShadow di dalamnya juga const (dan tidak pakai .sp)
        BoxShadow(
          color: Colors.grey.withOpacity(0.15),
          blurRadius: 12,
          offset: const Offset(0, 4), // const Offset aman
        ),
      ],
    );
  }

  Widget _buildCctvCard(Map<String, dynamic> cctv, int index) {
    final isOnline = cctv['status'] == 'Online';
    final animationDelay = Duration(milliseconds: 100 + (index * 50));

    final imagePathOrUrl = cctv['image'] as String? ?? 'lib/icons/cctv_placeholder.png';
    final mainText = cctv['maintext'] as String? ?? 'Lokasi Tidak Diketahui';
    final subText = cctv['subtext'] as String? ?? '';
    final status = cctv['status'] as String? ?? 'Unknown';
    final type = cctv['type'] as String? ?? '-';
    final distance = cctv['distance'] as String? ?? '-';
    final lastUpdated = cctv['lastUpdated'] as String? ?? '-';

    Widget imageWidget;
    if (imagePathOrUrl.startsWith('http')) {
      imageWidget = CachedNetworkImage(
        imageUrl: imagePathOrUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: shimmerBaseColor,
          highlightColor: shimmerHighlightColor,
          child: Container(color: cardBackgroundColor),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[200],
          child: Icon(Icons.broken_image_outlined, color: Colors.grey[400], size: 10.w),
        ),
      );
    } else {
      imageWidget = Image.asset(
        imagePathOrUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[200],
            child: Icon(Icons.broken_image_outlined, color: Colors.grey[400], size: 10.w),
          );
        },
      );
    }

    // GestureDetector TIDAK const
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 400), // const Duration aman
            child: CctvDetailsScreen(cctvData: cctv), // CctvDetailsScreen adalah const constructor
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        decoration: _cardDecoration(), // _cardDecoration() TIDAK const
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 24.w,
                height: double.infinity,
                margin: EdgeInsets.all(1.5.w),
                child: Hero(
                  tag: 'cctv_image_${cctv['id'] ?? imagePathOrUrl}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.sp),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        imageWidget,
                        Positioned(
                          top: 1.h,
                          left: 1.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                            decoration: BoxDecoration(
                                color: isOnline ? Colors.green.shade600.withOpacity(0.85) : Colors.red.shade600.withOpacity(0.85),
                                borderRadius: BorderRadius.circular(8.sp),
                                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 3, offset: const Offset(0, 1))]), // const Offset aman
                            child: Text(status, style: GoogleFonts.inter(fontSize: 10.5.sp, color: Colors.white, fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(mainText, style: GoogleFonts.inter(fontSize: 15.sp, fontWeight: FontWeight.w700, color: textDarkColor), maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text(subText, style: GoogleFonts.inter(fontSize: 13.sp, color: textLightColor), maxLines: 1, overflow: TextOverflow.ellipsis),
                      SizedBox(height: 1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                            decoration: BoxDecoration(color: primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8.sp)),
                            child: Text(type, style: GoogleFonts.inter(fontSize: 11.sp, color: primaryColor, fontWeight: FontWeight.w500)),
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined, color: secondaryColor, size: 14.sp),
                              SizedBox(width: 1.w),
                              Text(distance, style: GoogleFonts.inter(fontSize: 12.sp, color: textLightColor, fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0.5.h),
                        child: Text('Update: $lastUpdated', style: GoogleFonts.inter(fontSize: 11.sp, color: textLightColor.withOpacity(0.8))),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 4.w),
                child: Icon(Icons.chevron_right_rounded, color: primaryColor.withOpacity(0.7), size: 22.sp),
              ),
            ],
          ),
        ),
      ).animate(delay: animationDelay)
       .fadeIn(duration: 400.ms)
       .slide(begin: const Offset(0, 0.1), duration: 400.ms), // const Offset aman
    );
  }

  @override
  Widget build(BuildContext context) {
    // Theme TIDAK const jika ada properti non-const di dalamnya
    return Theme(
      data: Theme.of(context).copyWith(
          primaryColor: primaryColor,
          hintColor: textLightColor,
          scaffoldBackgroundColor: backgroundColor,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: primaryColor,
            secondary: secondaryColor,
            brightness: Brightness.light,
          ),
          textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme).copyWith(
            bodyMedium: TextStyle(color: textDarkColor, fontSize: 14.sp), // .sp di sini aman karena Theme TIDAK const
            bodyLarge: TextStyle(color: textDarkColor, fontSize: 16.sp),
            titleMedium: TextStyle(color: textDarkColor, fontWeight: FontWeight.w600, fontSize: 16.sp),
            titleLarge: TextStyle(color: textDarkColor, fontWeight: FontWeight.w700, fontSize: 18.sp),
          ),
          cardTheme: CardTheme(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp)), // .sp di sini aman
            color: cardBackgroundColor,
          )),
      child: Scaffold(
        body: SafeArea(
          child: SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            header: WaterDropMaterialHeader(
              backgroundColor: primaryColor,
              color: Colors.white,
            ),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(), // const BouncingScrollPhysics aman
              slivers: [
                _buildSliverHeader(),
                SliverToBoxAdapter(child: _buildSearchBar().animate().fadeIn(delay: 200.ms).scaleX(begin: 0.9, duration: 300.ms)),
                SliverToBoxAdapter(child: SizedBox(height: 2.h)),
                SliverToBoxAdapter(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Text("Peta Lokasi CCTV", style: GoogleFonts.inter(fontSize: 18.sp, fontWeight: FontWeight.w700, color: textDarkColor)),
                ).animate().fadeIn(delay: 300.ms)),
                SliverToBoxAdapter(child: SizedBox(height: 1.5.h)),
                SliverToBoxAdapter(child: _buildMapViewPlaceholder().animate().fadeIn(delay: 400.ms).scale(duration: 400.ms)),
                SliverToBoxAdapter(child: SizedBox(height: 3.h)),
                SliverToBoxAdapter(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Text("Daftar CCTV Terdekat", style: GoogleFonts.inter(fontSize: 18.sp, fontWeight: FontWeight.w700, color: textDarkColor)),
                ).animate().fadeIn(delay: 500.ms)),
                SliverToBoxAdapter(child: SizedBox(height: 1.h)),
                _buildSliverCctvList(),
                SliverToBoxAdapter(child: SizedBox(height: 12.h)),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showSnackbar("Fitur Peta Interaktif segera hadir!"),
          backgroundColor: primaryColor,
          // Icon BISA const jika size literal
          icon: const Icon(Icons.map_outlined, size: 24, color: Colors.white),
          label: Text("Lihat Peta", style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 14.sp)),
          elevation: 4.0,
        ).animate().slide(begin: const Offset(0, 0.5), delay: 600.ms, duration: 500.ms).fadeIn(), // const Offset aman
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  void _showSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar( // TIDAK const
        content: Text(message, style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w500)),
        backgroundColor: isError ? Colors.redAccent : primaryColor.withOpacity(0.9),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp)), // .sp di sini aman
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h), // .w dan .h di sini aman
        duration: const Duration(seconds: 3), // const Duration aman
      ),
    );
  }

  Widget _buildSliverHeader() {
    // SliverAppBar TIDAK const
    return SliverAppBar(
      floating: true,
      snap: true,
      expandedHeight: 18.h, // .h di sini aman
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar( // FlexibleSpaceBar TIDAK const
        background: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 1.h, left: 5.w, right: 5.w, bottom: 2.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor.withOpacity(0.9), secondaryColor.withOpacity(0.95)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            // BorderRadius ini BISA const JIKA tidak pakai .sp/.h/.w
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25)), // literal, jadi aman
            boxShadow: [BoxShadow(color: primaryColor.withOpacity(0.2), blurRadius: 15, offset: const Offset(0, 5))], // const Offset aman
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), shape: BoxShape.circle),
                      // Icon ini BISA const JIKA size literal
                      child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18), // literal size, aman
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Monitoring CCTV", style: GoogleFonts.inter(fontSize: 20.sp, fontWeight: FontWeight.w800, color: Colors.white)),
                      Text("Pantau Jogja real-time", style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w400, color: Colors.white.withOpacity(0.8))),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => _showSnackbar('Fitur Filter segera hadir!'),
                child: Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), shape: BoxShape.circle),
                  // Icon ini BISA const JIKA size literal
                  child: const Icon(Icons.filter_list_rounded, color: Colors.white, size: 22), // literal size, aman
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 400.ms),
      ),
    );
  }

  Widget _buildSearchBar() {
    // Padding TIDAK const jika padding menggunakan .w/.h
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      child: Material( // Material TIDAK const jika borderRadius menggunakan .sp
        elevation: _isSearchFocused ? 6.0 : 2.0,
        shadowColor: _isSearchFocused ? primaryColor.withOpacity(0.3) : Colors.black.withOpacity(0.15),
        borderRadius: BorderRadius.circular(30.sp),
        child: TextField( // TextField TIDAK const
          controller: _searchController,
          focusNode: _searchFocusNode,
          style: GoogleFonts.inter(fontSize: 15.sp, color: textDarkColor),
          decoration: InputDecoration( // InputDecoration TIDAK const
            contentPadding: EdgeInsets.symmetric(vertical: 1.5.h),
            hintText: "Cari lokasi CCTV...",
            hintStyle: GoogleFonts.inter(fontSize: 15.sp, color: textLightColor),
            prefixIcon: Padding( // Padding TIDAK const jika padding menggunakan .w
              padding: EdgeInsets.only(left: 4.w, right: 2.w),
              child: Icon(Icons.search_rounded, color: _isSearchFocused ? primaryColor : textLightColor, size: 20.sp),
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.clear_rounded, color: textLightColor, size: 20.sp),
                    onPressed: () {
                      _searchController.clear();
                      _searchFocusNode.unfocus();
                    },
                    splashRadius: 20, // literal aman
                  )
                : Padding(
                    padding: EdgeInsets.only(right: 3.w),
                    child: Icon(Icons.mic_none_rounded, color: textLightColor, size: 20.sp),
                  ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.sp), borderSide: BorderSide.none),
            filled: true,
            fillColor: cardBackgroundColor,
          ),
          onEditingComplete: () => _searchFocusNode.unfocus(),
          onSubmitted: (_) => _searchFocusNode.unfocus(),
        ),
      ),
    );
  }

  Widget _buildMapViewPlaceholder() {
    String mapPlaceholderPath = 'lib/icons/map.png';

    // Container TIDAK const jika margin/height/borderRadius menggunakan .sp/.h/.w
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      height: 25.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.sp),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 12, offset: const Offset(0, 4))], // const Offset aman
      ),
      child: ClipRRect( // ClipRRect TIDAK const jika borderRadius menggunakan .sp
        borderRadius: BorderRadius.circular(15.sp),
        child: Stack( // Stack TIDAK const
          fit: StackFit.expand,
          children: [
            Image.asset( // Image.asset TIDAK const
              mapPlaceholderPath,
              fit: BoxFit.cover,
              opacity: AlwaysStoppedAnimation(0.8), // AlwaysStoppedAnimation bisa const jika value-nya const
              errorBuilder: (context, error, stackTrace) {
                return Container( // Container TIDAK const
                  color: Colors.grey[300],
                  alignment: Alignment.center, // Alignment.center adalah const
                  child: Icon(Icons.map_outlined, color: Colors.grey[500], size: 20.w),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.1), Colors.black.withOpacity(0.3)],
                  begin: Alignment.topCenter, // Alignment.topCenter adalah const
                  end: Alignment.bottomCenter, // Alignment.bottomCenter adalah const
                ),
              ),
            ),
            Center( // Center TIDAK const jika child-nya tidak const
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), borderRadius: BorderRadius.circular(10.sp)),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // MainAxisSize.min adalah const
                  children: [
                    Icon(Icons.map_outlined, color: Colors.white, size: 18.sp),
                    SizedBox(width: 2.w),
                    Text('Peta Interaktif Segera Hadir', style: GoogleFonts.inter(fontSize: 13.sp, color: Colors.white, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
            Positioned( // Positioned TIDAK const jika bottom/left/child menggunakan nilai non-const
              bottom: 2.h,
              left: 2.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9), borderRadius: BorderRadius.circular(10.sp), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5)]),
                child: Row(
                  children: [
                    Icon(Icons.videocam_outlined, color: primaryColor, size: 16.sp),
                    SizedBox(width: 1.5.w),
                    Text("${_filteredCctvLocations.length} Lokasi", style: GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w600, color: primaryColor)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverCctvList() {
    if (_isLoading) {
      return SliverList(delegate: SliverChildBuilderDelegate((_, __) => _buildShimmerCard(), childCount: 5));
    } else if (_filteredCctvLocations.isEmpty) {
      return SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off_rounded, size: 50.sp, color: textLightColor.withOpacity(0.5)),
              SizedBox(height: 2.h),
              Text(
                _searchController.text.isEmpty ? "Belum ada data CCTV" : "CCTV tidak ditemukan",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(fontSize: 16.sp, color: textLightColor, fontWeight: FontWeight.w500),
              ),
              if (_searchController.text.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 0.5.h),
                  child: Text("Coba kata kunci lain.", textAlign: TextAlign.center, style: GoogleFonts.inter(fontSize: 14.sp, color: textLightColor.withOpacity(0.8))),
                ),
            ],
          ),
        ),
      );
    } else {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final cctvItem = _filteredCctvLocations[index];
            return _buildCctvCard(cctvItem, index);
          },
          childCount: _filteredCctvLocations.length,
        ),
      );
    }
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Konstruktor MyApp BISA const
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ResponsiveSizer TIDAK const
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        // MaterialApp TIDAK const jika theme/home/routes non-const
        return MaterialApp(
          title: 'CCTV Monitoring App',
          theme: ThemeData( // ThemeData TIDAK const jika ada properti non-const
            primaryColor: _CctvSearchState.primaryColor, // Ini adalah static const, aman
            scaffoldBackgroundColor: _CctvSearchState.backgroundColor, // Ini static const, aman
            textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme), // Ini TIDAK const
            appBarTheme: AppBarTheme( // AppBarTheme TIDAK const jika ada properti non-const
              backgroundColor: _CctvSearchState.primaryColor, // static const, aman
              titleTextStyle: GoogleFonts.inter(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white), // .sp di sini aman karena AppBarTheme TIDAK const
              iconTheme: IconThemeData(color: Colors.white), // IconThemeData bisa const jika color const
            )
          ),
          debugShowCheckedModeBanner: false,
          home: const cctv_search(), // cctv_search() adalah const constructor, aman
        );
      },
    );
  }
}