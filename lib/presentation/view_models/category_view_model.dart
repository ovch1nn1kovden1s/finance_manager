import 'package:finance_manger/data/repositories/category_repository.dart';
import 'package:flutter/material.dart';
import '../../models/category.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryRepository repository;
  List<Category> _categories = [];

  CategoryViewModel(this.repository);

  List<Category> get categories => _categories;

  void loadCategories() {
    _categories = repository.getAllCategories();
    notifyListeners();
  }

  Future<void> addCategory(Category category) async {
    await repository.addCategory(category);
    loadCategories();
  }

  Future<void> initDefaultCategories() async {
    await repository.initDefaultCategories();
    loadCategories();
  }
}