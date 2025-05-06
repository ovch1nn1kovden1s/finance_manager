import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 0)
class Category {
  @HiveField(0)
  String name;
  @HiveField(1)
  int color;

  Category({
    required this.name,
    required this.color,
  });
}