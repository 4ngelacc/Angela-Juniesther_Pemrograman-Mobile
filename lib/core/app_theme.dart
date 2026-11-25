import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Warna-warna yang diambil dari desain.
class AppColors {
  AppColors._();

  static const Color dark = Color(0xFF333331);
  static const Color hint = Color(0xFFB3B3B3);
  static const Color subtitle = Color(0xFF969995);
  static const Color yellow = Color(0xFFFFD166);
  static const Color arrowYellow = Color(0xFFFECF65);
  static const Color brandGreen = Color(0xFFA8DE8A);
  static const Color green = Color(0xFFA3D886);
  static const Color link = Color(0xFF569F50);
  static const Color error = Color(0xFFE53935);
  static const Color checkboxOff = Color(0xFFD9D9D9);
}

/// Bayangan field (pill putih) & tombol.
const List<BoxShadow> kFieldShadow = [
  BoxShadow(color: Color(0x40000000), blurRadius: 5, offset: Offset(0, 2)),
];

const List<BoxShadow> kButtonShadow = [
  BoxShadow(color: Color(0x2E000000), blurRadius: 6, offset: Offset(0, 3)),
];

/// Lebar kolom konten pada desain (54px margin kiri-kanan di layar 412px).
const double kContentWidth = 304;

/// Style teks (font Inter, sesuai desain).
TextStyle inter({
  double size = 14,
  FontWeight weight = FontWeight.w400,
  Color color = AppColors.dark,
  double height = 1.21,
}) {
  return GoogleFonts.inter(
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
  );
}
