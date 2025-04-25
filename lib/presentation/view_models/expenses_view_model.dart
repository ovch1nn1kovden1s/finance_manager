import 'package:finance_manger/data/repositories/expense_repository.dart';
import 'package:finance_manger/models/category.dart';
import 'package:flutter/material.dart';
import '../../models/expense.dart';

class ExpenseViewModel extends ChangeNotifier {
  final ExpenseRepository repository;
  List<Expense> _expenses = [];
  List<Category> _categories = [];

  ExpenseViewModel(this.repository);

  List<Expense> get expenses => _expenses;
  List<Category> get categories => _categories;

  void loadExpenses() {
    _expenses = repository.getAllExpenses();
    notifyListeners();
  }

  void getAllUsedCategories() {
    _categories = repository.getAllUsedCategories();
    notifyListeners();
  }

  void getExpensesByCategory(Category category) {
    repository.getExpensesByCategory(category);
  }

  Future<void> addOrUpdateExpense(Expense expense) async {
    await repository.addOrUpdateExpense(expense);
  }

  Future<void> deleteExpense(String id) async {
    await repository.deleteExpense(id);
  }
}