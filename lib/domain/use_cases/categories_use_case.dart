import '../../domain/models/category.dart';
import '../../data/repositories/category_repository.dart';

class CategoriesUseCase {
  final CategoryRepository repository;

  CategoriesUseCase(this.repository);

  Future<List<Category>> getAllCategories() async {
    return await repository.getAllCategories();
  }

  Future<void> addCategory(Category category) async {
    await repository.addCategory(category);
  }

  Future<void> initDefaultCategories() async {
    await repository.initDefaultCategories();
  }
}