class Expense {
  final String id;
  final String titulo;
  final double monto;
  final DateTime fecha;
  final String categoria;

  Expense({
    required this.id,
    required this.titulo,
    required this.monto,
    required this.fecha,
    required this.categoria,
  });

  Expense copyWith({
    String? id,
    String? titulo,
    double? monto,
    DateTime? fecha,
    String? categoria,
  }) {
    return Expense(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      monto: monto ?? this.monto,
      fecha: fecha ?? this.fecha,
      categoria: categoria ?? this.categoria,
    );
  }
}
