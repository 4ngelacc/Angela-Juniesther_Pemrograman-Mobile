import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/app_theme.dart';

/// Field berbentuk pill putih dengan bayangan (sesuai desain).
/// Jika [hasError] true, muncul outline merah.
class PillTextField extends StatelessWidget {
  const PillTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.height = 46,
    this.hasError = false,
    this.obscureText = false,
    this.onToggleObscure,
    this.showToggle = false,
    this.leading,
    this.leftPadding = 26,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String hint;
  final double height;
  final bool hasError;
  final bool obscureText;
  final bool showToggle;
  final VoidCallback? onToggleObscure;

  /// Widget di kiri (misal lingkaran kuning berisi ikon).
  final Widget? leading;
  final double leftPadding;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(height / 2),
        boxShadow: kFieldShadow,
      ),
      // Outline merah digambar di atas (tidak mengubah ukuran layout).
      foregroundDecoration: hasError
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(height / 2),
              border: Border.all(color: AppColors.error, width: 1.5),
            )
          : null,
      child: Row(
        children: [
          if (leading != null) leading!,
          SizedBox(width: leading != null ? 20 : leftPadding),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              inputFormatters: inputFormatters,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              cursorColor: AppColors.dark,
              style: inter(),
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                hintText: hint,
                hintStyle: inter(color: AppColors.hint),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (showToggle)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onToggleObscure,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(
                  obscureText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 27,
                  color: AppColors.dark,
                ),
              ),
            ),
          const SizedBox(width: 18),
        ],
      ),
    );
  }
}
