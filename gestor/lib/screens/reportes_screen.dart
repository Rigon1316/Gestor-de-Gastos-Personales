import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../models/category.dart';
import '../theme/app_theme.dart';
import '../widgets/donut_chart.dart';

class ReportesScreen extends StatelessWidget {
  const ReportesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    final data = provider.categoryTotals;
    final pcts = provider.categoryExpensePercentages;
    final total = provider.totalBalance;
    final c = context.colors;

    return Scaffold(
      backgroundColor: c.bg,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.fromLTRB(
                20,
                MediaQuery.of(context).padding.top + 20,
                20,
                24,
              ),
              color: c.surface,
              child: Text(
                'Reportes',
                style: TextStyle(
                  color: c.prim,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: c.card,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: c.div),
                ),
                child: Column(
                  children: [
                    Text(
                      'Distribución por categoría',
                      style: TextStyle(
                        color: c.prim,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 24),
                    provider.expenses.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              'Sin datos aún',
                              style: TextStyle(color: c.sec, fontSize: 14),
                            ),
                          )
                        : SizedBox(
                            height: 200,
                            child: DonutChart(data: data, total: total),
                          ),
                  ],
                ),
              ),
            ),
          ),
          if (data.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: c.card,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: c.div),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detalle por categoría',
                        style: TextStyle(
                          color: c.prim,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ...data.entries.map((e) {
                        final cat = catInfo(e.key);
                        final pct = (pcts[e.key] ?? 0) / 100;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: cat.color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      e.key,
                                      style: TextStyle(
                                        color: c.prim,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '\$${e.value.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: cat.color,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${(pct * 100).toStringAsFixed(0)}%',
                                    style: TextStyle(
                                      color: c.sec,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: pct,
                                  backgroundColor: cat.color.withValues(alpha: 0.1),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    cat.color,
                                  ),
                                  minHeight: 6,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}
