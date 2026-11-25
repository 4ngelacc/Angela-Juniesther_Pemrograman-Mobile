import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../services/auth_service.dart';
import '../widgets/app_buttons.dart';
import '../widgets/glow_background.dart';
import '../widgets/pill_text_field.dart';
import '../widgets/tuurn_graphics.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscure = true;
  bool _hasError = false;

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _clearError([String _ = '']) {
    if (_hasError) setState(() => _hasError = false);
  }

  void _login() {
    FocusScope.of(context).unfocus();
    final user = AuthService.instance.login(
      _idController.text,
      _passwordController.text,
    );
    if (user == null) {
      // Data tidak ada / salah.
      setState(() => _hasError = true);
      return;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => HomePage(user: user)),
    );
  }

  void _comingSoon(String feature) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$feature belum tersedia')));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final contentWidth =
        screenWidth - 32 < kContentWidth ? screenWidth - 32 : kContentWidth;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: GlowBackground(
          glows: GlowPresets.login,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 35, bottom: 30),
              child: Center(
                child: SizedBox(
                  width: contentWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TUURN',
                        style: inter(
                          size: 48,
                          weight: FontWeight.w700,
                          color: AppColors.brandGreen,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Text('Selamat datang!', style: inter(size: 20)),
                      ),
                      const SizedBox(height: 49),
                      const Padding(
                        padding: EdgeInsets.only(left: 76),
                        child: TuurnLogo(width: 160),
                      ),
                      const SizedBox(height: 49),
                      PillTextField(
                        controller: _idController,
                        hint: 'Email atau username',
                        height: 56,
                        hasError: _hasError,
                        leading: const _Avatar(child: UserIcon()),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onChanged: _clearError,
                      ),
                      const SizedBox(height: 18),
                      PillTextField(
                        controller: _passwordController,
                        hint: 'Password',
                        height: 56,
                        hasError: _hasError,
                        leading: const _Avatar(child: KeyIcon()),
                        obscureText: _obscure,
                        showToggle: true,
                        onToggleObscure: () =>
                            setState(() => _obscure = !_obscure),
                        textInputAction: TextInputAction.done,
                        onChanged: _clearError,
                        onSubmitted: (_) => _login(),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        height: 17,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: _hasError
                                    ? Text(
                                        'Email atau password salah',
                                        style: inter(
                                          size: 12,
                                          color: AppColors.error,
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => _comingSoon('Lupa password'),
                              child: Text('Lupa Password?', style: inter()),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 33),
                      PrimaryButton(label: 'Masuk', onPressed: _login),
                      const SizedBox(height: 17),
                      SizedBox(
                        height: 17,
                        child: Row(
                          children: [
                            const Expanded(child: _Line()),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Text('Or', style: inter()),
                            ),
                            const Expanded(child: _Line()),
                          ],
                        ),
                      ),
                      const SizedBox(height: 17),
                      GoogleButton(
                        onPressed: () => _comingSoon('Login dengan Google'),
                      ),
                      const SizedBox(height: 18),
                      AuthFooter(
                        prefix: 'Tidak punya akun?',
                        action: 'Daftar Akun',
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const RegisterPage(),
                          ),
                        ),
                      ),
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
}

/// Lingkaran kuning berisi ikon di kiri field.
class _Avatar extends StatelessWidget {
  const _Avatar({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.yellow,
        shape: BoxShape.circle,
        boxShadow: kFieldShadow,
      ),
      child: child,
    );
  }
}

class _Line extends StatelessWidget {
  const _Line();

  @override
  Widget build(BuildContext context) =>
      const SizedBox(height: 1, child: ColoredBox(color: AppColors.dark));
}
