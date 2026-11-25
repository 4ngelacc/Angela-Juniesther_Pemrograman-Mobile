import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import 'tuurn_graphics.dart';

/// Tombol utama berbentuk pill (kuning / hijau).
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = AppColors.yellow,
  });

  final String label;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    const radius = BorderRadius.all(Radius.circular(28));
    return DecoratedBox(
      decoration: const BoxDecoration(
        borderRadius: radius,
        boxShadow: kButtonShadow,
      ),
      child: Material(
        color: color,
        borderRadius: radius,
        child: InkWell(
          borderRadius: radius,
          onTap: onPressed,
          child: SizedBox(
            height: 56,
            width: double.infinity,
            child: Center(
              child: Text(
                label,
                style: inter(size: 20, weight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Tombol putih "Lanjutkan dengan google".
class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    const radius = BorderRadius.all(Radius.circular(26));
    return DecoratedBox(
      decoration: const BoxDecoration(
        borderRadius: radius,
        boxShadow: kButtonShadow,
      ),
      child: Material(
        color: Colors.white,
        borderRadius: radius,
        child: InkWell(
          borderRadius: radius,
          onTap: onPressed,
          child: SizedBox(
            height: 52,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const GoogleG(size: 26),
                const SizedBox(width: 12),
                Text('Lanjutkan dengan google', style: inter()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Teks "Tidak punya akun? Daftar Akun" / "Sudah punya akun? Masuk".
class AuthFooter extends StatelessWidget {
  const AuthFooter({
    super.key,
    required this.prefix,
    required this.action,
    required this.onTap,
  });

  final String prefix;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(prefix, style: inter()),
        const SizedBox(width: 16),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Text(action, style: inter(color: AppColors.link)),
        ),
      ],
    );
  }
}
