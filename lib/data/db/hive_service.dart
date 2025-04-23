import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/models/expense.dart';
import '../../domain/models/category.dart';

class HiveService {
  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ExpenseAdapter());
    Hive.registerAdapter(CategoryAdapter());
  }

  static Future<Box<Expense>> openExpenseBox() async {
    return await Hive.openBox<Expense>('expenses');
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
}