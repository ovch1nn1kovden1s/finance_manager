import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/expense.dart';
import '../../models/category.dart';

class HiveService {
  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ExpenseAdapter());
    Hive.registerAdapter(CategoryAdapter());
  }

  static Future<void> openExpenseBox() async {
    await Hive.openBox<Expense>('expenses');
  }

  static Future<void> closeExpenseBox() async {
    await Hive.box<Expense>('expenses').close();
  }

  static Future<void> openCategoryBox() async {
    await Hive.openBox<Category>('categories');
  }

  static Future<void> closeCategoryBox() async {
    await Hive.openBox<Expense>('categories');
  }

  static Box<Category> getCategoryBox() {
    final categoryBox = Hive.box<Category>('categories');
    return categoryBox;
  }

  static Box<Expense> getExpenseBox() {
    final expenseBox = Hive.box<Expense>('expenses');
    return expenseBox;
  }
}