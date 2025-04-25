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
    final expenseViewModel = Provider.of<ExpenseViewModel>(context, listen: false);

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
      body: FutureBuilder(
        future: Future.microtask(() => expenseViewModel.loadExpenses()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading'));
          } else {
            return Text('Expenses');
          }
        }
      ),
    );
  }
}