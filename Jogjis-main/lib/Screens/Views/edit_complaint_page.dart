import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditComplaintPage extends StatefulWidget {
  final Map<String, dynamic> complaint;
  final Function(Map<String, dynamic>) onUpdate;

  const EditComplaintPage({super.key, required this.complaint, required this.onUpdate});

  @override
  _EditComplaintPageState createState() => _EditComplaintPageState();
}

class _EditComplaintPageState extends State<EditComplaintPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _nikController;
  late TextEditingController _latitudeController;
  late TextEditingController _longitudeController;
  late TextEditingController _addressController;

  String? _selectedRegion;
  String? _selectedCategory;
  bool _isAnonymous = false;
  bool _isConfidential = false;
  bool _isAgreed = false;
  bool _isNotRobot = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<String> _regions = [
    '-- Pilih Wilayah --',
    'Bantul',
    'Yogyakarta',
    'Sleman',
    'Gunung Kidul',
    'Kulon Progo',
  ];

  final List<String> _categories = [
    '-- Pilih Kategori --',
    'Infrastruktur',
    'Pelayanan Publik',
    'Keamanan',
    'Lainnya',
  ];

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan data yang ada
    _titleController = TextEditingController(text: widget.complaint['title']);
    _descriptionController = TextEditingController(text: widget.complaint['description']);
    _nameController = TextEditingController(text: widget.complaint['name']);
    _emailController = TextEditingController(text: widget.complaint['email']);
    _phoneController = TextEditingController(text: widget.complaint['phone']);
    _nikController = TextEditingController(text: widget.complaint['nik']);
    _latitudeController = TextEditingController(text: widget.complaint['latitude']);
    _longitudeController = TextEditingController(text: widget.complaint['longitude']);
    _addressController = TextEditingController(text: widget.complaint['address']);

    _selectedRegion = widget.complaint['region'];
    _selectedCategory = widget.complaint['category'];
    _isAnonymous = widget.complaint['isAnonymous'] ?? false;
    _isConfidential = widget.complaint['isConfidential'] ?? false;
    _isAgreed = true; // Asumsikan sudah setuju karena ini edit
    _isNotRobot = true; // Asumsikan sudah diverifikasi

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
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
    _animationController.dispose();
    super.dispose();
  }

  void _updateComplaint() {
    if (_formKey.currentState!.validate() && _isAgreed && _isNotRobot) {
      final updatedComplaint = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'nik': _nikController.text,
        'latitude': _latitudeController.text,
        'longitude': _longitudeController.text,
        'address': _addressController.text,
        'region': _selectedRegion,
        'category': _selectedCategory,
        'isAnonymous': _isAnonymous,
        'isConfidential': _isConfidential,
      };

      widget.onUpdate(updatedComplaint);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Aduan berhasil diperbarui!', style: GoogleFonts.poppins(color: Colors.white)),
          backgroundColor: const Color(0xFF05B99B),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                _buildHeader(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('Sifat Aduan'),
                        Container(
                          padding: EdgeInsets.all(2.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Checkbox(
                                value: _isAnonymous,
                                activeColor: const Color(0xFF05B99B),
                                onChanged: (value) {
                                  setState(() {
                                    _isAnonymous = value!;
                                    if (_isAnonymous) _isConfidential = false;
                                  });
                                },
                              ),
                              Text('Anonim', style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black87)),
                              SizedBox(width: 5.w),
                              Checkbox(
                                value: _isConfidential,
                                activeColor: const Color(0xFF05B99B),
                                onChanged: (value) {
                                  setState(() {
                                    _isConfidential = value!;
                                    if (_isConfidential) _isAnonymous = false;
                                  });
                                },
                              ),
                              Text('Rahasia', style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black87)),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h),

                        _buildSectionTitle('Data Pengirim'),
                        Container(
                          padding: EdgeInsets.all(2.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              _buildTextField(_nameController, 'Nama', validator: (value) {
                                if (!_isAnonymous && (value == null || value.isEmpty)) {
                                  return 'Nama tidak boleh kosong';
                                }
                                return null;
                              }),
                              SizedBox(height: 2.h),
                              _buildTextField(_emailController, 'Email',
                                  keyboardType: TextInputType.emailAddress, validator: (value) {
                                if (!_isAnonymous && (value == null || value.isEmpty)) {
                                  return 'Email tidak boleh kosong';
                                }
                                if (value != null && value.isNotEmpty && !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                  return 'Masukkan email yang valid';
                                }
                                return null;
                              }),
                              SizedBox(height: 2.h),
                              _buildTextField(_phoneController, 'No. Telepon',
                                  keyboardType: TextInputType.phone, validator: (value) {
                                if (!_isAnonymous && (value == null || value.isEmpty)) {
                                  return 'Nomor telepon tidak boleh kosong';
                                }
                                return null;
                              }),
                              SizedBox(height: 2.h),
                              _buildTextField(_nikController, 'NIK',
                                  keyboardType: TextInputType.number, validator: (value) {
                                if (!_isAnonymous && (value == null || value.isEmpty)) {
                                  return 'NIK tidak boleh kosong';
                                }
                                return null;
                              }),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h),

                        Container(
                          padding: EdgeInsets.all(2.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              _buildDropdown(
                                value: _selectedRegion,
                                items: _regions,
                                hint: '-- Pilih Wilayah --',
                                onChanged: (value) {
                                  setState(() {
                                    _selectedRegion = value;
                                  });
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
                                hint: '-- Pilih Kategori --',
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCategory = value;
                                  });
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
                        ),
                        SizedBox(height: 2.h),

                        _buildSectionTitle('Lokasi'),
                        Container(
                          padding: EdgeInsets.all(2.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_on, color: Colors.blueAccent, size: 20.sp),
                                  SizedBox(width: 2.w),
                                  Text(
                                    'Lokasi',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                'Klik pada peta untuk memindah marker serta secara otomatis mengatur Lintang dan Bujur. Anda juga bisa menyesuaikan nama alamat',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Container(
                                height: 20.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    'Peta akan ditampilkan di sini',
                                    style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.grey),
                                  ),
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildTextField(_latitudeController, 'Lintang',
                                        keyboardType: TextInputType.number, validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Lintang tidak boleh kosong';
                                      }
                                      return null;
                                    }),
                                  ),
                                  SizedBox(width: 2.w),
                                  Expanded(
                                    child: _buildTextField(_longitudeController, 'Bujur',
                                        keyboardType: TextInputType.number, validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Bujur tidak boleh kosong';
                                      }
                                      return null;
                                    }),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.h),
                              _buildTextField(
                                _addressController,
                                'Alamat',
                                maxLines: 2,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Alamat tidak boleh kosong';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 3.h),

                        Center(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            child: ElevatedButton(
                              onPressed: _updateComplaint,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 1.5.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF05B99B), Color(0xFF006633)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                                  child: Text(
                                    'Simpan Perubahan',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 3.h),
                      ],
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

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(top: 5.h, left: 5.w, right: 5.w, bottom: 2.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black.withOpacity(0.3), Colors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.2),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Edit Aduan",
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Perbarui Formulir Pengaduan Anda",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 40), // Placeholder untuk balancing
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(1, 1),
              blurRadius: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    TextInputType? keyboardType,
    int? maxLines,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF05B99B)),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines ?? 1,
      validator: validator,
    );
  }

  Widget _buildDropdown({
    String? value,
    required List<String> items,
    required String hint,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: GoogleFonts.poppins(color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF05B99B)),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item, style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black87)),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}