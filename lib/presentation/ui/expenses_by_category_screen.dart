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
      backgroundColor: const Color(0xFFD5D5D5),
      appBar: AppBar(
        title: Text(
          category_name,
          style: TextStyle(
            color: const Color(0xFF68C060),
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: const Color(0xFF68C060),
          onPressed: () {
            context.go('/');
          },
        ),
        backgroundColor: const Color(0xFF1E5319),
      ),
      body: Consumer<ExpenseViewModel>(
        builder: (context, expenseViewModel, child) {
          return ListView.builder(
            itemCount: expenseViewModel.expensesByCategoryAndMonth.length,
            itemBuilder: (context, index) {
              final expense = expenseViewModel.expensesByCategoryAndMonth[index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFF2F8F2),
                  ),
                  child: ListTile(
                    title: Text(
                      expense.name,
                      style: TextStyle(
                        color: const Color(0xFF1E5319),
                      ),
                    ),
                    subtitle: Text('Сумма - ${expense.amount}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        expenseViewModel.deleteExpense(expense.id);
                        expenseViewModel.getExpensesByCategoryAndMonth(category_name);
                      },
                      color: const Color(0xFF1E5319),
                    ),
                  ),
                )
              );
            },
          );
        },
      ),
    );
  }
}