import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import 'logo_data.dart';

Path _polygon(List<double> pts) {
  final path = Path()..moveTo(pts[0], pts[1]);
  for (var i = 2; i + 1 < pts.length; i += 2) {
    path.lineTo(pts[i], pts[i + 1]);
  }
  return path..close();
}

// ---------------------------------------------------------------------------
// Logo Tuurn (gelas + panah daur ulang)
// ---------------------------------------------------------------------------

class _LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 160, size.height / 200);
    final green = Paint()
      ..color = AppColors.brandGreen
      ..isAntiAlias = true;
    final yellow = Paint()
      ..color = AppColors.arrowYellow
      ..isAntiAlias = true;
    for (final s in kLogoGreenShapes) {
      canvas.drawPath(_polygon(s), green);
    }
    for (final s in kLogoYellowShapes) {
      canvas.drawPath(_polygon(s), yellow);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TuurnLogo extends StatelessWidget {
  const TuurnLogo({super.key, this.width = 160});

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: width * 200 / 160,
      child: CustomPaint(painter: _LogoPainter()),
    );
  }
}

// ---------------------------------------------------------------------------
// Badge centang (halaman sukses daftar)
// ---------------------------------------------------------------------------

class _BadgePainter extends CustomPainter {
  // Batas bentuk badge di dalam kotak trace (190x190).
  static const double _ox = 17.03;
  static const double _oy = 15.02;
  static const double _w = 157.82;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / _w, size.height / _w);
    canvas.translate(-_ox, -_oy);

    canvas.drawPath(
      _polygon(kBadgeOutline),
      Paint()
        ..color = AppColors.green
        ..isAntiAlias = true,
    );

    // Tanda centang putih (sudut tajam seperti desain).
    final check = Path()
      ..moveTo(70, 85.5)
      ..lineTo(88, 103)
      ..lineTo(125.75, 65.5)
      ..lineTo(137, 76.75)
      ..lineTo(88, 125.75)
      ..lineTo(58.75, 96.5)
      ..close();
    canvas.drawPath(check, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SuccessBadge extends StatelessWidget {
  const SuccessBadge({super.key, this.size = 158});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _BadgePainter()),
    );
  }
}

// ---------------------------------------------------------------------------
// Koin poin
// ---------------------------------------------------------------------------

class _CoinPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final r = size.width / 2;
    final c = Offset(r, r);

    // badan koin
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..shader = const RadialGradient(
          center: Alignment(-0.3, -0.35),
          radius: 1.0,
          colors: [Color(0xFFE9B792), Color(0xFFD39A72), Color(0xFFBE7C54)],
          stops: [0, 0.6, 1],
        ).createShader(Rect.fromCircle(center: c, radius: r)),
    );
    // cincin dalam
    canvas.drawCircle(
      c,
      r * 0.78,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = r * 0.09
        ..color = const Color(0xFFB7714A).withAlpha(150),
    );
    // simbol $
    final tp = TextPainter(
      text: TextSpan(
        text: r'$',
        style: TextStyle(
          fontSize: size.width * 0.66,
          fontWeight: FontWeight.w800,
          color: const Color(0xFFA9653D),
          height: 1,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(r - tp.width / 2, r - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PointCoin extends StatelessWidget {
  const PointCoin({super.key, this.size = 30});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _CoinPainter()),
    );
  }
}

// ---------------------------------------------------------------------------
// Ikon user & kunci (di dalam lingkaran kuning pada halaman login)
// ---------------------------------------------------------------------------

class _UserIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.dark;
    canvas.drawCircle(const Offset(12, 5.9), 5.9, paint);
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        const Rect.fromLTRB(0, 15, 24, 26.7),
        topLeft: const Radius.circular(11),
        topRight: const Radius.circular(11),
        bottomLeft: const Radius.circular(2.5),
        bottomRight: const Radius.circular(2.5),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class UserIcon extends StatelessWidget {
  const UserIcon({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 24,
        height: 27,
        child: CustomPaint(painter: _UserIconPainter()),
      );
}

class _KeyIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Kunci horizontal, lalu diputar -45 derajat.
    Path key = Path()..addOval(Rect.fromCircle(center: const Offset(7, 0), radius: 7));
    key = Path.combine(
      PathOperation.union,
      key,
      Path()
        ..addRRect(RRect.fromRectAndRadius(
          const Rect.fromLTRB(9, -2.6, 24, 2.6),
          const Radius.circular(1),
        )),
    );
    key = Path.combine(
      PathOperation.union,
      key,
      Path()
        ..addRect(const Rect.fromLTRB(15.5, 1, 19, 6.8))
        ..addRect(const Rect.fromLTRB(20.5, 1, 24, 6)),
    );
    key = Path.combine(
      PathOperation.difference,
      key,
      Path()..addOval(Rect.fromCircle(center: const Offset(7, 0), radius: 3)),
    );

    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(-math.pi / 4);
    canvas.translate(-12, 0.2);
    canvas.drawPath(key, Paint()..color = AppColors.dark);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class KeyIcon extends StatelessWidget {
  const KeyIcon({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 27,
        height: 27,
        child: CustomPaint(painter: _KeyIconPainter()),
      );
}

// ---------------------------------------------------------------------------
// Logo Google "G"
// ---------------------------------------------------------------------------

class _GoogleGPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final stroke = s * 0.2;
    final r = s / 2 - stroke / 2;
    final rect = Rect.fromCircle(center: Offset(s / 2, s / 2), radius: r);

    double rad(double deg) => deg * math.pi / 180;

    Paint arc(Color c) => Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = c
      ..isAntiAlias = true;

    canvas.drawArc(rect, rad(-145), rad(100), false, arc(const Color(0xFFEA4335)));
    canvas.drawArc(rect, rad(145), rad(70), false, arc(const Color(0xFFFBBC05)));
    canvas.drawArc(rect, rad(40), rad(105), false, arc(const Color(0xFF34A853)));
    canvas.drawArc(rect, rad(-2), rad(42), false, arc(const Color(0xFF4285F4)));
    canvas.drawRect(
      Rect.fromLTRB(s * 0.5, s * 0.415, s * 0.98, s * 0.585),
      Paint()..color = const Color(0xFF4285F4),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class GoogleG extends StatelessWidget {
  const GoogleG({super.key, this.size = 26});

  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: size,
        height: size,
        child: CustomPaint(painter: _GoogleGPainter()),
      );
}
