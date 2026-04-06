import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseProvider with ChangeNotifier {
  final List<Expense> _expenses = [];

  List<Expense> get expenses => [..._expenses];

  // Manejo de la Lista Global
  void addExpense(Expense expense) {
    _expenses.add(expense);
    notifyListeners();
  }

  void updateExpense(String id, Expense updatedExpense) {
    final index = _expenses.indexWhere((expense) => expense.id == id);
    if (index >= 0) {
      _expenses[index] = updatedExpense;
      notifyListeners();
    }
  }

  void deleteExpense(String id) {
    _expenses.removeWhere((expense) => expense.id == id);
    notifyListeners();
  }

  // Lógica de Cálculos
  double get totalBalance {
    return _expenses.fold(0.0, (sum, item) => sum + item.monto);
  }

  double get maxExpenseToday {
    final now = DateTime.now();
    final todayExpenses = _expenses.where((expense) {
      return expense.fecha.year == now.year &&
          expense.fecha.month == now.month &&
          expense.fecha.day == now.day;
    }).toList();

    if (todayExpenses.isEmpty) return 0.0;

    return todayExpenses
        .map((e) => e.monto)
        .reduce((value, element) => value > element ? value : element);
  }

  double get promedioGasto {
    if (_expenses.isEmpty) return 0.0;
    return totalBalance / _expenses.length;
  }

  Map<String, double> get categoryTotals {
    if (_expenses.isEmpty) return {};
    final Map<String, double> totals = {};
    for (var expense in _expenses) {
      totals[expense.categoria] =
          (totals[expense.categoria] ?? 0) + expense.monto;
    }
    return totals;
  }

  Map<String, double> get categoryExpensePercentages {
    final totals = categoryTotals;
    if (totals.isEmpty) return {};

    final total = totalBalance;
    if (total == 0) return {};

    final Map<String, double> percentages = {};
    totals.forEach((categoria, amount) {
      percentages[categoria] = (amount / total) * 100;
    });

    return percentages;
  }
}
