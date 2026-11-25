import 'package:flutter_test/flutter_test.dart';
import 'package:tuurn1/core/validators.dart';
import 'package:tuurn1/services/auth_service.dart';

void main() {
  group('Validators', () {
    test('nama minimal 3 karakter', () {
      expect(Validators.name('ab'), 'Nama minimal 3 karakter');
      expect(Validators.name('  a '), 'Nama minimal 3 karakter');
      expect(Validators.name('Eni'), isNull);
    });

    test('format email', () {
      expect(Validators.email('abc'), 'Format email tidak valid');
      expect(Validators.email('abc@'), 'Format email tidak valid');
      expect(Validators.email('abc@gmail'), 'Format email tidak valid');
      expect(Validators.email('nama@gmail.com'), isNull);
    });

    test('no hp lengkap', () {
      expect(Validators.phone('0812'), 'No HP tidak lengkap');
      expect(Validators.phone(''), 'No HP tidak lengkap');
      expect(Validators.phone('081234567890'), isNull);
      expect(Validators.phone('+6281234567890'), isNull);
    });

    test('password minimal 8 karakter', () {
      expect(Validators.password('1234567'), 'Password minimal 8 karakter');
      expect(Validators.password('12345678'), isNull);
    });

    test('konfirmasi password', () {
      expect(
        Validators.confirmPassword('12345678', '1234567'),
        'Password tidak sama',
      );
      expect(Validators.confirmPassword('12345678', ''), 'Password tidak sama');
      expect(Validators.confirmPassword('12345678', '12345678'), isNull);
    });
  });

  group('AuthService', () {
    test('login gagal jika data belum ada, berhasil setelah register', () {
      final auth = AuthService.instance;
      expect(auth.login('nama@gmail.com', '12345678'), isNull);

      auth.register(const AppUser(
        name: 'Enjel Putri',
        email: 'nama@gmail.com',
        phone: '081234567890',
        password: '12345678',
      ));

      expect(auth.login('nama@gmail.com', 'salahsalah'), isNull);
      expect(auth.login('NAMA@gmail.com', '12345678')?.firstName, 'Enjel');
      expect(auth.emailExists('nama@gmail.com'), isTrue);
    });
  });
}
