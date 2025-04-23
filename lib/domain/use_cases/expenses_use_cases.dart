import '../../domain/models/expense.dart';
import '../../data/repositories/expense_repository.dart';

class ExpensesUseCases {
  final ExpenseRepository repository;

  ExpensesUseCases(this.repository);

  Future<List<Expense>> getAllExpenses() async {
    return await repository.getAllExpenses();
  }

  Future<void> addExpense(Expense expense) async {
    await repository.addOrUpdateExpense(expense);
  }

  Future<void> removeExpense(int id) async {
    await repository.deleteExpense(id);
  }
}
