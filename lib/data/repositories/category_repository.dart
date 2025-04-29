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
    await categoryBox.put(category.name, category);
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