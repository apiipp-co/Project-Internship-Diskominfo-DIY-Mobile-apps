import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For SystemChrome
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// --- Constants for Colors and Styles (Lebih Rapi) ---
const kPrimaryColor = Color.fromARGB(255, 157, 42, 42); // Teal utama
const kAppBarGradientStart = Color.fromARGB(255, 83, 38, 38); // Warna gradient baru (lebih gelap)
const kAppBarGradientEnd = Color(0xFF2A9D8F);   // Warna gradient baru
const kBackgroundColor = Color(0xFFF5F5F5);
const kCardBackgroundColor = Colors.white;
const kConfirmedColor = Colors.green;
const kCancelledColor = Colors.red;
const kTextColorPrimary = Colors.black87;
const kTextColorSecondary = Colors.black54;
const kIconColor = kPrimaryColor;

final kTitleTextStyle = GoogleFonts.poppins(
  fontSize: 18.sp, // Menggunakan sp untuk font responsif
  fontWeight: FontWeight.w600,
  color: kTextColorPrimary,
);

final kSubtitleTextStyle = GoogleFonts.poppins(
  fontSize: 15.sp,
  color: kTextColorSecondary,
);

final kBodyTextStyle = GoogleFonts.poppins(
  fontSize: 16.sp,
  fontWeight: FontWeight.w600,
  color: kTextColorPrimary,
);

// --- Main Widget ---
class ScheduleDetailScreen extends StatelessWidget {
  final String mainText;
  final String subText;
  final String date;
  final String time;
  final String confirmation;
  final String image;

  const ScheduleDetailScreen({
    super.key, // Gunakan super.key
    required this.mainText,
    required this.subText,
    required this.date,
    required this.time,
    required this.confirmation,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    // Set status bar style saat build
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparan agar gradient terlihat
      statusBarIconBrightness: Brightness.light, // Icon putih
    ));

    return Scaffold(
      // Tidak perlu AnnotatedRegion jika di set di build atau main.dart
      backgroundColor: kBackgroundColor,
      appBar: _buildAppBar(context), // AppBar dipisah ke method sendiri
      body: SingleChildScrollView( // Hapus Expanded yang tidak perlu
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(), // Header dipisah
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h), // Padding konsisten
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildScheduleInfo(), // Info Jadwal dipisah
                  SizedBox(height: 3.h),
                  _buildLocationInfo(), // Info Lokasi dipisah
                  SizedBox(height: 4.h),
                  _buildActionButtons(context), // Tombol Aksi dipisah
                  SizedBox(height: 3.h), // Padding bawah
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- AppBar ---
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    // Ambil bagian terakhir dari subText sebagai subtitle AppBar (asumsi format 'Lokasi - Detail')
    String appBarSubtitle = subText.contains(' - ') ? subText.split(' - ').last : subText;

    return PreferredSize(
      preferredSize: Size.fromHeight(12.h), // Ukuran AppBar responsif
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 1.h, left: 4.w, right: 4.w, bottom: 2.h), // Padding aman untuk status bar
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors:[Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 79, 5, 5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow lebih halus
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          // borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)), // Optional: Rounded bottom corners
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Tombol Back
            InkWell( // Lebih baik dari GestureDetector untuk feedback visual
              onTap: () => Navigator.of(context).pop(),
              borderRadius: BorderRadius.circular(25),
              child: Container(
                padding: const EdgeInsets.all(8), // Padding dalam icon
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2), // Transparansi sedikit
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 20, // Ukuran icon tetap
                ),
              ),
            ),
            SizedBox(width: 3.w),
            // Judul dan Subjudul
            Expanded( // Agar teks tidak overflow
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Detail Jadwal", // Judul lebih deskriptif
                    style: GoogleFonts.inter(
                      fontSize: 18.sp, // Ukuran font responsif
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis, // Handle teks panjang
                  ),
                  if (appBarSubtitle.isNotEmpty) // Tampilkan jika ada
                    Text(
                      appBarSubtitle,
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white70,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            SizedBox(width: 3.w),
            // Tombol More Options
            InkWell(
              onTap: () {
                // TODO: Implement action for more options (e.g., show menu)
                print("More options tapped!");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Menu belum tersedia"), duration: Duration(seconds: 1)),
                );
              },
              borderRadius: BorderRadius.circular(25),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 24, // Ukuran icon tetap
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Header Section ---
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      color: kCardBackgroundColor, // Warna background putih agar kontras
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Column(
        children: [
          // Gambar Profil/CCTV
          Container(
            width: 30.w, // Ukuran responsif
            height: 30.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade200, // Placeholder color
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15,
                  spreadRadius: 2,
                  offset: const Offset(0, 5),
                ),
              ],
              border: Border.all(color: Colors.white, width: 4), // Border putih
            ),
            child: ClipOval(
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                // Error handling jika gambar tidak ditemukan
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error_outline, color: kTextColorSecondary, size: 40);
                },
              ),
            ),
          ),
          SizedBox(height: 2.h),
          // Teks Utama
          Text(
            mainText,
            style: GoogleFonts.poppins(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: kTextColorPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 1.h),
          // Teks Sub
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w), // Batasi lebar agar tidak terlalu panjang
            child: Text(
              subText,
              style: kSubtitleTextStyle.copyWith(fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 1.5.h),
          // Status Konfirmasi (Chip)
          Chip(
             label: Text(
              confirmation,
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: confirmation.toLowerCase() == 'confirmed' ? kConfirmedColor : kTextColorSecondary, // Warna sesuai status
              ),
            ),
            backgroundColor: (confirmation.toLowerCase() == 'confirmed' ? kConfirmedColor : Colors.grey).withOpacity(0.15),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.transparent) // Hapus border default chip jika ada
            ),
          ),
        ],
      ),
    );
  }

  // --- Schedule Info Section ---
  Widget _buildScheduleInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Informasi Jadwal", style: kTitleTextStyle),
        SizedBox(height: 2.h),
        Card( // Gunakan Card untuk shadow dan border radius
          elevation: 2, // Shadow halus
          shadowColor: Colors.black.withOpacity(0.1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: kCardBackgroundColor,
          child: Padding(
            padding: EdgeInsets.all(4.w), // Padding responsif
            child: Row(
              children: [
                _buildDateTimeCard(
                    icon: Icons.calendar_today_outlined, title: "Tanggal", value: date),
                SizedBox(width: 4.w),
                _buildDateTimeCard(
                    icon: Icons.access_time_outlined, title: "Waktu", value: time),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Helper untuk card Tanggal & Waktu
  Widget _buildDateTimeCard({required IconData icon, required String title, required String value}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
        decoration: BoxDecoration(
          // color: kPrimaryColor.withOpacity(0.05), // Background lebih subtle
          // border: Border.all(color: kPrimaryColor.withOpacity(0.2)), // Optional border
          // borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon, color: kIconColor, size: 28), // Ukuran icon tetap
            SizedBox(height: 1.h),
            Text(title, style: kSubtitleTextStyle.copyWith(fontSize: 13.sp)),
            SizedBox(height: 0.5.h),
            Text(
              value,
              style: kBodyTextStyle.copyWith(fontSize: 15.sp),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // --- Location Info Section ---
  Widget _buildLocationInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Lokasi", style: kTitleTextStyle),
        SizedBox(height: 2.h),
        Card( // Gunakan Card
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: kCardBackgroundColor,
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon Lokasi
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.location_on_outlined, color: kIconColor, size: 24),
                    ),
                    SizedBox(width: 4.w),
                    // Teks Alamat
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Alamat Lengkap", style: kSubtitleTextStyle.copyWith(fontSize: 13.sp)),
                          SizedBox(height: 0.5.h),
                          Text(subText, style: kBodyTextStyle.copyWith(fontSize: 15.sp)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                // Map Placeholder (lebih menarik)
                AspectRatio( // Menjaga rasio aspek peta
                  aspectRatio: 16 / 9,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                      // Optional: Tambahkan gambar placeholder peta
                      // image: DecorationImage(
                      //   image: NetworkImage('URL_STATIC_MAP_IMAGE'), // Ganti dengan URL gambar peta statis jika ada
                      //   fit: BoxFit.cover,
                      //   colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken)
                      // )
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.map_outlined, color: kTextColorSecondary, size: 40),
                          SizedBox(height: 1.h),
                          Text(
                            "Tampilan Peta",
                            style: kSubtitleTextStyle,
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
      ],
    );
  }

  // --- Action Buttons Section ---
  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        // Tombol Edit
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement edit action
              print("Edit button tapped!");
               ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Fitur Edit belum tersedia"), duration: Duration(seconds: 1)),
                );
            },
            icon: const Icon(Icons.edit_outlined, size: 20),
            label: Text(
              "Edit",
              style: GoogleFonts.poppins(fontSize: 15.sp, fontWeight: FontWeight.w500),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor, // Warna utama
              foregroundColor: Colors.white, // Teks putih
              padding: EdgeInsets.symmetric(vertical: 1.8.h), // Padding vertikal responsif
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 3, // Sedikit elevasi
              shadowColor: kPrimaryColor.withOpacity(0.4),
            ),
          ),
        ),
        SizedBox(width: 4.w),
        // Tombol Cancel
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              // TODO: Implement cancel action (show confirmation dialog)
              print("Cancel button tapped!");
               ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Fitur Batal belum tersedia"), duration: Duration(seconds: 1)),
                );
            },
            icon: Icon(Icons.cancel_outlined, size: 20, color: kCancelledColor.shade700), // Warna icon merah
            label: Text(
              "Batalkan", // Teks lebih jelas
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: kCancelledColor.shade700, // Warna teks merah
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: kCancelledColor.shade700, width: 1.5), // Border merah
              padding: EdgeInsets.symmetric(vertical: 1.8.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}