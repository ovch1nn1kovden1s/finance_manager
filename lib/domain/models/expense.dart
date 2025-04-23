import 'package:hive/hive.dart';
import 'category.dart';

part 'expense.g.dart';

@HiveType(typeId: 1)
class Expense {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  double amount;
  @HiveField(3)
  DateTime date;
  @HiveField(4)
  Category category;

  Expense({
    required this.id,
    required this.name,
    required this.amount,
    required this.date,
    required this.category
  });
}