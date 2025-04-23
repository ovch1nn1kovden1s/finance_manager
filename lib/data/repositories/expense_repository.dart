import 'package:hive/hive.dart';
import '../../models/expense.dart';

class ExpenseRepository {
  final Box<Expense> expenseBox;

  ExpenseRepository(this.expenseBox);

  List<Expense> getAllExpenses() {
    List<Expense> expenses = expenseBox.values.toList();
    return expenses;
  }

  Future<void> addOrUpdateExpense(Expense expense) async {
    await expenseBox.put(expense.id, expense);
  }

  Future<void> deleteExpense(String id) async {
    await expenseBox.delete(id);
  }
}