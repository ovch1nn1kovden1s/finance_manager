import 'package:hive/hive.dart';
import '../../models/expense.dart';
import '../../models/category.dart';

class ExpenseRepository {
  final Box<Expense> expenseBox;

  ExpenseRepository(this.expenseBox);

  List<Expense> getAllExpenses() {
    List<Expense> expenses = expenseBox.values.toList();
    return expenses;
  }

  List<Expense> getExpensesByCategory(Category category) {
    List<Expense> expenses = expenseBox.values
        .where((expense) => expense.category == category)
        .toList();
    return expenses;
  }

  List<Category> getAllUsedCategories() {
    List<Category> categories =  [];
    var categoriesSet = expenseBox.values.map((expense) => expense.category.name).toSet().toList();
    for (String category in categoriesSet) {
      categories.add(Category(name: category));
    }
    return categories;
  }

  Future<void> addOrUpdateExpense(Expense expense) async {
    await expenseBox.put(expense.id, expense);
  }

  Future<void> deleteExpense(String id) async {
    await expenseBox.delete(id);
  }
}