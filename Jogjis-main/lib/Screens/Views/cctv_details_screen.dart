import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:JogjaIstimewa/Screens/Views/appointment.dart'; // Pastikan path ini benar
// import 'package:JogjaIstimewa/Screens/Views/find_cctv.dart'; // Tidak digunakan di file ini
import 'package:JogjaIstimewa/Screens/Widgets/date_select.dart'; // Ganti nama widget jika perlu (misal: DateSelector)
import 'package:JogjaIstimewa/Screens/Widgets/cctvList.dart'; // Ganti nama widget jika perlu (misal: CctvListItem)
// import 'package:JogjaIstimewa/Screens/Widgets/list_cctv1.dart'; // Tidak digunakan di file ini
import 'package:JogjaIstimewa/Screens/Widgets/time_select.dart'; // Ganti nama widget jika perlu (misal: TimeSelector)
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// --- Constants for Styles and Dimensions ---
class AppStyles {
  static const LinearGradient appBarGradient = LinearGradient(
    colors: [Color(0xFFFF0000), Color(0xFF4F0505)], // Warna Merah ke Merah Tua
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Color primaryRed = Color(0xFF890000); // Merah Tua Primer
  static const Color primaryRedLight = Color(0xFFA62626);
  static const Color accentRed = Color(0xFFFF0101);
  static const Color lightGrey = Color(0xFFFAFAFA); // Background lebih terang
  static const Color darkGreyText = Color(0xFF424242); // Teks abu-abu gelap
  static const Color mediumGreyText = Color(0xFF757575); // Teks abu-abu sedang

  static final BorderRadius cardBorderRadius = BorderRadius.circular(15.0);
  static final BorderRadius buttonBorderRadius = BorderRadius.circular(25.0);
  static final BorderRadius circleButtonRadius = BorderRadius.circular(12.0);

  static final double horizontalPadding = 5.w;
  static final double verticalPaddingSmall = 1.h;
  static final double verticalPaddingMedium = 2.h;
  static final double verticalPaddingLarge = 3.h;

  static TextStyle titleStyle = GoogleFonts.inter(
    fontSize: 22.sp,
    fontWeight: FontWeight.w800,
    color: Colors.white,
  );

  static TextStyle subtitleStyle = GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: Colors.white70,
  );

  static TextStyle sectionTitleStyle = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: primaryRed,
  );

  static TextStyle bodyTextStyle = GoogleFonts.poppins(
    fontSize: 14.sp,
    color: darkGreyText,
    height: 1.5, // Line height for better readability
  );

  static TextStyle linkTextStyle = GoogleFonts.poppins(
    fontSize: 14.sp,
    color: primaryRed,
    fontWeight: FontWeight.w500,
  );

  static TextStyle buttonTextStyle = GoogleFonts.poppins(
    fontSize: 16.sp,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );

  static final BoxShadow defaultShadow = BoxShadow(
    color: Colors.black.withOpacity(0.15),
    blurRadius: 10,
    offset: const Offset(0, 4),
  );

   static final BoxShadow subtleShadow = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 8,
    offset: const Offset(0, 2),
  );
}

// --- Screen Widget ---
// Menggunakan UpperCamelCase untuk nama class sesuai konvensi Dart
class cctv_details_screen extends StatefulWidget {
  const cctv_details_screen({super.key});

  // Jika detail CCTV dinamis, tambahkan parameter di sini
  // final CctvData cctvData;
  // const CctvDetailsScreen({Key? key, required this.cctvData}) : super(key: key);
  @override
  // Menggunakan _NamaClassState sesuai konvensi
  _CctvDetailsScreenState createState() => _CctvDetailsScreenState();
}

class _CctvDetailsScreenState extends State<cctv_details_screen> {
  bool _showExtendedText = false;
  int _selectedDateIndex = 0; // Untuk melacak tanggal yang dipilih
  String? _selectedTime; // Untuk melacak waktu yang dipilih

  // Data dummy untuk tanggal dan waktu (bisa diganti dengan data dinamis)
  final List<Map<String, String>> _dates = [
    {"date": "21", "day": "Mon"},
    {"date": "22", "day": "Tue"},
    {"date": "23", "day": "Wed"},
    {"date": "24", "day": "Thu"},
    {"date": "25", "day": "Fri"},
    {"date": "26", "day": "Sat"},
    {"date": "27", "day": "Sun"},
    {"date": "28", "day": "Mon"},
  ];

  final List<List<String>> _timeSlots = [
    ["09:00 AM", "01:00 PM", "04:00 PM", "07:00 PM"],
    ["10:00 AM", "02:00 PM", "05:00 PM", "09:00 PM"], // Diubah agar tidak duplikat 07:00 PM
    ["11:00 AM", "03:00 PM", "08:00 PM", "10:00 PM"],
  ];


  void _toggleTextVisibility() {
    setState(() {
      _showExtendedText = !_showExtendedText;
    });
  }

  // --- Build Methods for Sections ---

  // Membangun AppBar yang stylish
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(16.h), // Tinggi AppBar
      child: Container(
        padding: EdgeInsets.only(top: 6.h, left: AppStyles.horizontalPadding, right: AppStyles.horizontalPadding, bottom: AppStyles.verticalPaddingMedium),
        decoration: BoxDecoration(
          gradient: AppStyles.appBarGradient,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          boxShadow: [AppStyles.defaultShadow],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Back Button dan Title Group
            Row(
              children: [
                _buildAppBarButton(
                  context: context,
                  icon: Icons.arrow_back_ios_new,
                  onTap: () => Navigator.of(context).pop(),
                ),
                SizedBox(width: 3.w),
                // Gunakan data dinamis jika ada (misal: widget.cctvData.name)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("CCTV Details", style: AppStyles.titleStyle),
                    Text("Malioboro Street", style: AppStyles.subtitleStyle),
                  ],
                ),
              ],
            ),
            // Filter Button
            _buildAppBarButton(
              context: context,
              icon: Icons.filter_list,
              tooltip: 'Filter Options', // Tambahkan tooltip untuk aksesibilitas
              onTap: () {
                // Tampilkan dialog filter atau navigasi ke halaman filter
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Filter Options Coming Soon!',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                    backgroundColor: AppStyles.accentRed,
                    behavior: SnackBarBehavior.floating, // Lebih modern
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper untuk membuat tombol AppBar (Back & Filter)
  Widget _buildAppBarButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback onTap,
    String? tooltip,
  }) {
    return InkWell( // Gunakan InkWell untuk efek ripple
      onTap: onTap,
      borderRadius: BorderRadius.circular(30), // Sesuaikan radius ripple
      child: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
          boxShadow: [AppStyles.subtleShadow],
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }


  // Membangun kartu informasi CCTV
  Widget _buildCctvInfoCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppStyles.horizontalPadding),
      child: Card(
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.2), // Warna shadow
        shape: RoundedRectangleBorder(borderRadius: AppStyles.cardBorderRadius),
        child: cctvlist( // Asumsi 'cctvlist' adalah nama widget yang benar dari import
          distance: "800m away",
          // Sebaiknya gunakan AssetImage untuk aset lokal
          image: "lib/icons/jogjaporvcctv2.png",
          maintext: "Jl. Malioboro",
          numRating: "10.32", // Pertimbangkan tipe data yang sesuai (misal: double)
          subtext: "Malioboro Street",
        ),
      ),
    );
  }

  // Membangun bagian "About" yang bisa expand/collapse
  Widget _buildAboutSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppStyles.horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("About", style: AppStyles.sectionTitleStyle),
          SizedBox(height: AppStyles.verticalPaddingSmall),
          InkWell( // Membuat seluruh area teks bisa diklik
            onTap: _toggleTextVisibility,
            child: AnimatedCrossFade(
              firstChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "📹 CCTV Feed - 🔴 Live Monitoring - 🚦 Pemantauan Lalu Lintas",
                    style: AppStyles.bodyTextStyle.copyWith(color: AppStyles.mediumGreyText),
                     maxLines: 2, // Batasi baris awal
                     overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppStyles.verticalPaddingSmall / 2),
                  Text("Read more", style: AppStyles.linkTextStyle),
                ],
              ),
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "🌆 Live Now\n\nThis CCTV provides real-time monitoring of Malioboro Street, capturing live traffic conditions and street activities. Stay updated with seamless live feeds.",
                    style: AppStyles.bodyTextStyle,
                  ),
                  SizedBox(height: AppStyles.verticalPaddingSmall / 2),
                  Text("Read less", style: AppStyles.linkTextStyle),
                ],
              ),
              crossFadeState: _showExtendedText
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
              layoutBuilder: (topChild, topKey, bottomChild, bottomKey) {
                 // Mencegah overflow saat animasi
                return Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topLeft,
                  children: [
                    Positioned(key: bottomKey, child: bottomChild),
                    Positioned(key: topKey, child: topChild),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Membangun bagian pemilihan tanggal
  Widget _buildDateSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppStyles.horizontalPadding),
          child: Text("Select Date", style: AppStyles.sectionTitleStyle),
        ),
        SizedBox(height: AppStyles.verticalPaddingSmall),
        SizedBox( // Menggunakan SizedBox untuk memberi tinggi eksplisit pada ListView
          height: 12.h,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: AppStyles.horizontalPadding),
            physics: const BouncingScrollPhysics(), // Efek bounce yang bagus
            scrollDirection: Axis.horizontal,
            itemCount: _dates.length,
            itemBuilder: (context, index) {
              final dateData = _dates[index];
              final bool isSelected = index == _selectedDateIndex;
              return Padding(
                 padding: EdgeInsets.only(right: 2.w), // Jarak antar item tanggal
                 child: GestureDetector(
                   onTap: () {
                     setState(() {
                       _selectedDateIndex = index;
                     });
                   },
                   // Gunakan widget DateSelector yang diimpor
                   // Sesuaikan properti berdasarkan definisi widget DateSelector Anda
                   child: date_Select( // Ganti ke DateSelector jika nama widget diubah
                     date: dateData['date']!,
                     maintext: dateData['day']!,
                   ),
                 ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Membangun bagian pemilihan waktu
  Widget _buildTimeSelection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppStyles.horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text("Select Time", style: AppStyles.sectionTitleStyle),
           SizedBox(height: AppStyles.verticalPaddingMedium),
           Row(
             crossAxisAlignment: CrossAxisAlignment.start, // Agar column align dari atas
             children: List.generate(_timeSlots.length, (colIndex) {
               return Expanded(
                 child: Padding(
                   padding: EdgeInsets.symmetric(horizontal: 1.w), // Jarak antar kolom
                   child: Column(
                     children: List.generate(_timeSlots[colIndex].length, (rowIndex) {
                        final time = _timeSlots[colIndex][rowIndex];
                        final bool isSelected = time == _selectedTime;
                        return Padding(
                          padding: EdgeInsets.only(bottom: AppStyles.verticalPaddingSmall),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedTime = time;
                              });
                            },
                            // Gunakan widget TimeSelector yang diimpor
                            // Sesuaikan properti berdasarkan definisi widget TimeSelector Anda
                            child: time_select( // Ganti ke TimeSelector jika nama widget diubah
                              mainText: time,
                            ),
                          ),
                        );
                     }),
                   ),
                 ),
               );
             }),
           ),
        ],
      ),
    );
  }


  // Membangun Bottom Action Bar
  Widget _buildBottomActionBar(BuildContext context) {
    return Container(
      height: 10.h, // Tinggi Bottom Bar
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow lebih halus
            blurRadius: 8,
            offset: const Offset(0, -2), // Shadow hanya di atas
          ),
        ],
        // Optional: Tambahkan border atas jika diinginkan
        // border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppStyles.horizontalPadding, vertical: AppStyles.verticalPaddingSmall),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Tombol Chat (Placeholder)
            _buildActionButton(
              context: context,
              icon: Icons.chat_bubble_outline,
              backgroundColor: Colors.teal.shade50,
              iconColor: AppStyles.primaryRed,
              tooltip: 'Chat Support',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Chat feature coming soon!")),
                );
              },
            ),
            SizedBox(width: 4.w), // Jarak antara tombol
            // Tombol Aksi Utama ("Unduh Tayangan")
            Expanded( // Agar tombol ini mengisi sisa ruang
              child: _buildPrimaryActionButton(
                context: context,
                text: "Unduh Tayangan",
                onTap: () {
                  // Navigasi ke halaman Appointment (atau halaman unduh sesungguhnya)
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const appointment(), // Pastikan 'appointment' adalah Widget
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

  // Helper untuk tombol aksi kecil (seperti chat)
  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    required VoidCallback onTap,
    String? tooltip,
  }) {
    return Tooltip( // Tooltip untuk aksesibilitas
      message: tooltip ?? '',
      child: Material( // Material untuk efek InkWell
        color: backgroundColor,
        borderRadius: AppStyles.circleButtonRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppStyles.circleButtonRadius,
          child: Container(
            height: 6.h, // Sesuaikan ukuran
            width: 12.w,  // Sesuaikan ukuran
            alignment: Alignment.center,
            child: Icon(icon, color: iconColor, size: 24),
          ),
        ),
      ),
    );
  }

   // Helper untuk tombol aksi utama (gradient)
   Widget _buildPrimaryActionButton({
     required BuildContext context,
     required String text,
     required VoidCallback onTap,
   }) {
      return Container(
         height: 6.h, // Tinggi konsisten
         decoration: BoxDecoration(
           gradient: const LinearGradient(
              colors: [AppStyles.primaryRed, AppStyles.primaryRedLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
           ),
           borderRadius: AppStyles.buttonBorderRadius,
           boxShadow: [
             BoxShadow(
               color: AppStyles.primaryRed.withOpacity(0.4), // Shadow sesuai warna tombol
               blurRadius: 8,
               offset: const Offset(0, 4),
             ),
           ],
         ),
         child: Material( // Material untuk InkWell di atas gradient
            color: Colors.transparent,
            child: InkWell(
               onTap: onTap,
               borderRadius: AppStyles.buttonBorderRadius,
               child: Center(
                 child: Text(text, style: AppStyles.buttonTextStyle),
               ),
            ),
         ),
      );
   }


  // --- Main Build Method ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.lightGrey, // Background lebih cerah
      appBar: _buildAppBar(context),
      body: Stack(
        // Stack diperlukan untuk menempatkan Bottom Bar di atas konten yang bisa di-scroll
        children: [
          // Konten Utama yang Bisa di-Scroll
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppStyles.verticalPaddingMedium),
                _buildCctvInfoCard(),
                SizedBox(height: AppStyles.verticalPaddingLarge),
                _buildAboutSection(),
                SizedBox(height: AppStyles.verticalPaddingLarge),
                _buildDateSelection(),
                SizedBox(height: AppStyles.verticalPaddingLarge),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppStyles.horizontalPadding),
                  child: Divider(color: Colors.grey.shade300, thickness: 1),
                ),
                SizedBox(height: AppStyles.verticalPaddingMedium),
                _buildTimeSelection(),
                SizedBox(height: 15.h), // Ruang kosong di bawah untuk Bottom Bar
              ],
            ),
          ),
          // Bottom Action Bar diposisikan di bawah
          Positioned(
             left: 0,
             right: 0,
             bottom: 0,
             child: _buildBottomActionBar(context)
          ),
        ],
      ),
    );
  }
}

// --- Placeholder/Dummy Widgets (jika belum ada) ---
// Jika widget date_Select, time_select, cctvlist sudah ada di file lain,
// hapus definisi di bawah ini. Jika belum, ini adalah contoh sederhananya.

// class date_Select extends StatelessWidget { // Ganti nama jadi DateSelector
//   final String date;
//   final String maintext;
//   final bool isSelected;
//   const date_Select({Key? key, required this.date, required this.maintext, this.isSelected = false}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 4.w),
//       decoration: BoxDecoration(
//         color: isSelected ? AppStyles.primaryRed : Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: isSelected ? AppStyles.primaryRed : Colors.grey.shade300),
//         boxShadow: isSelected ? [AppStyles.subtleShadow] : [],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(date, style: GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : AppStyles.darkGreyText)),
//           SizedBox(height: 0.5.h),
//           Text(maintext, style: GoogleFonts.poppins(fontSize: 12.sp, color: isSelected ? Colors.white70 : AppStyles.mediumGreyText)),
//         ],
//       ),
//     );
//   }
// }

// class time_select extends StatelessWidget { // Ganti nama jadi TimeSelector
//   final String mainText;
//   final bool isSelected;
//   const time_select({Key? key, required this.mainText, this.isSelected = false}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
//       alignment: Alignment.center,
//        width: double.infinity, // Agar memenuhi kolom
//       decoration: BoxDecoration(
//         color: isSelected ? AppStyles.primaryRed : Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: isSelected ? AppStyles.primaryRed : Colors.grey.shade300),
//          boxShadow: isSelected ? [AppStyles.subtleShadow] : [],
//       ),
//       child: Text(
//         mainText,
//         style: GoogleFonts.poppins(fontSize: 13.sp, fontWeight: FontWeight.w500, color: isSelected ? Colors.white : AppStyles.darkGreyText),
//          textAlign: TextAlign.center,
//       ),
//     );
//   }
// }

// class cctvlist extends StatelessWidget { // Ganti nama jadi CctvListItem
//   final String image, maintext, subtext, distance, numRating;
//   const cctvlist({Key? key, required this.image, required this.maintext, required this.subtext, required this.distance, required this.numRating}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Implementasi widget cctvlist Anda di sini
//     return ListTile( // Contoh sederhana menggunakan ListTile
//        leading: Image.asset(image, width: 15.w, height: 15.w, fit: BoxFit.cover), // Gunakan Image.asset
//        title: Text(maintext, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
//        subtitle: Text("$subtext\n$distance"),
//        trailing: Text(numRating), // Mungkin ingin format rating lebih baik
//        isThreeLine: true,
//     );
//   }
// }