import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/category.dart';
import '../theme/app_theme.dart';

class DonutChart extends StatelessWidget {
  final Map<String, double> data;
  final double total;
  const DonutChart({super.key, required this.data, required this.total});
  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return CustomPaint(
      painter: DonutPainter(data: data, total: total),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Total', style: TextStyle(color: c.sec, fontSize: 12)),
            Text(
              '\$${total.toStringAsFixed(0)}',
              style: TextStyle(
                color: c.prim,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DonutPainter extends CustomPainter {
  final Map<String, double> data;
  final double total;
  const DonutPainter({required this.data, required this.total});
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = math.min(cx, cy) - 10;
    final innerR = r * 0.58;
    double startAngle = -math.pi / 2;
    for (final e in data.entries) {
      final cat = catInfo(e.key);
      final sweep = (e.value / total) * 2 * math.pi;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(cx, cy), radius: (r + innerR) / 2),
        startAngle + 0.03,
        sweep - 0.06,
        false,
        Paint()
          ..color = cat.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = r - innerR
          ..strokeCap = StrokeCap.butt,
      );
      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(DonutPainter old) => old.data != data;
}
