import 'package:flutter/material.dart';

/// Satu "glow" (gradasi radial lembut) pada background.
class GlowSpec {
  const GlowSpec({
    required this.center,
    required this.rx,
    required this.ry,
    required this.color,
    required this.profile,
  });

  /// Posisi pusat glow, dihitung dari ukuran layar.
  final Offset Function(Size size) center;
  final double rx;
  final double ry;
  final Color color;

  /// Daftar [jarak ternormalisasi 0..1, opacity].
  final List<List<double>> profile;
}

const List<List<double>> _yellowProfile = [
  [0, 1], [.1, .95], [.27, .8], [.4, .63], [.57, .37], [.73, .18], [.9, .05], [1, 0],
];
const List<List<double>> _yellowWideProfile = [
  [0, 1], [.09, .97], [.27, .76], [.45, .43], [.64, .19], [.82, .05], [1, 0],
];
const List<List<double>> _greenBottomProfile = [
  [0, 1], [.1, .97], [.23, .82], [.45, .55], [.66, .2], [.875, .06], [1, 0],
];
const List<List<double>> _greenTopProfile = [
  [0, 1], [.1, .97], [.25, .88], [.4, .68], [.55, .45], [.7, .27], [.85, .1], [1, 0],
];
const List<List<double>> _greenSuccessProfile = [
  [0, 1], [.1, .9], [.25, .72], [.4, .55], [.5, .45], [.65, .25], [.8, .1], [1, 0],
];

const Color _yellowGlow = Color(0xFFFDEEAE);
const Color _greenGlow = Color(0xFFE0FDE2);

/// Preset background untuk tiap halaman (sesuai desain).
class GlowPresets {
  GlowPresets._();

  static final List<GlowSpec> login = [
    GlowSpec(
      center: (s) => Offset(s.width - 92, 60),
      rx: 300,
      ry: 300,
      color: _yellowGlow,
      profile: _yellowProfile,
    ),
    GlowSpec(
      center: (s) => Offset(70, s.height - 132),
      rx: 360,
      ry: 270,
      color: _greenGlow,
      profile: _greenBottomProfile,
    ),
  ];

  static final List<GlowSpec> register = [
    GlowSpec(
      center: (s) => const Offset(70, 0),
      rx: 290,
      ry: 340,
      color: _greenGlow,
      profile: _greenTopProfile,
    ),
    GlowSpec(
      center: (s) => Offset(s.width + 28, 510),
      rx: 330,
      ry: 330,
      color: _yellowGlow,
      profile: _yellowWideProfile,
    ),
  ];

  static final List<GlowSpec> success = [
    GlowSpec(
      center: (s) => Offset(s.width - 92, 30),
      rx: 300,
      ry: 300,
      color: _yellowGlow,
      profile: _yellowProfile,
    ),
    GlowSpec(
      center: (s) => Offset(85, s.height - 217),
      rx: 330,
      ry: 330,
      color: _greenGlow,
      profile: _greenSuccessProfile,
    ),
  ];
}

class _GlowPainter extends CustomPainter {
  _GlowPainter(this.glows);

  final List<GlowSpec> glows;

  @override
  void paint(Canvas canvas, Size size) {
    for (final g in glows) {
      final c = g.center(size);
      final shader = RadialGradient(
        colors: [
          for (final p in g.profile)
            g.color.withAlpha((p[1] * 255).round().clamp(0, 255)),
        ],
        stops: [for (final p in g.profile) p[0]],
      ).createShader(Rect.fromCircle(center: Offset.zero, radius: 1));

      canvas.save();
      canvas.translate(c.dx, c.dy);
      canvas.scale(g.rx, g.ry);
      canvas.drawCircle(Offset.zero, 1, Paint()..shader = shader);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _GlowPainter oldDelegate) =>
      oldDelegate.glows != glows;
}

/// Background putih dengan glow kuning / hijau.
class GlowBackground extends StatelessWidget {
  const GlowBackground({super.key, required this.glows, required this.child});

  final List<GlowSpec> glows;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Colors.white),
        CustomPaint(painter: _GlowPainter(glows)),
        child,
      ],
    );
  }
}
