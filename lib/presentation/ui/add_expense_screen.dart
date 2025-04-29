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
                  PopupMenuButton<Category>(
                    onSelected: (category) {
                      if (category.name == 'addNewCategory') {
                        context.go('/add_category');
                      } else {
                        _selectedCategory = category;
                        categoryViewModel.notify();
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        ...categoryViewModel.categories.map((category) {
                          return PopupMenuItem<Category>(
                            value: category,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(category.name),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    categoryViewModel.deleteCategory(category.name);
                                    categoryViewModel.loadCategories();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        PopupMenuItem<Category>(
                          value: Category(name: 'addNewCategory'),
                          child: Text('Добавить категорию'),
                        ),
                      ];
                    },
                    child: ListTile(
                      title: Text(_selectedCategory?.name ?? 'Выберите категорию'),
                    ),
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