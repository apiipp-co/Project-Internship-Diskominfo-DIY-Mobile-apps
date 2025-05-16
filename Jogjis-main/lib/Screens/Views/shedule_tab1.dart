import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:JogjaIstimewa/Screens/Widgets/shedule_card.dart'; // Pastikan nama file dan widget sudah diubah ke ScheduleCard
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:JogjaIstimewa/Screens/Views/schedule_detail_screen.dart';

// --- Model Data untuk Item Jadwal ---
class ScheduleItem {
  final String id; // Tambahkan ID unik jika perlu
  final String mainText;
  final String subText;
  final String date;
  final String time;
  final String image;
  final String confirmation; // Status Konfirmasi

  const ScheduleItem({
    required this.id,
    required this.mainText,
    required this.subText,
    required this.date,
    required this.time,
    required this.image,
    this.confirmation = "Confirmed", // Default value
  });
}

// --- Widget Utama ---
class shedule_tab1 extends StatelessWidget {
  const shedule_tab1({super.key});

  // --- Daftar Data Jadwal (Contoh) ---
  // Di aplikasi nyata, ini mungkin berasal dari state management atau API
  final List<ScheduleItem> scheduleData = const [
    ScheduleItem(
      id: '1',
      mainText: "🛠️ Tabrak Lari",
      subText: "Yogyakarta - Jl.Imogiri Barat",
      date: "26/01/2025",
      time: "10:30 AM",
      image: "lib/icons/laporan1.jpg",
    ),
    ScheduleItem(
      id: '2',
      mainText: "📱 Penemuan Ponsel", // Contoh variasi
      subText: "Yogyakarta - Jl.Imogiri Timur",
      date: "26/03/2025",
      time: "2:00 PM",
      image: "lib/icons/laporan2.jpg",
    ),
    ScheduleItem(
      id: '3',
      mainText: "🚨 Laporan Darurat", // Contoh variasi
      subText: "Yogyakarta - Jl.Malioboro",
      date: "30/01/2025",
      time: "8:15 AM",
      image: "lib/icons/laporan3.jpg",
    ),
     ScheduleItem(
      id: '4',
      mainText: " Bantuan Medis", // Contoh lain
      subText: "Sleman - Area UGM",
      date: "15/02/2025",
      time: "09:00 AM",
      image: "lib/icons/laporan4.jpg",
      confirmation: "Pending", // Contoh status berbeda
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Warna latar belakang sedikit abu-abu
      body: SafeArea(
        child: Padding(
          // Gunakan nilai responsif jika diinginkan
          padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 15.sp),
          child: SingleChildScrollView( // Tetap gunakan jika konten bisa melebihi layar
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Header ---
                Text(
                  "Laporan Terbaru", // Judul lebih deskriptif
                  style: GoogleFonts.lato( // Contoh penggunaan GoogleFonts
                    fontSize: 22.sp, // Ukuran font responsif
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Ketuk kartu laporan untuk melihat detail.", // Subjudul lebih jelas
                  style: GoogleFonts.lato(
                    fontSize: 15.sp, // Ukuran font responsif
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),

                // --- Daftar Kartu Jadwal ---
                // Membangun daftar kartu dari list data menggunakan map
                if (scheduleData.isEmpty)
                  _buildEmptyState() // Tampilkan pesan jika data kosong
                else
                  Column(
                    children: scheduleData.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 16.0), // Jarak antar kartu
                      child: _buildScheduleCard(context: context, item: item),
                    )).toList(),
                  ),

                const SizedBox(height: 24), // Jarak di akhir
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Helper Widget untuk Kartu ---
  Widget _buildScheduleCard({
    required BuildContext context,
    required ScheduleItem item,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScheduleDetailScreen(
              // Mengirim data dari objek item
              mainText: item.mainText,
              subText: item.subText,
              date: item.date,
              time: item.time,
              confirmation: item.confirmation,
              image: item.image,
            ),
          ),
        );
      },
      child: Container(
        // Dekorasi dipindahkan ke sini untuk membungkus ScheduleCard
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0), // Radius lebih besar
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15), // Shadow lebih halus
              spreadRadius: 1,
              blurRadius: 12,
              offset: const Offset(0, 5), // Posisi shadow
            ),
          ],
        ),
        child: shedule_card( // Menggunakan widget ScheduleCard yang sudah ada (pastikan namanya sesuai)
          confirmation: item.confirmation,
          mainText: item.mainText,
          subText: item.subText,
          date: item.date,
          time: item.time,
          image: item.image,
          // Anda mungkin perlu menyesuaikan parameter ScheduleCard jika berbeda
        ),
      ),
    );
  }

   // --- Helper Widget untuk State Kosong ---
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 60.sp, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              "Belum Ada Laporan",
              style: GoogleFonts.lato(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
             const SizedBox(height: 8),
             Text(
              "Laporan yang masuk akan ditampilkan di sini.",
              style: GoogleFonts.lato(
                fontSize: 15.sp,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}


// --- Catatan Penting ---
// 1. Pastikan Anda telah mengubah nama file dan kelas widget kartu dari `shedule_card.dart` menjadi `schedule_card.dart` dan `ScheduleCard`.
// 2. Sesuaikan parameter yang dibutuhkan oleh widget `ScheduleCard` Anda di dalam `_buildScheduleCard`.
// 3. Anda bisa lebih lanjut meningkatkan tampilan di dalam widget `ScheduleCard` itu sendiri (misalnya, layout internal, ikon, warna status konfirmasi).
// 4. Jika daftar menjadi sangat panjang, pertimbangkan menggunakan `ListView.separated` daripada `Column` di dalam `SingleChildScrollView` untuk performa yang lebih baik (lazily builds items).
// 5. Penggunaan `ResponsiveSizer` (seperti `18.sp`, `22.sp`) akan membuat ukuran font dan padding beradaptasi dengan ukuran layar yang berbeda. Pastikan Anda telah menginisialisasi `ResponsiveSizer` di root aplikasi Anda.