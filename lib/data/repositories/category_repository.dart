import 'package:hive/hive.dart';
import '../../domain/models/category.dart';
import '../db/hive_service.dart';

class CategoryRepository {
  final Box<Category> categoryBox;

  CategoryRepository(this.categoryBox);

  Future<List<Category>> getAllCategories() async {
    await HiveService.openCategoryBox();
    List<Category> categories = categoryBox.values.toList();
    await HiveService.closeCategoryBox();
    return categories;
  }

  Future<void> addCategory(Category category) async {
    await HiveService.openCategoryBox();
    await categoryBox.put(category.name, category);
    await HiveService.closeCategoryBox();
  }

  Future<void> initDefaultCategories() async {
    await HiveService.openCategoryBox();
    List<String> defaultCategories = ['Транспорт', 'Еда', 'Развлечения', 'Здоровье'];
    for (var categoryName in defaultCategories) {
      if (categoryBox.get(categoryName) == null) {
        await addCategory(Category(name: categoryName));
      }
    }
    await HiveService.closeCategoryBox();
  }
}