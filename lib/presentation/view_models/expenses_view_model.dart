import '../../data/repositories/expense_repository.dart';
import 'package:flutter/material.dart';
import '../../models/expense.dart';

class ExpenseViewModel extends ChangeNotifier {
  final ExpenseRepository repository;
  List<Expense> _expenses = [];
  List<String> _categories = [];
  List<Expense> _expensesByCategory = [];
  DateTime _currentScreenDateTime = DateTime.now();
  List<String> _categoriesbyMonth = [];
  List<Expense> _expensesByCategoryAndMonth = [];
  bool _isDateVisible = true;

  ExpenseViewModel(this.repository);

  List<Expense> get expenses => _expenses;
  List<String> get categories => _categories;
  List<Expense> get expensesByCategory => _expensesByCategory;
  DateTime get currentScreenDateTime => _currentScreenDateTime;
  List<String> get categoriesbyMonth => _categoriesbyMonth;
  List<Expense> get expensesByCategoryAndMonth => _expensesByCategoryAndMonth;
  bool get isDateVisible => _isDateVisible;

  void notify() {
    notifyListeners();
  }

  void changeDateVisible() {
    _isDateVisible = !_isDateVisible;
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

  double getTotalExpensesByCategoryAndMonth(String category) {
    return repository.getTotalExpensesByCategoryAndMonth(category, _currentScreenDateTime);
  }

  void setScreenDateTime(int i) {
    _currentScreenDateTime = repository.setScreenDateTime(_currentScreenDateTime, i);
    notifyListeners();
  }

  String getNormalDate() {
    String normalDate = repository.getNormalDate(_currentScreenDateTime);
    return normalDate;
  }

  void getCategoriesByMonth() {
    _categoriesbyMonth = repository.getCategoriesByMonth(_currentScreenDateTime);
  }

  double getTotalExpensesByDate() {
    return repository.getTotalExpensesByDate(_currentScreenDateTime);
  }

  Future<void> addOrUpdateExpense(Expense expense) async {
    await repository.addOrUpdateExpense(expense);
  }

  void getExpensesByCategoryAndMonth(String category) {
    _expensesByCategoryAndMonth = repository.getExpensesByCategoryAndMonth(category, _currentScreenDateTime);
    notifyListeners();
  }

  Future<void> deleteExpense(String id) async {
    await repository.deleteExpense(id);
  }
}