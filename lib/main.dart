import 'package:flutter/material.dart';

import 'core/app_theme.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const TuurnApp());
}

class TuurnApp extends StatelessWidget {
  const TuurnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tuurn',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.green),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LoginPage(),
    );
  }
}
