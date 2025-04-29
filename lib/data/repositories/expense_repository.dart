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

  List<String> getCategoriesForCurrentMonth() {
    DateTime now = DateTime.now();
    return expenseBox.values
        .where((expense) => expense.date.year == now.year && expense.date.month == now.month)
        .map((expense) => expense.category.name)
        .toSet()
        .toList();
  }

  List<String> getAllUsedCategories() {
    List<String> categories = expenseBox.values.map((expense) => expense.category.name).toSet().toList();
    return categories;
  }

  double getTotalExpensesByCategory(String category) {
    return expenseBox.values
        .where((expense) => expense.category.name == category)
        .fold(0.0, (sum, expense) => sum + expense.amount);
  }

  double getTotalExpenses() {
    return expenseBox.values
        .fold(0.0, (sum, expense) => sum + expense.amount);
  }

  Future<void> addOrUpdateExpense(Expense expense) async {
    await expenseBox.put(expense.id, expense);
  }

  Future<void> deleteExpense(String id) async {
    await expenseBox.delete(id);
  }
}