import 'package:hive/hive.dart';
import '../../models/expense.dart';

class ExpenseRepository {
  final Box<Expense> expenseBox;

  ExpenseRepository(this.expenseBox);

  List<Expense> getAllExpenses() {
    List<Expense> expenses = expenseBox.values.toList();
    return expenses;
  }

  List<Expense> getExpensesByCategory(String category) {
    List<Expense> expenses = expenseBox.values
        .where((expense) => expense.category.name == category)
        .toList();
    return expenses;
  }

  List<String> getAllUsedCategories() {
    List<String> categories = expenseBox.values.map((expense) => expense.category.name).toSet().toList();
    return categories;
  }

  Future<void> addOrUpdateExpense(Expense expense) async {
    await expenseBox.put(expense.id, expense);
  }

  Future<void> deleteExpense(String id) async {
    await expenseBox.delete(id);
  }
}