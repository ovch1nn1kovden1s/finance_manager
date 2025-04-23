import 'package:finance_manger/presentation/view_models/expenses_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class ExpensesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expenseViewModel = Provider.of<ExpenseViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
      ),
      body: FutureBuilder(
        future: Future.microtask(() => expenseViewModel.loadExpenses()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading expenses'));
          } else {
            return Consumer<ExpenseViewModel>(
              builder: (context, expenseViewModel, child) {
                return ListView.builder(
                  itemCount: expenseViewModel.expenses.length,
                  itemBuilder: (context, index) {
                    final expense = expenseViewModel.expenses[index];
                    return ListTile(
                      title: Text(expense.name),
                      subtitle: Text('${expense.amount}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          expenseViewModel.deleteExpense(expense.id);
                        }
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/add');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}