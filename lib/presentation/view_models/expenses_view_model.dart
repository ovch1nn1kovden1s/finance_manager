import 'package:finance_manger/data/repositories/expense_repository.dart';
import 'package:flutter/material.dart';
import '../../models/expense.dart';

class ExpenseViewModel extends ChangeNotifier {
  final ExpenseRepository repository;
  List<Expense> _expenses = [];

  ExpenseViewModel(this.repository);

  List<Expense> get expenses => _expenses;

  void loadExpenses() {
    _expenses = repository.getAllExpenses();
    notifyListeners(); 
  }

  Future<void> addOrUpdateExpense(Expense expense) async {
    await repository.addOrUpdateExpense(expense);
    loadExpenses();
  }

  Future<void> deleteExpense(String id) async {
    await repository.deleteExpense(id);
    loadExpenses();
  }
}