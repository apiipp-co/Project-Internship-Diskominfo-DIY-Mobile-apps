import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:JogjaIstimewa/Screens/Views/cctv_details_screen.dart';
import 'package:JogjaIstimewa/Screens/Widgets/cctvList.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppStyles {
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF03BE96), Color(0xFF00A6A0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient appBarGradient = LinearGradient(
    colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 79, 5, 5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static BoxDecoration cardDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 15,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }

  static TextStyle titleStyle = GoogleFonts.poppins(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static TextStyle subtitleStyle = GoogleFonts.poppins(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: Colors.white70,
  );

  static TextStyle sectionTitleStyle = GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 1,
  );

  static TextStyle changeTextStyle = GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: Color.fromARGB(137, 56, 56, 56),
  );
}

class appointment extends StatelessWidget {
  const appointment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCCTVInfo(),
            SizedBox(height: 2.h),
            _buildDateSection(),
            SizedBox(height: 2.h),
            _buildReasonSection(),
            SizedBox(height: 2.h),
            _buildPaymentDetails(),
            SizedBox(height: 2.h),
            _buildPaymentMethod(),
            SizedBox(height: 2.h),
            _buildTotalAndDownloadButton(context),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(12.h),
      child: Container(
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
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: cctv_details_screen(),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 18.sp,
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "CCTV Download",
                      style: GoogleFonts.inter(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Download Video CCTV yang kamu pilih",
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
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Notifications Coming Soon!',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                    backgroundColor: const Color(0xFF03BE96),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: _buildNotificationIcon(),
            ),
          ],
        ),
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
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.notifications),
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

  Widget _buildCCTVInfo() {
    return cctvlist(
      distance: "800m away",
      image: "lib/icons/jogjaporvcctv2.png",
      maintext: "Jl. Malioboro",
      numRating: "2025",
      subtext: "Yogyakarta",
    );
  }

  Widget _buildDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("Date", "Change"),
        SizedBox(height: 1.h),
        Row(
          children: [
            _buildIconContainer("lib/icons/callender.png"),
            SizedBox(width: 2.w),
            Expanded(
              child: Text(
                "Senin, Jun 23, 2025 | 10:00 AM",
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReasonSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("Reason", "Change"),
        SizedBox(height: 1.h),
        const Divider(color: Colors.black12),
        SizedBox(height: 1.h),
        Row(
          children: [
            _buildIconContainer("lib/icons/pencil.png"),
            SizedBox(width: 2.w),
            Text(
              "Chest pain",
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        const Divider(color: Colors.black12),
      ],
    );
  }

  Widget _buildPaymentDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Payment Details", style: AppStyles.sectionTitleStyle),
        SizedBox(height: 2.h),
        _buildPaymentRow("Consultation", "Rp 50.000"),
        SizedBox(height: 0.5.h),
        _buildPaymentRow("Admin Fee", "Rp 50"),
        SizedBox(height: 0.5.h),
        _buildPaymentRow("Additional Discount", "-"),
        SizedBox(height: 1.5.h),
        _buildPaymentRow("Total", "Rp 50.050", isTotal: true),
        SizedBox(height: 1.h),
        const Divider(color: Colors.black12),
      ],
    );
  }

  Widget _buildPaymentMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Payment Method", style: AppStyles.sectionTitleStyle),
        SizedBox(height: 1.h),
        Container(
          height: 6.h,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "BPD DIY",
                  style: GoogleFonts.inter(
                    fontStyle: FontStyle.italic,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 38, 39, 117),
                  ),
                ),
                Text("Change", style: AppStyles.changeTextStyle),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTotalAndDownloadButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Total", style: AppStyles.changeTextStyle),
            SizedBox(height: 0.5.h),
            Text(
              "Rp 50.050",
              style: GoogleFonts.inter(
                fontSize: 19.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 179, 2, 2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.h),
          ),
          child: Text(
            "Download",
            style: GoogleFonts.poppins(
              fontSize: 15.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppStyles.sectionTitleStyle),
        Text(action, style: AppStyles.changeTextStyle),
      ],
    );
  }

  Widget _buildPaymentRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
            color: isTotal ? Colors.black87 : Colors.black54,
            fontWeight: isTotal ? FontWeight.w500 : FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            color: isTotal ? const Color(0xFF045C3A) : Colors.black,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildIconContainer(String imagePath) {
    return Container(
      height: 6.h,
      width: 6.h,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(18),
        image: DecorationImage(
          image: AssetImage(imagePath),
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}