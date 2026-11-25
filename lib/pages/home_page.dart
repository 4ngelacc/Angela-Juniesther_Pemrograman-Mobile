import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../services/auth_service.dart';
import '../widgets/app_buttons.dart';
import '../widgets/glow_background.dart';
import '../widgets/tuurn_graphics.dart';
import 'login_page.dart';

/// Halaman sementara setelah login berhasil.
/// Ganti dengan halaman beranda aplikasi yang sebenarnya.
class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.user});

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GlowBackground(
        glows: GlowPresets.login,
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 54),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TuurnLogo(width: 120),
                  const SizedBox(height: 24),
                  Text(
                    'Halo, ${user.firstName}!',
                    textAlign: TextAlign.center,
                    style: inter(size: 24, weight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Kamu berhasil masuk ke Tuurn.',
                    textAlign: TextAlign.center,
                    style: inter(color: AppColors.subtitle),
                  ),
                  const SizedBox(height: 32),
                  PrimaryButton(
                    label: 'Keluar',
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
