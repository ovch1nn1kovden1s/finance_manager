import 'package:hive/hive.dart';
import '../../domain/models/expense.dart';
import '../db/hive_service.dart';
import 'category_repository.dart';

class ExpenseRepository {
  final Box<Expense> expenseBox;
  final CategoryRepository categoryRepository;

  ExpenseRepository(this.expenseBox, this.categoryRepository);

  Future<List<Expense>> getAllExpenses() async {
    await HiveService.openExpenseBox();
    List<Expense> expenses = expenseBox.values.toList();
    await HiveService.closeExpenseBox();
    return expenses;
  }

  Future<void> addOrUpdateExpense(Expense expense) async {
    await HiveService.openExpenseBox();
    await HiveService.openCategoryBox();
    var categories = await categoryRepository.getAllCategories();
    if (categories.contains(expense.category)) {
      await expenseBox.put(expense.id, expense);
    } else {
      throw Exception('Category not found');
    }
    await HiveService.closeExpenseBox();
    await HiveService.openCategoryBox();
  }

  Future<void> deleteExpense(int id) async {
    await HiveService.openExpenseBox();
    await expenseBox.delete(id);
    await HiveService.closeExpenseBox();
  }
}