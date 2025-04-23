import 'package:flutter/material.dart';
import '../../domain/models/category.dart';
import '../../domain/use_cases/categories_use_case.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoriesUseCase useCase;
  List<Category> _categories = [];

  CategoryViewModel(this.useCase);

  List<Category> get categories => _categories;

  Future<void> loadCategories() async {
    _categories = await useCase.getAllCategories();
    notifyListeners();
  }

  Future<void> addCategory(Category category) async {
    await useCase.addCategory(category);
    loadCategories();
  }

  Future<void> initDefaultCategories() async {
    await useCase.initDefaultCategories();
    loadCategories();
  }
}