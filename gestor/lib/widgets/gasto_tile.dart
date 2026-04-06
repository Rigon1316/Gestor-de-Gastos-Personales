import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../models/expense.dart';
import '../models/category.dart';
import '../theme/app_theme.dart';

class GastoTile extends StatelessWidget {
  final Expense gasto;
  final VoidCallback onDelete;
  
  const GastoTile({super.key, required this.gasto, required this.onDelete});
  
  @override
  Widget build(BuildContext context) {
    final cat = catInfo(gasto.categoria);
    final c = context.colors;
    return Dismissible(
      key: Key(gasto.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        decoration: BoxDecoration(
          color: const Color(0xFFFF6B6B).withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          LineAwesomeIcons.trash_solid,
          color: Color(0xFFFF6B6B),
          size: 24,
        ),
      ),
      onDismissed: (_) => onDelete(),
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: c.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: c.div),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: cat.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(cat.icono, color: cat.color, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    gasto.titulo,
                    style: TextStyle(
                      color: c.prim,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    gasto.categoria,
                    style: TextStyle(color: c.sec, fontSize: 12),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${gasto.monto.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: cat.color,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${gasto.fecha.day}/${gasto.fecha.month}',
                  style: TextStyle(color: c.sec, fontSize: 11),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
