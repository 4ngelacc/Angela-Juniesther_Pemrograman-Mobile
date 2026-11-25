import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/app_theme.dart';
import '../core/validators.dart';
import '../services/auth_service.dart';
import '../widgets/app_buttons.dart';
import '../widgets/glow_background.dart';
import '../widgets/pill_text_field.dart';
import 'success_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agreed = false;

  // Pesan error per field (null = tidak ada error).
  String? _nameError;
  String? _emailError;
  String? _phoneError;
  String? _passwordError;
  String? _confirmError;
  String? _agreeError;

  // Setelah tombol Daftar ditekan, error diperbarui langsung saat mengetik.
  bool _submitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _validateAll() {
    _nameError = Validators.name(_nameController.text);
    _emailError = Validators.email(_emailController.text);
    _phoneError = Validators.phone(_phoneController.text);
    _passwordError = Validators.password(_passwordController.text);
    _confirmError = Validators.confirmPassword(
      _passwordController.text,
      _confirmController.text,
    );
    _agreeError = _agreed ? null : 'Anda harus menyetujui Syarat & Ketentuan';

    // Email yang sudah terdaftar.
    if (_emailError == null &&
        AuthService.instance.emailExists(_emailController.text)) {
      _emailError = 'Email sudah terdaftar';
    }
  }

  void _onChanged([String _ = '']) {
    if (!_submitted) return;
    setState(_validateAll);
  }

  void _toggleAgree() {
    setState(() {
      _agreed = !_agreed;
      if (_agreed) {
        _agreeError = null;
      } else if (_submitted) {
        _agreeError = 'Anda harus menyetujui Syarat & Ketentuan';
      }
    });
  }

  void _register() {
    FocusScope.of(context).unfocus();
    setState(() {
      _submitted = true;
      _validateAll();
    });

    final hasError = [
      _nameError,
      _emailError,
      _phoneError,
      _passwordError,
      _confirmError,
      _agreeError,
    ].any((e) => e != null);
    if (hasError) return;

    final user = AppUser(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      password: _passwordController.text,
    );
    AuthService.instance.register(user);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => SuccessPage(name: user.firstName)),
    );
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
          glows: GlowPresets.register,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 80, bottom: 30),
              child: Center(
                child: SizedBox(
                  width: contentWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Daftar Akun',
                          style: inter(size: 20, weight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 33),
                      _FormBlock(
                        label: 'Nama lengkap',
                        error: _nameError,
                        child: PillTextField(
                          controller: _nameController,
                          hint: 'Nama lengkap',
                          hasError: _nameError != null,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          onChanged: _onChanged,
                        ),
                      ),
                      _FormBlock(
                        label: 'Email',
                        error: _emailError,
                        child: PillTextField(
                          controller: _emailController,
                          hint: 'nama@gmail.com',
                          hasError: _emailError != null,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          onChanged: _onChanged,
                        ),
                      ),
                      _FormBlock(
                        label: 'No. HP',
                        error: _phoneError,
                        child: PillTextField(
                          controller: _phoneController,
                          hint: '08xxxxxxxxxx',
                          hasError: _phoneError != null,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
                            LengthLimitingTextInputFormatter(15),
                          ],
                          onChanged: _onChanged,
                        ),
                      ),
                      _FormBlock(
                        label: 'Password',
                        error: _passwordError,
                        child: PillTextField(
                          controller: _passwordController,
                          hint: 'Min. 8 karakter',
                          hasError: _passwordError != null,
                          obscureText: _obscurePassword,
                          showToggle: true,
                          onToggleObscure: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                          textInputAction: TextInputAction.next,
                          onChanged: _onChanged,
                        ),
                      ),
                      _FormBlock(
                        label: 'Konfirmasi Password',
                        error: _confirmError,
                        child: PillTextField(
                          controller: _confirmController,
                          hint: 'Ulangi Password',
                          hasError: _confirmError != null,
                          obscureText: _obscureConfirm,
                          showToggle: true,
                          onToggleObscure: () => setState(
                            () => _obscureConfirm = !_obscureConfirm,
                          ),
                          textInputAction: TextInputAction.done,
                          onChanged: _onChanged,
                          onSubmitted: (_) => _register(),
                        ),
                      ),
                      _AgreeRow(
                        checked: _agreed,
                        hasError: _agreeError != null,
                        onTap: _toggleAgree,
                      ),
                      SizedBox(
                        height: 31,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4, left: 20),
                          child: _agreeError == null
                              ? null
                              : Text(
                                  _agreeError!,
                                  style: inter(
                                    size: 12,
                                    color: AppColors.error,
                                  ),
                                ),
                        ),
                      ),
                      PrimaryButton(label: 'Daftar', onPressed: _register),
                      const SizedBox(height: 30),
                      AuthFooter(
                        prefix: 'Sudah punya akun?',
                        action: 'Masuk',
                        onTap: () => Navigator.of(context).pop(),
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

/// Label + field + area pesan error (tinggi total tetap 91px seperti desain,
/// jadi layout tidak bergeser saat error muncul).
class _FormBlock extends StatelessWidget {
  const _FormBlock({
    required this.label,
    required this.child,
    required this.error,
  });

  final String label;
  final Widget child;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 17,
          child: Text(label, style: inter(height: 1.214)),
        ),
        const SizedBox(height: 5),
        child,
        SizedBox(
          height: 23,
          child: Padding(
            padding: const EdgeInsets.only(top: 4, left: 20),
            child: error == null
                ? null
                : Text(
                    error!,
                    style: inter(size: 12, color: AppColors.error),
                  ),
          ),
        ),
      ],
    );
  }
}

/// Checkbox "Saya setuju dengan Syarat & Ketentuan".
class _AgreeRow extends StatelessWidget {
  const _AgreeRow({
    required this.checked,
    required this.hasError,
    required this.onTap,
  });

  final bool checked;
  final bool hasError;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            width: 13,
            height: 13,
            decoration: BoxDecoration(
              color: checked ? AppColors.green : AppColors.checkboxOff,
              borderRadius: BorderRadius.circular(3),
              border: hasError
                  ? Border.all(color: AppColors.error, width: 1.5)
                  : null,
            ),
            child: checked
                ? const Icon(Icons.check, size: 11, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 7),
          Text('Saya setuju dengan Syarat & Ketentuan', style: inter(size: 12)),
        ],
      ),
    );
  }
}
