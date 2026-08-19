import 'package:material_ui/material_ui.dart';

class WarningStripeDecoration extends StatelessWidget {
  const new({
    required this.colors,
    super.key,
    this.height = 8.0,
    this.stripeWidth = 8.0,
  });

  final List<Color> colors;
  final double height;
  final double stripeWidth;

  @override
  Widget build(BuildContext context) {
    if (colors.isEmpty) {
      return SizedBox(height: height);
    }
    return CustomPaint(
      painter: _StripePainter(colors: colors, stripeWidth: stripeWidth),
      size: Size(double.infinity, height),
    );
  }
}

class _StripePainter extends CustomPainter {
  new({required this.colors, required this.stripeWidth});

  final List<Color> colors;
  final double stripeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height;
    final totalWidth = size.width + h * 2;
    var x = -h;
    while (x < totalWidth) {
      final path = Path()
        ..moveTo(x, h)
        ..lineTo(x + stripeWidth, h)
        ..lineTo(x + h + stripeWidth, 0)
        ..lineTo(x + h, 0)
        ..close();
      final colorIndex = ((x + h) / stripeWidth).floor().abs() % colors.length;
      final paint = Paint()..color = colors[colorIndex];
      canvas.drawPath(path, paint);
      x += stripeWidth;
    }
  }

  @override
  bool shouldRepaint(covariant _StripePainter oldDelegate) =>
      oldDelegate.colors != colors || oldDelegate.stripeWidth != stripeWidth;
}
