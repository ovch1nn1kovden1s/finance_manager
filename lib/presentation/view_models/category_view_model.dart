import '../../data/repositories/category_repository.dart';
import 'package:flutter/material.dart';
import '../../models/category.dart';
import 'dart:math';

class CategoryViewModel extends ChangeNotifier {
  final CategoryRepository repository;
  List<Category> _categories = [];

  CategoryViewModel(this.repository);

  List<Category> get categories => _categories;

  int generateRandomColor() {
    final Random random = Random();
    return (0xFF << 24) |
          (random.nextInt(256) << 16) |
          (random.nextInt(256) << 8) |
          random.nextInt(256);
  }

  void loadCategories() {
    _categories = repository.getAllCategories();
    notifyListeners();
  }

  Future<void> addCategory(Category category) async {
    await repository.addCategory(category);
    loadCategories();
  }

  Future<void> deleteCategory(String name) async {
    await repository.deleteCategory(name);
    notifyListeners();
  }

  Future<void> initDefaultCategories() async {
    await repository.initDefaultCategories();
    loadCategories();
  }
}