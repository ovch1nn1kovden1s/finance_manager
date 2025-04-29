import '../../data/repositories/expense_repository.dart';
import 'package:flutter/material.dart';
import '../../models/expense.dart';

class ExpenseViewModel extends ChangeNotifier {
  final ExpenseRepository repository;
  List<Expense> _expenses = [];
  List<String> _categories = [];
  List<Expense> _expensesByCategory = [];
  DateTime _currentScreenDateTime = DateTime.now();

  ExpenseViewModel(this.repository);

  List<Expense> get expenses => _expenses;
  List<String> get categories => _categories;
  List<Expense> get expensesByCategory => _expensesByCategory;
  DateTime get currentScreenDateTime => _currentScreenDateTime;

  void notify() {
    notifyListeners();
  }

  void loadExpenses() {
    _expenses = repository.getAllExpenses();
    notifyListeners();
  }

  void getAllUsedCategories() {
    _categories = repository.getAllUsedCategories();
    notifyListeners();
  }

  void getExpensesByCategory(String category) {
    _expensesByCategory = repository.getExpensesByCategory(category);
    notifyListeners();
  }

  double getTotalExpensesByCategory(String category) {
    return repository.getTotalExpensesByCategory(category);
  }

  void setScreenDateTime(int i) {
    _currentScreenDateTime = repository.setScreenDateTime(_currentScreenDateTime, i);
    notifyListeners();
  }

  String getNormalDate() {
    String normalDate = repository.getNormalDate(_currentScreenDateTime);
    return normalDate;
  }

  double getTotalExpensesByDate() {
    return repository.getTotalExpensesByDate(_currentScreenDateTime);
  }

  Future<void> addOrUpdateExpense(Expense expense) async {
    await repository.addOrUpdateExpense(expense);
  }

  Future<void> deleteExpense(String id) async {
    await repository.deleteExpense(id);
  }
}