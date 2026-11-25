/// Validasi form. Mengembalikan pesan error, atau `null` jika valid.
class Validators {
  Validators._();

  static final RegExp _emailRegex = RegExp(
    r'^[A-Za-z0-9._%+\-]+@[A-Za-z0-9\-]+(\.[A-Za-z0-9\-]+)*\.[A-Za-z]{2,}$',
  );

  // 08xxxxxxxxxx / 628xxxxxxxxxx / +628xxxxxxxxxx (10-13 digit setelah awalan)
  static final RegExp _phoneRegex = RegExp(r'^(\+62|62|0)8\d{8,11}$');

  static String? name(String value) {
    return value.trim().length >= 3 ? null : 'Nama minimal 3 karakter';
  }

  static String? email(String value) {
    return _emailRegex.hasMatch(value.trim()) ? null : 'Format email tidak valid';
  }

  static String? phone(String value) {
    final cleaned = value.replaceAll(RegExp(r'[\s\-]'), '');
    return _phoneRegex.hasMatch(cleaned) ? null : 'No HP tidak lengkap';
  }

  static String? password(String value) {
    return value.length >= 8 ? null : 'Password minimal 8 karakter';
  }

  static String? confirmPassword(String password, String confirm) {
    return (confirm.isNotEmpty && confirm == password)
        ? null
        : 'Password tidak sama';
  }
}
