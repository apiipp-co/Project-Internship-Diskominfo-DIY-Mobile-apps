import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class chat_helpdesk extends StatelessWidget {
  const chat_helpdesk({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.06,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Row(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.1500,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage("images/DIY.png"),
                    filterQuality: FilterQuality.high),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.6,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "KOMINFO DIY",
                      style: GoogleFonts.poppins(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 41, 41, 41)),
                    ),
                    Text(
                      "10 min ago",
                      style: GoogleFonts.poppins(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 92, 92, 92)),
                    )
                  ]),
            ),
          ]),
        ),
      ],
    );
  }
}
