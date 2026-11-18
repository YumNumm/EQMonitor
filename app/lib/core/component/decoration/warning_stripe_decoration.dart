import 'package:material_ui/material_ui.dart';

class const WarningStripeDecoration({
  required final List<Color> colors,
  super.key,
  final double height = 8.0,
  final double stripeWidth = 8.0,
}) extends StatelessWidget {
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

class _StripePainter({
  required final List<Color> colors,
  required final double stripeWidth,
}) extends CustomPainter {
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
