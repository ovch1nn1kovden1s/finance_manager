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
        future: Future.microtask(() => expenseViewModel.getAllUsedCategories()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading'));
          } else {
            return Consumer<ExpenseViewModel>(
              builder: (context, expenseViewModel, child) {
                return ListView.builder(
                  itemCount: expenseViewModel.categories.length,
                  itemBuilder: (context, index) {
                    final category = expenseViewModel.categories[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          GoRouter.of(context).go('/by_category/${category.name}');
                        },
                        child: Text(category.name)
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