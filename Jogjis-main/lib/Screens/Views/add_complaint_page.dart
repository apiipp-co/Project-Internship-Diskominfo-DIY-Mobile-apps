import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Untuk HapticFeedback
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// --- Constants ---
class AppColors {
  static const Color primary = Color(0xFFD32F2F); // Merah primer (lebih gelap)
  static const Color primaryLight = Color(0xFFFFCDD2); // Merah muda
  static const Color accent = Color(0xFF05B99B); // Teal accent (digunakan sebelumnya)
  static const Color background = Color(0xFFF5F5F5); // Abu-abu muda background
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Color(0xFF212121); // Hitam pekat
  static const Color textSecondary = Color(0xFF757575); // Abu-abu
  static const Color error = Colors.redAccent;

  static const LinearGradient appBarGradient = LinearGradient(
    colors: [Color(0xFFF44336), Color(0xFFB71C1C)], // Merah cerah ke gelap
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient buttonGradient = LinearGradient(
    colors: [Color(0xFFF44336), Color(0xFFB71C1C)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

class AppStyles {
  static final TextStyle heading1 = GoogleFonts.poppins(
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static final TextStyle heading2 = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static final TextStyle bodyText = GoogleFonts.poppins(
    fontSize: 14.sp,
    color: AppColors.textSecondary,
  );

   static final TextStyle labelStyle = GoogleFonts.poppins(
    color: AppColors.textSecondary.withOpacity(0.8),
    fontSize: 13.5.sp
   );

   static final TextStyle inputStyle = GoogleFonts.poppins(
    color: AppColors.textPrimary,
    fontSize: 14.sp
   );

  static final BoxDecoration cardDecoration = BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.circular(15.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.06),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
    ],
  );

   static final InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey[300]!),
    );

   static final InputBorder focusedInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primary, width: 1.5), // Warna fokus
    );

   static final InputBorder errorInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.error, width: 1.2),
    );
}
// --- End Constants ---


class AddComplaintPage extends StatefulWidget {
  const AddComplaintPage({super.key});

  @override
  _AddComplaintPageState createState() => _AddComplaintPageState();
}

class _AddComplaintPageState extends State<AddComplaintPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nikController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  final _addressController = TextEditingController();

  String? _selectedRegion = '-- Pilih Wilayah --';
  String? _selectedCategory = '-- Pilih Kategori --';
  bool _isAnonymous = false;
  bool _isConfidential = false;
  bool _isAgreed = false;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  final List<String> _regions = [
    '-- Pilih Wilayah --', 'Bantul', 'Yogyakarta', 'Sleman', 'Gunung Kidul', 'Kulon Progo',
  ];
  final List<String> _categories = [
    '-- Pilih Kategori --', 'Infrastruktur', 'Pelayanan Publik', 'Keamanan', 'Lingkungan', 'Sosial', 'Lainnya',
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutQuad),
    );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nikController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _addressController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _submitComplaint() {
    HapticFeedback.mediumImpact();

    bool isRegionValid = _selectedRegion != null && _selectedRegion != '-- Pilih Wilayah --';
    bool isCategoryValid = _selectedCategory != null && _selectedCategory != '-- Pilih Kategori --';

    // Trigger validasi form sebelum cek _isAgreed
    bool isFormValid = _formKey.currentState?.validate() ?? false;


    if (isFormValid && isRegionValid && isCategoryValid && _isAgreed) {
       _showSnackbar('Aduan berhasil dikirim!', AppColors.accent);
       // Delay pop agar user sempat lihat snackbar
       Future.delayed(const Duration(seconds: 1), () {
         if (mounted) { // Cek jika widget masih ada di tree
            Navigator.pop(context);
         }
       });
    } else if (!_isAgreed) {
      _showSnackbar('Anda harus menyetujui Syarat & Ketentuan', AppColors.error);
    } else if (!isRegionValid) {
       _showSnackbar('Harap pilih wilayah aduan', AppColors.error);
    } else if (!isCategoryValid) {
      _showSnackbar('Harap pilih kategori aduan', AppColors.error);
    } else if (!isFormValid) {
       // Jika form tidak valid tapi bukan karena agreement/dropdown
       _showSnackbar('Harap periksa kembali isian form Anda', AppColors.error);
    }
  }

  void _showSnackbar(String message, Color backgroundColor) {
     // Pastikan context masih valid sebelum menampilkan Snackbar
     if (!mounted) return;
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  String? _validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName tidak boleh kosong';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    // Hanya validasi jika tidak anonim
    if(_isAnonymous) return null;

    if (value == null || value.trim().isEmpty) {
      return 'Email tidak boleh kosong';
    }
    final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegex.hasMatch(value)) {
      return 'Format email tidak valid';
    }
    return null;
  }

   String? _validatePhone(String? value) {
     // Hanya validasi jika tidak anonim
     if(_isAnonymous) return null;

    if (value == null || value.trim().isEmpty) {
      return 'No. Telepon tidak boleh kosong';
    }
    final phoneRegex = RegExp(r"^[0-9]{9,}$");
    if (!phoneRegex.hasMatch(value)) {
      return 'Format No. Telepon tidak valid (min. 9 digit angka)';
    }
    return null;
  }

  String? _validateNik(String? value) {
    // Hanya validasi jika tidak anonim
    if(_isAnonymous) return null;

    if (value == null || value.trim().isEmpty) {
      return 'NIK tidak boleh kosong';
    }
    final nikRegex = RegExp(r"^[0-9]{16}$");
    if (!nikRegex.hasMatch(value)) {
      return 'NIK harus terdiri dari 16 digit angka';
    }
    return null;
  }

  String? _validateCoordinate(String? value, String coordName) {
      if (value == null || value.isEmpty) return '$coordName tidak boleh kosong';
      if (double.tryParse(value) == null) return '$coordName harus berupa angka';
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // Perbaikan: Gunakan PreferredSizeWidget sebagai tipe AppBar
      appBar: _buildAppBar(),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('Sifat Aduan', Icons.shield_outlined),
                      _buildComplaintTypeSection(),
                      SizedBox(height: 3.h),

                      // Tampilkan Data Pengirim hanya jika tidak anonim
                      // Pakai AnimatedOpacity agar ada transisi saat muncul/hilang
                      AnimatedOpacity(
                         opacity: _isAnonymous ? 0.0 : 1.0,
                         duration: const Duration(milliseconds: 300),
                         child: Visibility( // Gunakan Visibility agar tidak memakan ruang saat hilang
                           visible: !_isAnonymous,
                           child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSectionTitle('Data Pengirim', Icons.person_outline),
                                _buildSenderDataSection(),
                                SizedBox(height: 3.h),
                              ],
                           ),
                         ),
                       ),


                      _buildSectionTitle('Detail Aduan', Icons.list_alt_outlined),
                      _buildComplaintDetailsSection(),
                       SizedBox(height: 3.h),

                       _buildSectionTitle('Isi Aduan', Icons.edit_note_outlined),
                       _buildComplaintContentSection(),
                       SizedBox(height: 3.h),


                      _buildSectionTitle('Lampiran (Opsional)', Icons.attach_file_outlined),
                      _buildAttachmentSection(),
                      SizedBox(height: 3.h),

                      _buildSectionTitle('Lokasi Kejadian', Icons.location_on_outlined),
                      _buildLocationSection(),
                      SizedBox(height: 3.h),

                      _buildAgreementSection(),
                      SizedBox(height: 4.h),

                      _buildSubmitButton(),
                      SizedBox(height: 3.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

 // Perbaikan: Tipe return adalah PreferredSizeWidget
 PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(12.h),
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 1.h, left: 5.w, right: 5.w, bottom: 2.h),
        decoration: BoxDecoration(
          gradient: AppColors.appBarGradient,
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Material(
                  color: Colors.white.withOpacity(0.25),
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                     splashColor: Colors.white.withOpacity(0.4),
                     onTap: () => Navigator.of(context).pop(),
                     child: Container(
                       padding: EdgeInsets.all(2.5.w),
                       child: Icon(
                         Icons.arrow_back_ios_new,
                         color: Colors.white,
                         size: 18.sp,
                        ),
                      ),
                    ),
                 ),
                SizedBox(width: 4.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Buat Aduan Baru",
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      "Isi detail aduan Anda di bawah",
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.85),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // _buildNotificationIcon(), // Uncomment jika diperlukan
          ],
        ),
      ),
    );
 }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.5.h, left: 1.w),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 18.sp),
          SizedBox(width: 2.w),
          Text(
            title,
            style: AppStyles.heading2.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Widget child) {
     return Container(
       padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.5.h),
       decoration: AppStyles.cardDecoration,
       child: child,
     );
  }

 Widget _buildComplaintTypeSection() {
    return _buildCard(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildCheckboxOption(
            title: 'Anonim',
            value: _isAnonymous,
            onChanged: (value) {
              setState(() {
                _isAnonymous = value!;
                if (_isAnonymous) {
                  _isConfidential = false;
                  _nameController.clear();
                  _emailController.clear();
                  _phoneController.clear();
                  _nikController.clear();
                  // Reset validasi hanya untuk field pengirim jika form sudah pernah divalidasi
                   WidgetsBinding.instance.addPostFrameCallback((_) {
                       _formKey.currentState?.validate();
                    });
                } else {
                  // Jika batal anonim, validasi ulang
                   WidgetsBinding.instance.addPostFrameCallback((_) {
                       _formKey.currentState?.validate();
                    });
                }
              });
            },
          ),
          _buildCheckboxOption(
            title: 'Rahasia',
            value: _isConfidential,
            onChanged: _isAnonymous
              ? null // Nonaktifkan jika anonim
              : (value) {
                 setState(() {
                    _isConfidential = value!;
                 });
               },
          ),
        ],
      ),
    );
 }

 Widget _buildCheckboxOption({required String title, required bool value, required ValueChanged<bool?>? onChanged}) {
   return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          activeColor: AppColors.accent,
          onChanged: onChanged,
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        GestureDetector(
            onTap: onChanged != null ? () => onChanged(!value) : null,
            child: Text(title, style: AppStyles.bodyText.copyWith(color: AppColors.textPrimary))
        ),
      ],
    );
 }


 Widget _buildSenderDataSection() {
  return _buildCard(
    Column(
      children: [
        // Perbaikan: Panggil _buildTextField dengan argumen posisional
        _buildTextField(
          _nameController, // Positional 1: controller
          'Nama Lengkap', // Positional 2: label
          icon: Icons.person_outline,
          validator: (value) => _isAnonymous ? null : _validateNotEmpty(value, 'Nama Lengkap'), // Validasi jika tidak anonim
          enabled: !_isAnonymous,
        ),
        SizedBox(height: 2.h),
        _buildTextField(
          _emailController, // Positional 1
          'Alamat Email', // Positional 2
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: _validateEmail, // Validator sudah handle case anonim
          enabled: !_isAnonymous,
        ),
        SizedBox(height: 2.h),
        _buildTextField(
          _phoneController, // Positional 1
          'No. Telepon (WhatsApp Aktif)', // Positional 2
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: _validatePhone, // Validator sudah handle case anonim
          enabled: !_isAnonymous,
        ),
        SizedBox(height: 2.h),
        _buildTextField(
          _nikController, // Positional 1
          'NIK (Nomor Induk Kependudukan)', // Positional 2
          icon: Icons.badge_outlined,
          keyboardType: TextInputType.number,
          validator: _validateNik, // Validator sudah handle case anonim
          enabled: !_isAnonymous,
        ),
      ],
    ),
  );
 }

  Widget _buildComplaintDetailsSection() {
    return _buildCard(
      Column(
        children: [
          _buildDropdown(
            value: _selectedRegion,
            items: _regions,
            hint: 'Pilih Wilayah Terdampak',
            icon: Icons.map_outlined,
            onChanged: (value) {
              if (value != '-- Pilih Wilayah --'){
                setState(() { _selectedRegion = value; });
              } else {
                 setState(() { _selectedRegion = '-- Pilih Wilayah --'; }); // Set back to placeholder
              }
            },
            validator: (value) {
              if (value == null || value == '-- Pilih Wilayah --') {
                return 'Harap pilih wilayah';
              }
              return null;
            },
          ),
          SizedBox(height: 2.h),
          _buildDropdown(
            value: _selectedCategory,
            items: _categories,
            hint: 'Pilih Kategori Aduan',
            icon: Icons.category_outlined,
            onChanged: (value) {
              if (value != '-- Pilih Kategori --'){
                 setState(() { _selectedCategory = value; });
              } else {
                  setState(() { _selectedCategory = '-- Pilih Kategori --'; }); // Set back to placeholder
              }
            },
            validator: (value) {
              if (value == null || value == '-- Pilih Kategori --') {
                return 'Harap pilih kategori';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildComplaintContentSection() {
    return _buildCard(
      Column(
        children: [
          // Perbaikan: Panggil _buildTextField dengan argumen posisional
          _buildTextField(
            _titleController, // Positional 1
            'Judul Aduan', // Positional 2
            icon: Icons.title,
            validator: (value) => _validateNotEmpty(value, 'Judul Aduan'),
            maxLength: 100,
          ),
          SizedBox(height: 2.h),
          _buildTextField(
            _descriptionController, // Positional 1
            'Deskripsi Lengkap Aduan', // Positional 2
            icon: Icons.description_outlined,
            maxLines: 5,
            validator: (value) => _validateNotEmpty(value, 'Deskripsi Aduan'),
            maxLength: 1000,
          ),
        ],
      )
    );
  }

 Widget _buildAttachmentSection() {
    return GestureDetector(
      onTap: () {
        _showSnackbar('Fitur upload lampiran segera hadir!', AppColors.primary);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.5.h),
        decoration: BoxDecoration(
           color: AppColors.primaryLight.withOpacity(0.3),
           borderRadius: BorderRadius.circular(15.0),
           border: Border.all(color: AppColors.primary.withOpacity(0.5), width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_upload_outlined, color: AppColors.primary, size: 22.sp),
            SizedBox(width: 3.w),
            Text(
              'Ketuk untuk Unggah Lampiran',
              style: AppStyles.bodyText.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
 }

 Widget _buildLocationSection() {
  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, color: AppColors.accent, size: 18.sp),
            SizedBox(width: 2.w),
            Expanded(
              child: Text(
                 'Tandai lokasi di peta (segera hadir) atau isi detail di bawah.',
                 style: AppStyles.bodyText.copyWith(fontSize: 12.sp),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),

        Container(
          height: 20.h,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
               image: NetworkImage('https://via.placeholder.com/400x200.png?text=Peta+Segera+Hadir'),
               fit: BoxFit.cover,
               opacity: 0.6,
             ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              decoration: BoxDecoration(
                 color: Colors.black.withOpacity(0.5),
                 borderRadius: BorderRadius.circular(8)
              ),
              child: Text(
                'Integrasi Peta Segera Hadir',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 13.sp, color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        SizedBox(height: 2.h),

        Row(
          children: [
            Expanded(
              // Perbaikan: Panggil _buildTextField dengan argumen posisional
              child: _buildTextField(
                _latitudeController, // Positional 1
                'Lintang (Latitude)', // Positional 2
                icon: Icons.explore_outlined,
                keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                validator: (v) => _validateCoordinate(v, "Lintang")
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: _buildTextField(
                _longitudeController, // Positional 1
                'Bujur (Longitude)', // Positional 2
                icon: Icons.explore_outlined,
                keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                 validator: (v) => _validateCoordinate(v, "Bujur")
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),

        _buildTextField(
          _addressController, // Positional 1
          'Detail Alamat / Nama Jalan / Patokan', // Positional 2
          icon: Icons.location_city_outlined,
          maxLines: 3,
          validator: (value) => _validateNotEmpty(value, 'Alamat'),
        ),
      ],
    ),
  );
 }


 Widget _buildAgreementSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      decoration: BoxDecoration(
         color: AppColors.cardBackground,
         borderRadius: BorderRadius.circular(12),
         border: Border.all(color: _isAgreed ? AppColors.accent.withOpacity(0.5) : Colors.grey[300]!)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: _isAgreed,
            activeColor: AppColors.accent,
            visualDensity: VisualDensity.compact,
            onChanged: (value) {
              setState(() {
                _isAgreed = value!;
              });
            },
          ),
          Expanded(
            child: GestureDetector(
              onTap: () { setState(() { _isAgreed = !_isAgreed; });},
              child: RichText(
                 text: TextSpan(
                  style: AppStyles.bodyText.copyWith(fontSize: 12.sp),
                  children: [
                     const TextSpan(text: 'Saya menyatakan bahwa data yang saya isikan adalah benar dan saya menyetujui '),
                     TextSpan(
                       text: 'Syarat & Ketentuan',
                       style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                       // recognizer: TapGestureRecognizer()..onTap = () { /* Buka S&K */ },
                     ),
                     const TextSpan(text: ' yang berlaku.'),
                  ]
                 ),
              )
            ),
          ),
        ],
      ),
    );
 }

 Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _submitComplaint,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: AppColors.buttonGradient,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Container(
            width: 70.w,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 1.8.h),
            child: Text(
              'Kirim Aduan Sekarang',
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
 }

  // Definisi _buildTextField dengan controller dan label sebagai positional parameters
  Widget _buildTextField(
    TextEditingController controller, // Positional 1
    String label, // Positional 2
    { // Named parameters (optional)
      IconData? icon,
      TextInputType? keyboardType,
      int? maxLines = 1,
      String? Function(String?)? validator,
      bool enabled = true,
      int? maxLength,
    }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppStyles.labelStyle,
        hintText: 'Masukkan $label',
        hintStyle: AppStyles.labelStyle.copyWith(fontSize: 13.sp),
        prefixIcon: icon != null ? Icon(icon, color: AppColors.primary, size: 18.sp) : null,
        border: AppStyles.inputBorder,
        enabledBorder: AppStyles.inputBorder,
        focusedBorder: AppStyles.focusedInputBorder,
        errorBorder: AppStyles.errorInputBorder,
        focusedErrorBorder: AppStyles.errorInputBorder,
        filled: true,
        fillColor: enabled ? AppColors.cardBackground : Colors.grey[200],
        contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        counterText: maxLength != null ? "" : null,
      ),
      style: AppStyles.inputStyle,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator, // Validator dipanggil oleh Form, sudah handle case enabled di dalam validatornya
      enabled: enabled,
      maxLength: maxLength,
      inputFormatters: keyboardType == TextInputType.phone || keyboardType == TextInputType.number || keyboardType == TextInputType.numberWithOptions(decimal: true, signed: true)
        ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.-]'))] // Izinkan angka, titik, minus untuk koordinat/nomor
        : (keyboardType == TextInputType.number ? [FilteringTextInputFormatter.digitsOnly] : null), // Hanya digit untuk NIK
    );
  }

Widget _buildDropdown({
  String? value,
  required List<String> items,
  required String hint,
  required IconData icon,
  required void Function(String?) onChanged,
  String? Function(String?)? validator,
}) {
  return DropdownButtonFormField<String>(
    value: value,
    decoration: InputDecoration(
      labelText: hint,
      labelStyle: AppStyles.labelStyle,
      prefixIcon: Icon(icon, color: AppColors.primary, size: 18.sp),
      border: AppStyles.inputBorder,
      enabledBorder: AppStyles.inputBorder,
      focusedBorder: AppStyles.focusedInputBorder,
      errorBorder: AppStyles.errorInputBorder,
      focusedErrorBorder: AppStyles.errorInputBorder,
      filled: true,
      fillColor: AppColors.cardBackground,
      contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.8.h),
    ),
    selectedItemBuilder: (BuildContext context) {
       return items.map<Widget>((String item) {
         return Align(
           alignment: Alignment.centerLeft,
           child: Text(
             item,
             style: AppStyles.inputStyle,
             overflow: TextOverflow.ellipsis,
           ),
         );
       }).toList();
    },
    items: items.map((String item) {
      return DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: (item == '-- Pilih Wilayah --' || item == '-- Pilih Kategori --')
                 ? AppStyles.bodyText.copyWith(color: Colors.grey[600]) // Warna placeholder sedikit lebih jelas
                 : AppStyles.inputStyle,
        ),
      );
    }).toList(),
    onChanged: onChanged,
    validator: validator,
    icon: Icon(Icons.arrow_drop_down, color: AppColors.textSecondary),
    isExpanded: true,
  );
}


// Widget _buildNotificationIcon() { ... } // (Tetap sama)
Widget _buildNotificationIcon() {
 return Stack(
   alignment: Alignment.center,
   children: [
     Container(
       padding: EdgeInsets.all(2.w),
       decoration: BoxDecoration(
         color: Colors.white.withOpacity(0.2),
         shape: BoxShape.circle,
       ),
       child: Icon(
         Icons.notifications_outlined,
         color: Colors.white,
         size: 20.sp,
        ),
     ),
     Positioned(
       right: 1.w,
       top: 1.w,
       child: Container(
         padding: const EdgeInsets.all(1.5),
         decoration: BoxDecoration(
           color: Colors.redAccent,
           shape: BoxShape.circle,
           border: Border.all(color: Colors.white, width: 1.5),
         ),
         constraints: BoxConstraints(
           minWidth: 2.w,
           minHeight: 2.w,
         ),
       ),
     ),
   ],
 );
}

} // End of _AddComplaintPageState