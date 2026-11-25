/// Data user yang tersimpan (sementara di memori).
class AppUser {
  const AppUser({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  final String name;
  final String email;
  final String phone;
  final String password;

  /// Nama depan, dipakai untuk sapaan.
  String get firstName {
    final parts = name.trim().split(RegExp(r'\s+'));
    return parts.isEmpty ? name : parts.first;
  }
}

/// Penyimpanan user sederhana di memori.
/// Data hilang saat aplikasi ditutup. Ganti dengan API / database bila perlu.
class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();

  final List<AppUser> _users = [];

  bool emailExists(String email) {
    final e = email.trim().toLowerCase();
    return _users.any((u) => u.email.toLowerCase() == e);
  }

  void register(AppUser user) => _users.add(user);

  /// Login dengan email atau username (nama lengkap) + password.
  /// Mengembalikan `null` jika data tidak ada / salah.
  AppUser? login(String identifier, String password) {
    final id = identifier.trim().toLowerCase();
    if (id.isEmpty || password.isEmpty) return null;
    for (final u in _users) {
      final match = u.email.toLowerCase() == id || u.name.toLowerCase() == id;
      if (match && u.password == password) return u;
    }
    return null;
  }
}
