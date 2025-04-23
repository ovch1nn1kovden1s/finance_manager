import 'package:finance_manger/data/repositories/category_repository.dart';
import 'package:finance_manger/data/repositories/expense_repository.dart';
import 'package:finance_manger/presentation/view_models/category_view_model.dart';
import 'package:finance_manger/presentation/view_models/expenses_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/app_router.dart';
import 'data/db/hive_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.initHive();
  await HiveService.openExpenseBox();
  await HiveService.openCategoryBox();
  final categoriesRep = CategoryRepository(HiveService.getCategoryBox());
  await categoriesRep.initDefaultCategories();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CategoryViewModel(CategoryRepository(HiveService.getCategoryBox()))),
        ChangeNotifierProvider(create: (context) => ExpenseViewModel(ExpenseRepository(HiveService.getExpenseBox()))),
      ],
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }
}