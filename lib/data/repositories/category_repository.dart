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
    List<String> defaultCategories = ['Транспорт', 'Еда', 'Развлечения', 'Здоровье'];
    for (var categoryName in defaultCategories) {
      if (categoryBox.get(categoryName) == null) {
        await addCategory(Category(name: categoryName));
      }
    }
  }
}