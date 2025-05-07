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
      backgroundColor: const Color(0xFFF2F8F2),
      appBar: AppBar(
        title: Text(
          'Добавление траты',
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
                      cursorColor: const Color(0xFF1E5319),
                      decoration: InputDecoration(
                        labelText: 'Название траты',
                        labelStyle: TextStyle(color: const Color(0xFF1E5319)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: const Color(0xFF1E5319)),
                        ),
                      ),
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
                      cursorColor: const Color(0xFF1E5319),
                      decoration: InputDecoration(
                        labelText: 'Сумма',
                        labelStyle: TextStyle(color: const Color(0xFF1E5319)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: const Color(0xFF1E5319)),
                        ),
                      ),
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
                        child: Text(
                          'Редактировать категории',
                          style: TextStyle(color: const Color(0xFF000000)),
                        ),
                      ),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Выберите категорию',
                      labelStyle: TextStyle(color: const Color(0xFF1E5319)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFF1E5319)),
                      ),
                    ),
                    style: TextStyle(
                      color: const Color(0xFF1E5319),
                    ),
                    dropdownColor: const Color(0xFFF2F8F2),
                  ),
                  SizedBox(height: 20),
                  CheckboxListTile(
                    title: Text(
                      'Использовать текущую дату',
                      style: TextStyle(
                        color: const Color(0xFF1E5319),
                      ),
                    ),
                    value: expenseViewModel.isDateVisible,
                    onChanged: (bool? value) {
                      expenseViewModel.changeDateVisible();
                    },
                    activeColor: Color(0xFF1E5319),
                  ),
                  if (!expenseViewModel.isDateVisible) ...[
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _dayController,
                            cursorColor: const Color(0xFF1E5319),
                            decoration: InputDecoration(
                              labelText: 'День',
                              labelStyle: TextStyle(color: const Color(0xFF1E5319)),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: const Color(0xFF1E5319)),
                              ),
                            ),
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
                            cursorColor: const Color(0xFF1E5319),
                            decoration: InputDecoration(
                              labelText: 'Месяц',
                              labelStyle: TextStyle(color: const Color(0xFF1E5319)),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: const Color(0xFF1E5319)),
                              ),
                            ),
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
                            cursorColor: const Color(0xFF1E5319),
                            decoration: InputDecoration(
                              labelText: 'Год',
                              labelStyle: TextStyle(color: const Color(0xFF1E5319)),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: const Color(0xFF1E5319)),
                              ),
                            ),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1E5319),
                      padding: EdgeInsets.all(22.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
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
                    child: Text(
                      'Добавить',
                      style: TextStyle(
                      color: Color(0xFFF2F8F2),
                      ),
                    ),
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