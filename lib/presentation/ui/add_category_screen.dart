import '../../models/category.dart';
import '../../presentation/view_models/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AddCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _categoryController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF2F8F2),
      appBar: AppBar(
        title: Text(
          'Категории',
          style: TextStyle(
            color: const Color(0xFF68C060),
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: const Color(0xFF68C060),
          onPressed: () {
            context.go('/add');
          },
        ),
        backgroundColor: const Color(0xFF1E5319),
      ),
      body: Consumer<CategoryViewModel>(
        builder: (context, categoryViewModel, child) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Добавить категорию',
                        style: TextStyle(
                          color: const Color(0xFF1E5319),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        controller: _categoryController,
                        cursorColor: const Color(0xFF1E5319),
                        decoration: InputDecoration(
                          labelText: 'Имя категории',
                          labelStyle: TextStyle(color: const Color(0xFF1E5319)),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: const Color(0xFF1E5319)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Пожалуйста, введите категорию';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final categoryName = _categoryController.text;

                            categoryViewModel.addCategory(Category(name: categoryName, color: categoryViewModel.generateRandomColor()));
                            context.go('/add');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1E5319),
                          padding: EdgeInsets.all(22.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        child: Text(
                          'Добавить',
                          style: TextStyle(
                            color: const Color(0xFFF2F8F2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40,),
                Text(
                  'Категории',
                  style: TextStyle(
                    color: const Color(0xFF1E5319),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: categoryViewModel.categories.length,
                    itemBuilder: (context, index) {
                    final category = categoryViewModel.categories[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            category.name,
                            style: TextStyle(
                              color: const Color(0xFF1E5319),
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            color: const Color(0xFF1E5319),
                            onPressed: () {
                              categoryViewModel.deleteCategory(category.name);
                              categoryViewModel.loadCategories();
                            },
                          )
                        ]
                      );
                    }
                  ),
                ),
              ],
            )
          );
        }
      )
    );
  }
}