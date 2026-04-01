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
    return _expenses.fold(0.0, (sum, item) => sum + item.amount);
  }

  double get maxExpenseToday {
    final now = DateTime.now();
    final todayExpenses = _expenses.where((expense) {
      return expense.date.year == now.year &&
             expense.date.month == now.month &&
             expense.date.day == now.day;
    }).toList();

    if (todayExpenses.isEmpty) return 0.0;

    return todayExpenses
        .map((e) => e.amount)
        .reduce((value, element) => value > element ? value : element);
  }

  Map<String, double> get categoryExpensePercentages {
    if (_expenses.isEmpty) return {};

    final Map<String, double> categoryTotals = {};
    for (var expense in _expenses) {
      if (categoryTotals.containsKey(expense.category)) {
        categoryTotals[expense.category] = categoryTotals[expense.category]! + expense.amount;
      } else {
        categoryTotals[expense.category] = expense.amount;
      }
    }

    final total = totalBalance;
    if (total == 0) return {};

    final Map<String, double> percentages = {};
    categoryTotals.forEach((category, amount) {
      percentages[category] = (amount / total) * 100;
    });

    return percentages;
  }
}
