import '../../models/category.dart';
import '../../models/expense.dart';
import '../../presentation/view_models/category_view_model.dart';
import '../../presentation/view_models/expenses_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class AddExpenseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expenseViewModel = Provider.of<ExpenseViewModel>(context, listen: false);
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _amountController = TextEditingController();
    Category? _selectedCategory;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add expense'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: Consumer<CategoryViewModel>(
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
                  DropdownButtonFormField<Category>(
                    decoration: InputDecoration(labelText: 'Выберите категорию'),
                    value: _selectedCategory,
                    items: [
                      ...categoryViewModel.categories.map((category) {
                        return DropdownMenuItem<Category>(
                          value: category,
                          child: Text(category.name),
                        );
                      }).toList(),
                      DropdownMenuItem<Category>(
                        value: Category(name: 'addNewCategory'),
                        child: Text('Добавить категорию'),
                      ),
                    ],
                    onChanged: (newValue) {
                      if (newValue?.name == 'addNewCategory') {
                        context.go('/add_category');
                      } else {
                        _selectedCategory = newValue;
                      }
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Пожалуйста, выберите категорию';
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
                            category: _selectedCategory!,
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
      ),
    );
  }
}