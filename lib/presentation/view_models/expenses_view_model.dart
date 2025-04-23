import 'package:flutter/material.dart';
import '../../domain/models/expense.dart';
import '../../domain/use_cases/expenses_use_cases.dart';

class ExpenseViewModel extends ChangeNotifier {
  final ExpensesUseCases useCase;
  List<Expense> _expenses = [];

  ExpenseViewModel(this.useCase);

  List<Expense> get expenses => _expenses;

  Future<void> loadExpenses() async {
    _expenses = await useCase.getAllExpenses();
    notifyListeners(); 
  }

  Future<void> addExpense(Expense expense) async {
    await useCase.addExpense(expense);
    loadExpenses();
  }

  Future<void> removeExpense(int id) async {
    await useCase.removeExpense(id);
    loadExpenses();
  }
}