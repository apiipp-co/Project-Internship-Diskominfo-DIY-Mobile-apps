import 'package:flutter/material.dart';
// Impor GoogleFonts jika digunakan di sini, jika tidak, bisa dihapus
// import 'package:google_fonts/google_fonts.dart'; 

class Auth_text_field extends StatelessWidget { // Ubah nama kelas menjadi PascalCase
  final String text;
  final String icon;

  // Tambahkan const pada konstruktor jika memungkinkan
  const Auth_text_field({super.key, required this.text, required this.icon}); // Tambahkan super(key: key)

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox( // Gunakan SizedBox daripada Container jika hanya untuk ukuran
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.9,
        child: TextField(
          textAlign: TextAlign.start,
          textInputAction: TextInputAction.none,
          obscureText: false, // Jika ini field password, ini harusnya true
          keyboardType: TextInputType.emailAddress,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            focusColor: Colors.black26,
            fillColor: const Color.fromARGB(255, 247, 247, 247), // Tambahkan const
            filled: true,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10), // Tambahkan const
              child: Image.asset(icon), // Pastikan path icon benar
            ),
            prefixIconColor: const Color.fromARGB(255, 3, 190, 150), // Tambahkan const
            label: Text(text),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}