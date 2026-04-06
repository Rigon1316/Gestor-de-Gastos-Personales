import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../theme/app_theme.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: c.accent.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              LineAwesomeIcons.file_invoice_dollar_solid,
              color: c.accent,
              size: 36,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Sin gastos registrados',
            style: TextStyle(
              color: c.prim,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Toca + para agregar tu primer gasto',
            style: TextStyle(color: c.sec, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
