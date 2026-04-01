import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/expense_provider.dart';
import 'models/expense.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExpenseProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de Gastos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const MyHomePage(title: 'Demo Provider de Gastos'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // Usamos watch para escuchar los cambios en el provider y redibujar la pantalla
    final expenseProvider = context.watch<ExpenseProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Balance Total:', style: TextStyle(fontSize: 20)),
            Text(
              '\$${expenseProvider.totalBalance.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 20),
            const Text('Gasto Máximo Hoy:'),
            Text(
              '\$${expenseProvider.maxExpenseToday.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Text('Gastos Registrados: ${expenseProvider.expenses.length}'),
            const SizedBox(height: 10),
            if (expenseProvider.categoryExpensePercentages.isNotEmpty)
              ...expenseProvider.categoryExpensePercentages.entries.map((e) => 
                Text('${e.key}: ${e.value.toStringAsFixed(1)}%')
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Usamos read() para ejecutar un evento sin poner a escuchar al widget entero de nuevo.
          // Agregamos un gasto de prueba simulado.
          final newExpense = Expense(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: 'Ejemplo Comida',
            amount: 15.50 + (DateTime.now().second % 10), // cantidad random
            date: DateTime.now(),
            category: 'Comida',
          );
          
          context.read<ExpenseProvider>().addExpense(newExpense);
        },
        tooltip: 'Añadir gasto manual',
        child: const Icon(Icons.add),
      ),
    );
  }
}
