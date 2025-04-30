import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../view_models/expenses_view_model.dart';
import 'package:provider/provider.dart';

class ExpensesByCategoryScreen extends StatelessWidget{
  final String category_name;

  ExpensesByCategoryScreen({required this.category_name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category_name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: Consumer<ExpenseViewModel>(
        builder: (context, expenseViewModel, child) {
          return ListView.builder(
            itemCount: expenseViewModel.expensesByCategoryAndMonth.length,
            itemBuilder: (context, index) {
              final expense = expenseViewModel.expensesByCategoryAndMonth[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(expense.name),
                  subtitle: Text('Сумма - ${expense.amount}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      expenseViewModel.deleteExpense(expense.id);
                      expenseViewModel.getExpensesByCategoryAndMonth(category_name);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}