import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../models/expense.dart';
import '../models/category.dart';
import '../providers/expense_provider.dart';
import '../theme/app_theme.dart';

class AgregarGastoScreen extends StatefulWidget {
  const AgregarGastoScreen({super.key});
  @override
  State<AgregarGastoScreen> createState() => _AgregarGastoScreenState();
}

class _AgregarGastoScreenState extends State<AgregarGastoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloCtrl = TextEditingController();
  final _montoCtrl = TextEditingController();
  CatInfo _catSel = categorias[0];

  @override
  void dispose() {
    _tituloCtrl.dispose();
    _montoCtrl.dispose();
    super.dispose();
  }

  void _guardar() {
    if (_formKey.currentState!.validate()) {
      context.read<ExpenseProvider>().addExpense(
        Expense(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          titulo: _tituloCtrl.text.trim(),
          monto: double.parse(_montoCtrl.text.trim()),
          fecha: DateTime.now(),
          categoria: _catSel.nombre,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    
    return Scaffold(
      backgroundColor: c.bg,
      appBar: AppBar(
        backgroundColor: c.surface,
        elevation: 0,
        title: Text(
          'Nuevo Gasto',
          style: TextStyle(
            color: c.prim,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: Icon(LineAwesomeIcons.times_solid, color: c.sec),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: c.card,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: c.div),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MONTO',
                      style: TextStyle(
                        color: c.sec,
                        fontSize: 11,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _montoCtrl,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      style: TextStyle(
                        color: c.prim,
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '0.00',
                        hintStyle: TextStyle(
                          color: c.sec,
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                        ),
                        prefixText: '\$ ',
                        prefixStyle: TextStyle(
                          color: c.accent,
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty)
                          return 'Ingresa un monto';
                        if (double.tryParse(v.trim()) == null ||
                            double.parse(v.trim()) <= 0)
                          return 'Monto inválido';
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'DESCRIPCIÓN',
                style: TextStyle(color: c.sec, fontSize: 11, letterSpacing: 1.5),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _tituloCtrl,
                style: TextStyle(color: c.prim, fontSize: 15),
                decoration: InputDecoration(
                  hintText: 'Ej: Almuerzo, Taxi, Netflix...',
                  hintStyle: TextStyle(color: c.sec),
                  prefixIcon: Icon(
                    LineAwesomeIcons.pen_solid,
                    color: c.sec,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: c.card,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: c.div),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: c.div),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: c.accent, width: 1.5),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xFFFF6B6B)),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFFFF6B6B),
                      width: 1.5,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Ingresa una descripción'
                    : null,
              ),
              const SizedBox(height: 24),
              Text(
                'CATEGORÍA',
                style: TextStyle(color: c.sec, fontSize: 11, letterSpacing: 1.5),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.5,
                ),
                itemCount: categorias.length,
                itemBuilder: (_, i) {
                  final cat = categorias[i];
                  final sel = cat.nombre == _catSel.nombre;
                  return GestureDetector(
                    onTap: () => setState(() => _catSel = cat),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: cat.color.withValues(alpha: sel ? 1.0 : 0.6),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: sel ? Colors.white : Colors.transparent,
                          width: sel ? 2 : 0,
                        ),
                        boxShadow: sel
                            ? [
                                BoxShadow(
                                  color: cat.color.withValues(alpha: 0.5),
                                  blurRadius: 15,
                                  offset: const Offset(0, 6),
                                )
                              ]
                            : [],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.25),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  cat.icono,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                              if (sel)
                                const Icon(
                                  LineAwesomeIcons.check_circle_solid,
                                  color: Colors.white,
                                  size: 24,
                                ),
                            ],
                          ),
                          Text(
                            cat.nombre,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: sel ? 1.0 : 0.8),
                              fontSize: 15,
                              fontWeight: sel ? FontWeight.w700 : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: GestureDetector(
                  onTap: _guardar,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [c.accent, const Color(0xFF9B8FFF)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: c.accent.withValues(alpha: 0.35),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Guardar Gasto',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: c.div),
                    ),
                  ),
                  child: Text(
                    'Cancelar',
                    style: TextStyle(color: c.sec, fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
