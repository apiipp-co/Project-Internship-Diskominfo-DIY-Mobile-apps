// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// --- App Styles & Theme ---
class AppTheme {
  static final Color primaryColor = Color.fromARGB(255, 185, 25, 25);
  static final Color accentColor = Color.fromARGB(255, 235, 195, 30);
  static final Color secondaryColor = Color.fromARGB(255, 80, 8, 8);
  static final Color textColor = Color(0xFF2C2F33);
  static final Color subtleTextColor = Colors.grey.shade600;
  static final Color surfaceColor = Colors.white;
  static final Color backgroundColor = Color(0xFFF7F8FC);
  static final Color shimmerBaseColor = Colors.grey.shade300;
  static final Color shimmerHighlightColor = Colors.grey.shade100;

  static final LinearGradient appBarGradient = LinearGradient(
    colors: [primaryColor, secondaryColor.withOpacity(0.9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Pastikan path ini benar dan file ada di assets Anda
  // dan telah dideklarasikan di pubspec.yaml
  static const String placeholderImagePath = 'lib/icons/news_placeholder.png';
  static const String patternImagePath = 'lib/icons/batik_pattern_subtle.png';

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    hintColor: accentColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: accentColor,
      surface: surfaceColor,
      error: Colors.red.shade900,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: textColor,
      onError: Colors.white,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme).copyWith(
      headlineLarge: GoogleFonts.merriweather(
        fontSize: 23.sp,
        fontWeight: FontWeight.bold,
        color: textColor,
        height: 1.35,
      ),
      headlineMedium: GoogleFonts.merriweather(
        fontSize: 19.sp,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 17.sp,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 15.sp,
        height: 1.7,
        color: textColor.withOpacity(0.95),
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 13.5.sp,
        color: textColor.withOpacity(0.85),
        height: 1.6,
      ),
      labelLarge: GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 11.5.sp,
        color: subtleTextColor,
        fontWeight: FontWeight.w500,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white, size: 19.sp),
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 17.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    cardTheme: CardTheme(
      elevation: 2.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.symmetric(vertical: 1.2.h),
      color: surfaceColor,
      shadowColor: Colors.black.withOpacity(0.06),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: surfaceColor.withOpacity(0.8),
      selectedColor: primaryColor,
      secondarySelectedColor: primaryColor,
      labelStyle: GoogleFonts.poppins(
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        color: primaryColor,
      ),
      secondaryLabelStyle: GoogleFonts.poppins(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 4.5.w, vertical: 1.2.h),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: BorderSide(color: Colors.grey.shade300, width: 0.8)
       ),
      selectedShadowColor: primaryColor.withOpacity(0.25),
      elevation: 1,
      pressElevation: 2.5,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      hintStyle: GoogleFonts.poppins(
        fontSize: 14.sp,
        color: Colors.grey.shade500,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 1.6.h, horizontal: 0),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentTextStyle: GoogleFonts.poppins(color: Colors.white, fontSize: 13.5.sp),
      elevation: 6,
      backgroundColor: textColor.withOpacity(0.95),
    ),
    dialogTheme: DialogTheme(
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
       titleTextStyle: GoogleFonts.poppins(
          fontSize: 17.sp,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
       backgroundColor: surfaceColor,
       elevation: 10,
    ),
     textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13.5.sp),
        foregroundColor: primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 1.2.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            foregroundColor: primaryColor,
            side: BorderSide(color: primaryColor.withOpacity(0.6), width: 1.8),
            textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13.sp),
            padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 0.5.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
    ),
     iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
            foregroundColor: textColor,
            iconSize: 19.sp,
            padding: EdgeInsets.all(1.8.w),
        ),
     ),
      dividerTheme: DividerThemeData(
        color: Colors.grey.shade300,
        thickness: 0.8,
        space: 3.5.h,
      )
  );
}


// --- Reusable Widgets ---

class NotificationIcon extends StatelessWidget {
  final VoidCallback? onTap;

  const NotificationIcon({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final Color iconColor = Theme.of(context).appBarTheme.iconTheme?.color ?? Colors.white;
    final Color badgeColor = Theme.of(context).hintColor;

    return IconButton(
       onPressed: onTap ?? () {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
                content: Text('Notifikasi akan segera hadir!'),
                backgroundColor: AppTheme.accentColor,
             ),
          );
       },
        icon: Stack(
         alignment: Alignment.center,
         clipBehavior: Clip.none,
         children: [
             Icon(Icons.notifications_outlined, color: iconColor, size: 21.sp),
             Positioned(
                right: -0.8.w,
                top: -0.8.w,
                child: Container(
                   padding: EdgeInsets.all(1.w),
                   decoration: BoxDecoration(
                      color: badgeColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.9), width: 0.5.w),
                      boxShadow: [
                        BoxShadow(
                          color: badgeColor.withOpacity(0.5),
                          blurRadius: 3,
                          offset: Offset(0,1)
                        )
                      ]
                   ),
                ),
             ),
          ],
       ),
       style: IconButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.18),
          shape: CircleBorder(),
          side: BorderSide(color: Colors.white.withOpacity(0.25), width: 1.2),
          padding: EdgeInsets.all(2.2.w),
       ),
    );
  }
}


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final List<Widget>? actions;
  final Widget? leading;
  final bool addPatternOverlay;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    this.actions,
    this.leading,
    this.addPatternOverlay = true,
  });

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: topPadding + 1.5.h, left: 5.w, right: 5.w, bottom: 2.5.h),
      decoration: BoxDecoration(
        gradient: AppTheme.appBarGradient,
        image: addPatternOverlay && AppTheme.patternImagePath.isNotEmpty
            ? DecorationImage(
                image: AssetImage(AppTheme.patternImagePath),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.05),
                  BlendMode.dstATop,
                ),
              )
            : null,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.25),
            blurRadius: 20,
            spreadRadius: -3,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                if (leading != null) Padding(
                   padding: EdgeInsets.only(right: 2.5.w),
                   child: leading,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.merriweather(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [Shadow(color: Colors.black38, blurRadius: 3, offset: Offset(0,1.5))]
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subtitle.isNotEmpty) SizedBox(height: 0.5.h),
                      if (subtitle.isNotEmpty) Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (actions != null && actions!.isNotEmpty) Row(
            mainAxisSize: MainAxisSize.min,
            children: actions!,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(14.h);
}


// --- Pages ---

class articlePage extends StatefulWidget {
  const articlePage({super.key});

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<articlePage> {
  String _selectedCategory = "Politik";

  void _updateCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: "Jogja Insight",
        subtitle: "Kabar Terkini dari Jantung Jawa",
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, size: 18.sp),
            onPressed: () => Navigator.of(context).pop(),
             style: IconButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.white.withOpacity(0.18),
                shape: CircleBorder(),
                padding: EdgeInsets.all(2.2.w),
                side: BorderSide(color: Colors.white.withOpacity(0.25), width: 1.2),
            ),
          ),
        actions: [
          NotificationIcon(),
          SizedBox(width: 1.w),
          IconButton(
             icon: Icon(Icons.tune_rounded, size: 20.sp),
             onPressed: () => _showArticleOptions(context),
             style: IconButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.white.withOpacity(0.18),
                shape: CircleBorder(),
                padding: EdgeInsets.all(2.2.w),
                 side: BorderSide(color: Colors.white.withOpacity(0.25), width: 1.2),
            ),
          ),
          SizedBox(width: 1.w),
        ],
      ),
      body: Container(
         color: AppTheme.backgroundColor,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight + (Device.screenType == ScreenType.tablet ? 8.h : 6.h)),
        child: ArticlePageBody(
           selectedCategory: _selectedCategory,
           onCategorySelected: _updateCategory,
         ),
      ),
    );
  }

  void _showArticleOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
          padding: EdgeInsets.only(top: 1.2.h, bottom: MediaQuery.of(context).viewInsets.bottom + 3.5.h),
          decoration: BoxDecoration(
             color: AppTheme.surfaceColor,
             borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
             boxShadow: [
                BoxShadow(
                   color: Colors.black.withOpacity(0.12),
                   blurRadius: 25,
                   spreadRadius: -3,
                )
             ]
          ),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 Container(
                    width: 18.w,
                    height: 0.7.h,
                    margin: EdgeInsets.symmetric(vertical: 2.h),
                    decoration: BoxDecoration(
                       color: Colors.grey.shade400,
                       borderRadius: BorderRadius.circular(10),
                    ),
                 ),
                 Padding(
                    padding: EdgeInsets.only(left: 6.w, right: 6.w, bottom: 2.5.h),
                    child: Text(
                       "Opsi Artikel",
                       style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.primaryColor, fontWeight: FontWeight.bold),
                    ),
                 ),
                 _buildMenuItem(
                    context: context,
                    icon: Icons.bookmark_add_outlined,
                    title: "Simpan Artikel",
                    color: AppTheme.primaryColor,
                    onTap: () { Navigator.pop(context); /* ... Action ... */ },
                 ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.ios_share_rounded,
                    title: "Bagikan",
                    color: Colors.blue.shade700,
                    onTap: () { Navigator.pop(context); /* ... Action ... */ },
                  ),
                 _buildMenuItem(
                    context: context,
                    icon: Icons.font_download_outlined,
                    title: "Ukuran Teks",
                    color: Colors.purple.shade600,
                    onTap: () { Navigator.pop(context); _showTextSizeDialog(context); },
                 ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.flag_outlined,
                    title: "Laporkan Artikel",
                    color: Colors.orange.shade900,
                     onTap: () { Navigator.pop(context); /* ... Action ... */ },
                  ),
              ],
            ),
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
       onTap: onTap,
       borderRadius: BorderRadius.circular(15),
       child: Padding(
         padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
         child: Row(
           children: [
             Icon(icon, color: color, size: 21.sp),
             SizedBox(width: 6.w),
             Text(
               title,
               style: Theme.of(context).textTheme.titleMedium?.copyWith(
                 color: color.withOpacity(0.9),
                 fontWeight: FontWeight.w500
               ),
             ),
           ],
         ),
       ),
    );
  }

  void _showTextSizeDialog(BuildContext context) {
    double currentTextSize = 15.sp;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text("Sesuaikan Ukuran Teks"),
          contentPadding: EdgeInsets.fromLTRB(6.w, 2.h, 6.w, 1.h),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               Text(
                "Gunakan slider untuk mengatur ukuran teks pratinjau di bawah ini agar nyaman dibaca.",
                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.subtleTextColor),
                 textAlign: TextAlign.center,
              ),
              SizedBox(height: 1.5.h),
              Slider(
                value: currentTextSize,
                min: 12.sp,
                max: 20.sp,
                divisions: 4,
                activeColor: AppTheme.primaryColor,
                inactiveColor: AppTheme.primaryColor.withOpacity(0.35),
                label: "${currentTextSize.toStringAsFixed(0)} pt",
                onChanged: (value) {
                  setDialogState(() {
                    currentTextSize = value;
                  });
                },
              ),
              SizedBox(height: 2.5.h),
              Container(
                 padding: EdgeInsets.all(3.5.w),
                 constraints: BoxConstraints(maxHeight: 18.h),
                 decoration: BoxDecoration(
                    color: AppTheme.backgroundColor.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300)
                 ),
                 child: SingleChildScrollView(
                    child: Text(
                      "Ini adalah contoh teks pratinjau. Anda dapat melihat bagaimana ukuran teks berubah saat slider digeser. Cobalah beberapa baris untuk menemukan ukuran yang paling pas untuk Anda.",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                         fontSize: currentTextSize,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                 ),
              ),
            ],
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Batal", style: TextStyle(color: AppTheme.subtleTextColor, fontWeight: FontWeight.w500)),
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: AppTheme.primaryColor.withOpacity(0.12)),
              onPressed: () {
                 Navigator.pop(context);
                 ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                       content: Text("Ukuran teks diperbarui!"),
                       backgroundColor: AppTheme.primaryColor,
                    ),
                 );
              },
              child: Text("Terapkan"),
            ),
          ],
        ),
      ),
    );
  }
}


class ArticlePageBody extends StatefulWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const ArticlePageBody({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
    });

  @override
  _ArticlePageBodyState createState() => _ArticlePageBodyState();
}

class _ArticlePageBodyState extends State<ArticlePageBody> with TickerProviderStateMixin {
  late AnimationController _relatedListAnimController;
  late List<Animation<Offset>> _relatedSlideAnimations;
  late AnimationController _featuredListAnimController;
  late List<Animation<double>> _featuredFadeAnimations;

   final List<Map<String, String>> featuredArticles = [
    { "id": "feat001", "image": "lib/icons/news1.jpeg", "category": "Politik", "title": "Wali Kota Usulkan Popok Kuda Andong Malioboro Demi Kebersihan", "date": "14 Apr 2025", "readTime": "5 min", "likes": "1.2k" },
    { "id": "feat002", "image": "lib/icons/news2.jpeg", "category": "Budaya", "title": "Gunungkidul Resmi Buka Agrowisata Petik Pepaya California Langsung dari Pohon", "date": "15 Mar 2025", "readTime": "4 min", "likes": "876" },
    { "id": "feat003", "image": "lib/icons/news3.jpeg", "category": "Teknologi", "title": "Tol Fungsional Tamanmartani-Klaten Dibuka Satu Arah untuk Arus Balik Lebaran", "date": "01 Feb 2025", "readTime": "7 min", "likes": "2.1k" },
    { "id": "feat004", "image": "lib/icons/news4.png", "category": "Lingkungan", "title": "Pemda DIY Intensifkan Pemasangan Rambu Bahaya di Sepanjang Pantai Selatan", "date": "09 Apr 2025", "readTime": "6 min", "likes": "950" }
  ];
   final List<Map<String, String>> relatedArticles = [
    { "id": "rel001", "image": "lib/icons/article1.jpeg", "date": "09 April 2025", "readTime": "5 min", "title": "Pemerintah DIY Pasang Rambu Tanda Bahaya di Kawasan Pantai Selatan", },
    { "id": "rel002", "image": "lib/icons/article2.jpeg", "date": "14 April 2025", "readTime": "3 min", "title": "Dishub Yogyakarta Tindak Tegas Kendaraan Parkir Sembarangan dengan Gembos Ban", },
    { "id": "rel003", "image": "lib/icons/article3.jpeg", "date": "12 April 2025", "readTime": "4 min", "title": "Mayat Pria Ditemukan Membusuk di Sebuah Rumah Kosong di Muja Muju", },
  ];

  @override
  void initState() {
    super.initState();
    _relatedListAnimController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 900));
    _relatedSlideAnimations = List.generate(
      relatedArticles.length,
      (index) => Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero)
          .animate(CurvedAnimation(
            parent: _relatedListAnimController,
            curve: Interval(index * 0.18, 1.0, curve: Curves.easeOutExpo),
      )),
    );

    _featuredListAnimController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
     final initialFeatured = featuredArticles
        .where((a) => a['category'] == widget.selectedCategory)
        .toList();
    _featuredFadeAnimations = List.generate(
       initialFeatured.length,
       (index) => Tween<double>(begin: 0.0, end: 1.0)
           .animate(CurvedAnimation(
             parent: _featuredListAnimController,
             curve: Interval(index * 0.22, 1.0, curve: Curves.easeInSine),
       )),
     );

     WidgetsBinding.instance.addPostFrameCallback((_) {
        if(mounted) {
          _relatedListAnimController.forward();
          _featuredListAnimController.forward();
        }
     });
  }

   void _updateFeaturedAnimations(List<Map<String, String>> currentFeatured) {
     if(!mounted) return;
     _featuredListAnimController.reset();
     _featuredFadeAnimations = List.generate(
       currentFeatured.length,
       (index) => Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
         parent: _featuredListAnimController,
         curve: Interval(index * 0.22, 1.0, curve: Curves.easeInSine),
       )),
     );
     _featuredListAnimController.forward();
   }

  @override
  void dispose() {
    _relatedListAnimController.dispose();
    _featuredListAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentFeaturedArticles = featuredArticles
        .where((article) => article['category'] == widget.selectedCategory)
        .toList();

    if (currentFeaturedArticles.length != _featuredFadeAnimations.length && mounted) {
       WidgetsBinding.instance.addPostFrameCallback((_) {
         if (mounted) _updateFeaturedAnimations(currentFeaturedArticles);
       });
    }

    return RefreshIndicator(
       onRefresh: () async {
          await Future.delayed(Duration(seconds: 1, milliseconds: 500));
          if(mounted) {
            setState(() {
              featuredArticles.shuffle();
              relatedArticles.shuffle();
              _updateFeaturedAnimations(featuredArticles.where((a) => a['category'] == widget.selectedCategory).toList());
              _relatedListAnimController.reset();
              _relatedListAnimController.forward();
            });
          }
       },
       color: AppTheme.primaryColor,
       backgroundColor: AppTheme.surfaceColor,
       strokeWidth: 2.5,
       displacement: 5.h,
       child: SingleChildScrollView(
         physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
         child: Padding(
           padding: EdgeInsets.symmetric(vertical: 2.5.h),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               _buildSearchBar(context),
               SizedBox(height: 3.5.h),

               _buildSectionTitle("Jelajahi Kategori", showSeeAll: false),
               SizedBox(height: 1.8.h),
               _buildCategoryTags(),
               SizedBox(height: 4.5.h),

               _buildSectionTitle("Sorotan ${widget.selectedCategory}"),
               SizedBox(height: 2.2.h),
               currentFeaturedArticles.isEmpty
                   ? _buildEmptyState("Tidak ada berita sorotan untuk kategori '${widget.selectedCategory}'.")
                   : _buildFeaturedArticlesAnimated(context, currentFeaturedArticles),
               SizedBox(height: 4.5.h),

               _buildSectionTitle("Mungkin Anda Suka"),
               SizedBox(height: 2.2.h),
                relatedArticles.isEmpty
                  ? _buildEmptyState("Tidak ada berita terkait saat ini.")
                  : _buildRelatedArticlesAnimated(),
               SizedBox(height: 4.h),
             ],
           ),
         ),
       ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.newspaper_rounded, size: 40.sp, color: AppTheme.subtleTextColor.withOpacity(0.7)),
          SizedBox(height: 2.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppTheme.subtleTextColor),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Container(
        padding: EdgeInsets.only(left: 4.5.w, right: 2.5.w),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(35),
          border: Border.all(color: Colors.grey.shade300, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 12,
              spreadRadius: -2,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.search_rounded, color: AppTheme.primaryColor, size: 21.sp),
            SizedBox(width: 3.w),
            Expanded(
              child: TextField(
                 controller: searchController,
                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textColor),
                 decoration: InputDecoration(
                    hintText: "Cari berita, topik, atau kata kunci...",
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                 ),
                 onChanged: (value) {
                    if(mounted) setState(() {});
                 },
              ),
            ),
             if (searchController.text.isNotEmpty)
                 IconButton(
                    icon: Icon(Icons.close_rounded, size: 19.sp, color: AppTheme.subtleTextColor),
                    onPressed: () {
                       searchController.clear();
                       if(mounted) setState(() {});
                    },
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                 ),
            SizedBox(width: 1.w),
            Container(
              width: 1,
              height: 3.h,
              color: Colors.grey.shade300,
              margin: EdgeInsets.symmetric(horizontal: 1.w),
            ),
            IconButton(
               icon: Icon(Icons.mic_none_rounded, color: AppTheme.primaryColor, size: 21.sp),
               onPressed: () { /* Aksi mic */ },
                padding: EdgeInsets.all(1.2.w),
                constraints: BoxConstraints(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, {bool showSeeAll = true}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          if (showSeeAll)
             OutlinedButton.icon(
                onPressed: () { /* Aksi ke halaman "See All" */ },
                label: Text("Semua"),
              )
        ],
      ),
    );
  }

  Widget _buildCategoryTags() {
    final categories = ["Politik", "Ekonomi", "Teknologi", "Budaya", "Lingkungan", "Wisata", "Olahraga", "Kuliner"];
    return SizedBox(
      height: 6.h,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = widget.selectedCategory == category;
          return Padding(
            padding: EdgeInsets.only(right: 3.w),
            child: ChoiceChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                 if(selected) {
                     widget.onCategorySelected(category);
                 }
              },
              selectedColor: AppTheme.primaryColor,
              backgroundColor: AppTheme.surfaceColor.withOpacity(0.9),
              labelStyle: Theme.of(context).chipTheme.labelStyle?.copyWith(
                color: isSelected ? Colors.white : AppTheme.primaryColor,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500
              ),
              shape: Theme.of(context).chipTheme.shape,
              side: isSelected ? BorderSide.none : BorderSide(color: AppTheme.primaryColor.withOpacity(0.3), width: 1),
              elevation: isSelected ? 3 : 1,
              pressElevation: 4,
            ),
          );
        },
      ),
    );
  }


  Widget _buildFeaturedArticlesAnimated(BuildContext context, List<Map<String, String>> articles) {
     if (articles.length != _featuredFadeAnimations.length && mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
            if(mounted) _updateFeaturedAnimations(articles);
        });
        return SizedBox(height: 36.h, child: Center(child: CircularProgressIndicator(color: AppTheme.primaryColor)));
     }
     if (_featuredFadeAnimations.isEmpty && articles.isNotEmpty && mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
           if(mounted) _updateFeaturedAnimations(articles);
        });
     }

     return SizedBox(
        height: 36.h,
        child: ListView.builder(
           padding: EdgeInsets.only(left: 6.w, right: 2.w),
           physics: const BouncingScrollPhysics(),
           scrollDirection: Axis.horizontal,
           itemCount: articles.length,
           itemBuilder: (context, index) {
               if (index >= _featuredFadeAnimations.length || index >= articles.length) {
                  return SizedBox.shrink();
               }
              final article = articles[index];
              return FadeTransition(
                 opacity: _featuredFadeAnimations[index],
                 child: Padding(
                    padding: EdgeInsets.only(right: 4.5.w),
                    child: FeaturedArticleCard(
                       heroTag: 'featured_${article["id"] ?? article["image"]!}',
                       image: article["image"]!,
                       category: article["category"]!,
                       title: article["title"]!,
                       date: article["date"]!,
                       readTime: article["readTime"]!,
                       likes: article["likes"]!,
                    ),
                 ),
              );
           },
        ),
     );
  }

  Widget _buildRelatedArticlesAnimated() {
     return Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
           children: List.generate(relatedArticles.length, (index) {
                if (index >= _relatedSlideAnimations.length || index >= relatedArticles.length) {
                  return SizedBox.shrink();
               }
               final article = relatedArticles[index];
               return SlideTransition(
                 position: _relatedSlideAnimations[index],
                 child: FadeTransition(
                     opacity: _relatedListAnimController.drive(CurveTween(curve: Curves.easeOutCubic)),
                     child: Padding(
                        padding: EdgeInsets.only(bottom: 2.2.h),
                        child: RelatedArticleListItem(
                           heroTag: 'related_${article["id"] ?? article["image"]!}',
                           image: article["image"]!,
                           date: article["date"]!,
                           readTime: article["readTime"]!,
                           title: article["title"]!,
                        ),
                     ),
                  ),
               );
            }),
        ),
     );
  }
}


class FeaturedArticleCard extends StatelessWidget {
  final String heroTag;
  final String image;
  final String category;
  final String title;
  final String date;
  final String readTime;
  final String likes;

  const FeaturedArticleCard({
    super.key,
    required this.heroTag,
    required this.image,
    required this.category,
    required this.title,
    required this.date,
    required this.readTime,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
       width: 72.w,
       child: Card(
         shape: Theme.of(context).cardTheme.shape,
         elevation: Theme.of(context).cardTheme.elevation,
         shadowColor: Theme.of(context).cardTheme.shadowColor,
         child: InkWell(
           borderRadius: BorderRadius.circular(20),
           onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 400),
                  child: ArticleDetailsPage(
                    heroTag: heroTag,
                    title: title,
                    image: image,
                    category: category,
                  ),
                ),
              );
            },
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               ClipRRect(
                 borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                 child: Stack(
                   alignment: Alignment.bottomLeft,
                   children: [
                     Hero(
                        tag: heroTag,
                        child: FadeInImage( // MODIFIED for local asset
                           placeholder: AssetImage(AppTheme.placeholderImagePath),
                           image: AssetImage(image), // 'image' is a local asset path
                           height: 18.h,
                           width: double.infinity,
                           fit: BoxFit.cover,
                           fadeInDuration: Duration(milliseconds: 350),
                           fadeOutDuration: Duration(milliseconds: 150),
                           imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                              AppTheme.placeholderImagePath,
                              height: 18.h, width: double.infinity, fit: BoxFit.cover),
                        ),
                     ),
                      Container(
                        height: 8.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black.withOpacity(0.0), Colors.black.withOpacity(0.7)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                     Positioned(
                       left: 3.w,
                       bottom: 1.5.h,
                       child: Container(
                         padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 0.8.h),
                         decoration: BoxDecoration(
                           color: AppTheme.primaryColor.withOpacity(0.85),
                           borderRadius: BorderRadius.circular(10),
                         ),
                         child: Text(
                           category,
                           style: Theme.of(context).textTheme.bodySmall?.copyWith(
                             color: Colors.white,
                             fontWeight: FontWeight.w600,
                             fontSize: 10.sp
                           ),
                         ),
                       ),
                     ),
                     Positioned(
                       top: 1.8.h,
                       right: 2.5.w,
                       child: Container(
                         padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.6.h),
                         decoration: BoxDecoration(
                           color: Colors.black.withOpacity(0.5),
                           borderRadius: BorderRadius.circular(8),
                         ),
                         child: Row(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             Icon(Icons.access_time_rounded, color: Colors.white, size: 12.sp),
                             SizedBox(width: 1.w),
                             Text(readTime, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white, fontSize: 10.sp)),
                           ],
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
               Expanded(
                 child: Padding(
                   padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 1.8.h),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                         title,
                         maxLines: 2,
                         overflow: TextOverflow.ellipsis,
                         style: Theme.of(context).textTheme.titleMedium?.copyWith(height: 1.4, fontWeight: FontWeight.w700),
                       ),
                       SizedBox(height: 1.h),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Text(date, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10.5.sp)),
                           Row(
                             children: [
                               Icon(
                                 Icons.favorite_border_rounded,
                                 size: 16.sp,
                                 color: AppTheme.subtleTextColor,
                               ),
                               SizedBox(width: 1.2.w),
                               Text(likes, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10.5.sp, color: AppTheme.subtleTextColor)),
                             ],
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
}

class RelatedArticleListItem extends StatelessWidget {
   final String heroTag;
   final String image;
   final String date;
   final String readTime;
   final String title;

  const RelatedArticleListItem({
    super.key,
    required this.heroTag,
    required this.image,
    required this.date,
    required this.readTime,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
     return Card(
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // FIXED: Explicitly defined
       elevation: Theme.of(context).cardTheme.elevation != null ? Theme.of(context).cardTheme.elevation! - 1 : 1.5, // FIXED: null check
       shadowColor: Theme.of(context).cardTheme.shadowColor,
       child: InkWell(
         borderRadius: BorderRadius.circular(16),
         onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 400),
                child: ArticleDetailsPage(
                  heroTag: heroTag,
                  title: title,
                  image: image,
                  category: "Info Terkait",
                ),
              ),
            );
         },
         child: Padding(
           padding: EdgeInsets.all(2.5.w),
           child: Row(
             children: [
               ClipRRect(
                 borderRadius: BorderRadius.circular(12),
                 child: Hero(
                    tag: heroTag,
                    child: FadeInImage( // MODIFIED for local asset
                       placeholder: AssetImage(AppTheme.placeholderImagePath),
                       image: AssetImage(image), // 'image' is a local asset path
                       width: 30.w,
                       height: 13.h,
                       fit: BoxFit.cover,
                        fadeInDuration: Duration(milliseconds: 350),
                        fadeOutDuration: Duration(milliseconds: 150),
                       imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                          AppTheme.placeholderImagePath,
                          width: 30.w, height: 13.h, fit: BoxFit.cover),
                    ),
                 ),
               ),
               SizedBox(width: 3.5.w),
               Expanded(
                 child: SizedBox(
                   height: 13.h,
                   child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.8.h),
                      child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                            Text(
                               title,
                               maxLines: 3,
                               overflow: TextOverflow.ellipsis,
                               style: Theme.of(context).textTheme.titleMedium?.copyWith(height: 1.35, fontSize: 14.sp),
                            ),
                            Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                  Text(date, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10.sp)),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 1.8.w, vertical: 0.5.h),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6)
                                    ),
                                    child: Row(
                                       mainAxisSize: MainAxisSize.min,
                                       children: [
                                          Icon(
                                             Icons.access_time_filled_rounded,
                                             size: 12.sp,
                                             color: AppTheme.primaryColor,
                                          ),
                                          SizedBox(width: 1.w),
                                          Text(
                                             readTime,
                                             style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                color: AppTheme.primaryColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10.sp
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
                 ),
               ),
             ],
           ),
         ),
       ),
     );
  }
}

class ArticleDetailsPage extends StatelessWidget {
  final String heroTag;
  final String title;
  final String image; // This is expected to be a local asset path string
  final String category;

  const ArticleDetailsPage({
    super.key,
    required this.heroTag,
    required this.title,
    required this.image,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final String dummyContent = "Yogyakarta, kota yang kaya akan budaya dan sejarah, kembali menunjukkan pesonanya. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\nSeiring perkembangan zaman, Yogyakarta terus berbenah. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nuansa tradisional berpadu harmonis dengan sentuhan modern, menciptakan daya tarik unik bagi siapa saja yang mengunjunginya.";
    final List<String> keyPoints = [
      "Analisis mendalam mengenai dampak peristiwa terhadap masyarakat.",
      "Wawancara eksklusif dengan tokoh kunci dan saksi mata.",
      "Signifikansi budaya dan historis dari kejadian tersebut.",
      "Perkembangan terkini dan langkah-langkah tindak lanjut dari pemerintah."
    ];
    final String author = "Tim Jurnalis JogjaInsight";
    final String publishedDate = "15 Mei 2025, 10:30 WIB";


    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
         physics: BouncingScrollPhysics(),
         slivers: <Widget>[
             SliverAppBar(
                expandedHeight: 40.h,
                pinned: true,
                stretch: true,
                elevation: 2,
                backgroundColor: AppTheme.primaryColor,
                leading: IconButton(
                   icon: Icon(Icons.arrow_back_ios_new_rounded, size: 19.sp, color: Colors.white),
                   onPressed: () => Navigator.of(context).pop(),
                   style: IconButton.styleFrom(
                      backgroundColor: Colors.black.withOpacity(0.2),
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(1.5.w)
                   ),
                ),
                 actions: [
                    IconButton(
                       icon: Icon(Icons.bookmark_border_rounded, size: 21.sp, color: Colors.white),
                       onPressed: (){ /* Save action */ },
                        style: IconButton.styleFrom(backgroundColor: Colors.black.withOpacity(0.2), shape: CircleBorder(), padding: EdgeInsets.all(1.5.w)),
                    ),
                    IconButton(
                       icon: Icon(Icons.share_rounded, size: 20.sp, color: Colors.white),
                       onPressed: (){ /* Share action */ },
                        style: IconButton.styleFrom(backgroundColor: Colors.black.withOpacity(0.2), shape: CircleBorder(), padding: EdgeInsets.all(1.5.w)),
                    ),
                    SizedBox(width: 2.w)
                 ],
                flexibleSpace: FlexibleSpaceBar(
                   stretchModes: [StretchMode.zoomBackground, StretchMode.blurBackground, StretchMode.fadeTitle],
                   centerTitle: true,
                   titlePadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
                   title: Text(
                      category.toUpperCase(),
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        shadows: [Shadow(blurRadius: 5, color: Colors.black.withOpacity(0.7))]
                      )
                    ),
                   background: Hero(
                      tag: heroTag,
                      child: Stack(
                         fit: StackFit.expand,
                         children: [
                             FadeInImage( // MODIFIED for local asset
                                placeholder: AssetImage(AppTheme.placeholderImagePath),
                                image: AssetImage(image), // 'image' is a local asset path
                                fit: BoxFit.cover,
                                fadeInDuration: Duration(milliseconds: 350),
                                fadeOutDuration: Duration(milliseconds: 150),
                                imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                                  AppTheme.placeholderImagePath, fit: BoxFit.cover),
                             ),
                             Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.6),
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.7)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [0.0, 0.5, 1.0]
                                  )
                                ),
                             )
                         ],
                      ),
                   ),
                ),
             ),

             SliverToBoxAdapter(
               child: Material(
                  elevation: 1,
                  color: AppTheme.surfaceColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(Device.screenType == ScreenType.tablet ? 0 : 25)),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(6.w, 3.5.h, 6.w, 6.h),
                    child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           title,
                           style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: AppTheme.primaryColor),
                         ),
                         SizedBox(height: 2.h),
                         Row(
                            children: [
                               CircleAvatar(
                                  radius: 15.sp,
                                  backgroundColor: AppTheme.accentColor.withOpacity(0.2),
                                  child: Icon(Icons.person_outline_rounded, size: 16.sp, color: AppTheme.accentColor),
                               ),
                               SizedBox(width: 2.5.w),
                               Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Text(author, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                                     Text(publishedDate, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.subtleTextColor)),
                                  ],
                               )
                            ],
                         ),
                         Divider(thickness: 1, height: 4.h),

                         Text(
                           dummyContent,
                           style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppTheme.textColor.withOpacity(0.9),
                              height: 1.75,
                           ),
                           textAlign: TextAlign.justify,
                         ),
                         SizedBox(height: 3.5.h),

                         Text("Poin Kunci", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                         SizedBox(height: 1.8.h),
                         ...keyPoints.map((point) => _buildBulletPoint(context, point)),
                         SizedBox(height: 5.h),

                          Text("Diskusi Artikel", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                          SizedBox(height: 1.5.h),
                          _buildCommentSectionPlaceholder(context),


                       ],
                     ),
                  ),
               ),
             ),
         ],
      ),
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
              padding: EdgeInsets.only(top: 0.7.h, right: 3.5.w),
              child: Icon(
                 Icons.check_circle_outline_rounded,
                 size: 15.sp,
                 color: AppTheme.accentColor,
              ),
           ),
           Expanded(
             child: Text(
               text,
               style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.6, color: AppTheme.textColor.withOpacity(0.85)),
             ),
           ),
        ],
      ),
    );
  }

  Widget _buildCommentSectionPlaceholder(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300)
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Tambahkan komentar Anda...",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    filled: true,
                    fillColor: AppTheme.surfaceColor,
                    contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h)
                  ),
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              SizedBox(width: 2.w),
              IconButton(
                icon: Icon(Icons.send_rounded, color: AppTheme.primaryColor),
                onPressed: (){},
                style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor.withOpacity(0.1)),
              )
            ],
          ),
          SizedBox(height: 2.h),
          Text("Fitur komentar akan segera hadir!", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.subtleTextColor)),
        ],
      ),
    );
  }
}


void main() {
  // --- PENTING UNTUK ASSETS ---
  // Pastikan path gambar placeholder dan semua gambar artikel (news1.jpeg, article1.jpeg, dll.)
  // ada di folder assets Anda (misalnya, 'lib/icons/') DAN
  // telah dideklarasikan di file pubspec.yaml Anda seperti contoh di bawah:
  /*
  flutter:
    uses-material-design: true
    assets:
      - lib/icons/ # Ini akan menyertakan semua file di dalam folder lib/icons/
      # Atau daftarkan satu per satu jika tidak semua file dalam folder ingin disertakan
      # - lib/icons/news_placeholder.png
      # - lib/icons/batik_pattern_subtle.png
      # - lib/icons/news1.jpeg
      # - lib/icons/news2.jpeg
      # - lib/icons/news3.jpeg
      # - lib/icons/news4.jpeg
      # - lib/icons/article1.jpeg
      # - lib/icons/article2.jpeg
      # - lib/icons/article3.jpeg

  Setelah mengubah pubspec.yaml, HENTIKAN dan JALANKAN ULANG aplikasi Anda.
  */

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'Jogja Insight',
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          home: articlePage(),
        );
      },
    );
  }
}