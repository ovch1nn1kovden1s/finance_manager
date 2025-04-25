import 'package:finance_manger/models/category.dart';
import 'package:finance_manger/models/expense.dart';
import 'package:finance_manger/presentation/view_models/category_view_model.dart';
import 'package:finance_manger/presentation/view_models/expenses_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class AddExpenseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryViewModel = Provider.of<CategoryViewModel>(context, listen: false);
    final expenseViewModel = Provider.of<ExpenseViewModel>(context, listen: false);
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _amountController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: FutureBuilder(
        future: Future.microtask(() => categoryViewModel.loadCategories()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading'));
          } else {
            return Consumer<CategoryViewModel>(
              builder: (context, categoryViewModel, child) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(labelText: 'Expense Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _amountController,
                          decoration: InputDecoration(labelText: 'Amount'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an amount';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final name = _nameController.text;
                              final amount = double.parse(_amountController.text);

                              expenseViewModel.addOrUpdateExpense(
                                Expense(
                                  id: Uuid().v4(),
                                  name: name,
                                  amount: amount,
                                  date: DateTime.now(),
                                  category: Category(name: 'Транспорт'),
                                ),
                              );

                              context.go('/');
                            }
                          },
                          child: Text('Add Expense'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}