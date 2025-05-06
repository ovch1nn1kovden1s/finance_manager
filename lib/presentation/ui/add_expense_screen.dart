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
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _amountController = TextEditingController();
    Category? _selectedCategory;
    final _yearController = TextEditingController();
    final _monthController = TextEditingController();
    final _dayController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Добавление траты'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: Consumer2<CategoryViewModel, ExpenseViewModel>(
        builder: (context, categoryViewModel, expenseViewModel, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Название траты'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Пожалуйста, введите название траты';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    child: TextFormField(
                      controller: _amountController,
                      decoration: InputDecoration(labelText: 'Сумма'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Пожалуйста, введите сумму';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Пожалуйста, введите корректное число';
                        }
                        return null;
                      },
                    ),
                  ),
                  DropdownButtonFormField<Category>(
                    value: _selectedCategory,
                    onChanged: (category) {
                      if (category != null) {
                        if (category.name == 'addNewCategory') {
                          context.go('/add_category');
                        } else {
                          _selectedCategory = category;
                        }
                      }
                    },
                    items: [
                      ...categoryViewModel.categories.map((category) {
                        return DropdownMenuItem<Category>(
                          value: category,
                          child: Text(category.name),
                        );
                      }).toList(),
                      DropdownMenuItem<Category>(
                        value: Category(name: 'addNewCategory', color: 0xFF000000),
                        child: Text('Редактировать категории'),
                      ),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Выберите категорию',
                    ),
                  ),
                  SizedBox(height: 20),
                  CheckboxListTile(
                    title: Text('Использовать текущую дату'),
                    value: expenseViewModel.isDateVisible,
                    onChanged: (bool? value) {
                      expenseViewModel.changeDateVisible();
                    },
                  ),
                  if (!expenseViewModel.isDateVisible) ...[
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _dayController,
                            decoration: InputDecoration(labelText: 'День'),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Пожалуйста, введите день';
                              }
                              final day = double.tryParse(value);
                              if (day == null) {
                                return 'Пожалуйста, введите корректное число';
                              }
                              if (day < 1 || day > 31) {
                                return 'День должен быть от 1 до 31';
                              }
                              return null;
                            },
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _monthController,
                            decoration: InputDecoration(labelText: 'Месяц'),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Пожалуйста, введите месяц';
                              }
                              final month = double.tryParse(value);
                              if (month == null) {
                                return 'Пожалуйста, введите корректное число';
                              }
                              if (month < 1 || month > 12) {
                                return 'Месяц должен быть от 1 до 12';
                              }
                              return null;
                            },
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _yearController,
                            decoration: InputDecoration(labelText: 'Год'),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Пожалуйста, введите год';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Пожалуйста, введите корректное число';
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final name = _nameController.text;
                        final amount = double.parse(_amountController.text);

                        if (!expenseViewModel.isDateVisible) {
                          final day = int.parse(_dayController.text);
                          final month = int.parse(_monthController.text);
                          final year = int.parse(_yearController.text);

                          expenseViewModel.addOrUpdateExpense(
                            Expense(
                              id: Uuid().v4(),
                              name: name,
                              amount: amount,
                              date: DateTime(year, month, day),
                              category: _selectedCategory!,
                            ),
                          );
                        } else {
                          expenseViewModel.addOrUpdateExpense(
                            Expense(
                              id: Uuid().v4(),
                              name: name,
                              amount: amount,
                              date: DateTime.now(),
                              category: _selectedCategory!,
                            ),
                          );
                        }

                        context.go('/');
                      }
                    },
                    child: Text('Добавить'),
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