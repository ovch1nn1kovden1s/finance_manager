import 'package:hive/hive.dart';
import '../../models/category.dart';

class CategoryRepository {
  final Box<Category> categoryBox;

  CategoryRepository(this.categoryBox);

  List<Category> getAllCategories() {
    List<Category> categories = categoryBox.values.toList();
    return categories;
  }

  Future<void> addCategory(Category category) async {
    if (categoryBox.containsKey(category.name)) {
      return;
    }
    await categoryBox.put(category.name, category);
  }

  Future<void> deleteCategory(String name) async {
    await categoryBox.delete(name);
  }

  Future<void> initDefaultCategories() async {
    List<Category> defaultCategories = [
      Category(name: 'Транспорт', color: 0xFF2107A3),
      Category(name: 'Еда', color: 0xFF00B31B),
      Category(name: 'Развлечения', color: 0xFFE49502),
      Category(name: 'Здоровье', color: 0xFFC50202)
    ];
    for (var category in defaultCategories) {
      if (categoryBox.get(category.name) == null) {
        await addCategory(category);
      }
    }
  }
}