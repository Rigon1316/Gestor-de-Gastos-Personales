import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../providers/expense_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/quick_card.dart';
import '../widgets/gasto_tile.dart';
import '../widgets/empty_state.dart';
import 'agregar_gasto_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _abrirFormulario(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, a, __) => const AgregarGastoScreen(),
        transitionsBuilder: (_, a, __, child) => SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    final gastos = provider.expenses;
    final total = provider.totalBalance;
    final promedio = provider.promedioGasto;
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
                32,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [c.accent.withValues(alpha: 0.2), c.bg],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gestor de Gastos',
                    style: TextStyle(color: c.sec, fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Balance total',
                    style: TextStyle(color: c.sec, fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$${total.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: c.prim,
                      fontSize: 42,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 4,
                    width: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [c.accent, c.accent2]),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: QuickCard(
                      label: 'Máximo hoy',
                      value: '\$${provider.maxExpenseToday.toStringAsFixed(2)}',
                      icon: LineAwesomeIcons.arrow_up_solid,
                      color: const Color(0xFFFF6B6B),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: QuickCard(
                      label: 'Promedio',
                      value: '\$${promedio.toStringAsFixed(2)}',
                      icon: LineAwesomeIcons.chart_pie_solid,
                      color: const Color(0xFF4ECDC4),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: QuickCard(
                      label: 'Registros',
                      value: '${gastos.length}',
                      icon: LineAwesomeIcons.file_invoice_solid,
                      color: const Color(0xFFFFE66D),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Últimos gastos',
                    style: TextStyle(
                      color: c.prim,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '${gastos.length} total',
                    style: TextStyle(color: c.sec, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
          gastos.isEmpty
              ? const SliverToBoxAdapter(child: EmptyState())
              : SliverList(
                  delegate: SliverChildBuilderDelegate((ctx, i) {
                    final g = gastos[gastos.length - 1 - i];
                    return GastoTile(
                      gasto: g,
                      onDelete: () =>
                          context.read<ExpenseProvider>().deleteExpense(g.id),
                    );
                  }, childCount: gastos.length),
                ),
          const SliverToBoxAdapter(child: SizedBox(height: 110)),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () => _abrirFormulario(context),
        child: Container(
          height: 58,
          padding: const EdgeInsets.symmetric(horizontal: 28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [c.accent, const Color(0xFF9B8FFF)],
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: c.accent.withValues(alpha: 0.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(LineAwesomeIcons.plus_solid, color: Colors.white, size: 22),
              SizedBox(width: 8),
              Text(
                'Nuevo gasto',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
