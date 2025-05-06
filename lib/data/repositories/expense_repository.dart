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

  List<Category> getCategoriesByMonth(DateTime date) {
    return expenseBox.values
        .where((expense) => expense.date.year == date.year && expense.date.month == date.month)
        .map((expense) => expense.category)
        .toSet()
        .toList();
  }

  List<Expense> getExpensesByCategoryAndMonth(String category, DateTime date) {
    List<Expense> expenses = expenseBox.values
        .where((expense) => expense.category.name == category && expense.date.year == date.year && expense.date.month == date.month)
        .toList();
    return expenses;
  }

  double getTotalExpensesByCategoryAndMonth(String category, DateTime date) {
    return expenseBox.values
        .where((expense) => expense.category.name == category && expense.date.year == date.year && expense.date.month == date.month)
        .fold(0.0, (sum, expense) => sum + expense.amount);
  }

  double getTotalExpensesByCategory(String category) {
    return expenseBox.values
        .where((expense) => expense.category.name == category)
        .fold(0.0, (sum, expense) => sum + expense.amount);
  }

  DateTime setScreenDateTime(DateTime currentDate, int i) {
    int year = currentDate.year;
    int month = currentDate.month + i;
    
    if (month < 1) {
      month = 12;
      year -= 1;
    }
    if (month > 12) {
      month = 1;
      year += 1;
    }

    return DateTime(year, month, 1);
  }

  String getNormalDate(DateTime date) {
    List<String> monthNames = [
      'Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь',
      'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'
    ];

    String normalDate = '${monthNames[date.month - 1]} ${date.year}';
    return normalDate;
  }

  double getTotalExpensesByDate(DateTime date) {
    return expenseBox.values
        .where((expense) => expense.date.month == date.month && expense.date.year == date.year)
        .fold(0.0, (sum, expense) => sum + expense.amount);
  }

  Future<void> addOrUpdateExpense(Expense expense) async {
    await expenseBox.put(expense.id, expense);
  }

  Future<void> deleteExpense(String id) async {
    await expenseBox.delete(id);
  }
}