import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../widgets/app_buttons.dart';
import '../widgets/glow_background.dart';
import '../widgets/tuurn_graphics.dart';
import 'login_page.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key, required this.name});

  /// Nama user yang baru mendaftar (ditampilkan di teks sambutan).
  final String name;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final contentWidth =
        screenWidth - 32 < kContentWidth ? screenWidth - 32 : kContentWidth;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GlowBackground(
        glows: GlowPresets.success,
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Center(
                    child: SizedBox(
                      width: contentWidth,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SuccessBadge(size: 158),
                          const SizedBox(height: 27),
                          Text(
                            'Akun Berhasil Dibuat!',
                            textAlign: TextAlign.center,
                            style: inter(size: 24, weight: FontWeight.w700),
                          ),
                          const SizedBox(height: 11),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 270),
                            child: Text(
                              'Selamat datang di Tuurn, $name. Mulai '
                              'kumpulkan poin dari kebiasaan ramah lingkungan.',
                              textAlign: TextAlign.center,
                              style: inter(
                                color: AppColors.subtitle,
                                height: 17 / 14,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const PointCoin(size: 30),
                              const SizedBox(width: 10),
                              Text('+ 25 Poin', style: inter(size: 20)),
                            ],
                          ),
                          const SizedBox(height: 37),
                          PrimaryButton(
                            label: 'Masuk',
                            color: AppColors.green,
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (_) => const LoginPage(),
                                ),
                                (route) => false,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
