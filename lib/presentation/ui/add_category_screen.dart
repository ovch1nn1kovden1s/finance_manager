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
      appBar: AppBar(
        title: Text('Категории'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/add');
          },
        ),
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
                      Text('Добавить категорию'),
                      TextFormField(
                        controller: _categoryController,
                        decoration: InputDecoration(labelText: 'Имя категории'),
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

                            categoryViewModel.addCategory(Category(name: categoryName));
                            context.go('/add');
                          }
                        },
                        child: Text('Добавить'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40,),
                Text('Категории'),
                Expanded(
                  child: ListView.builder(
                    itemCount: categoryViewModel.categories.length,
                    itemBuilder: (context, index) {
                    final category = categoryViewModel.categories[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(category.name),
                          IconButton(
                            icon: Icon(Icons.delete),
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