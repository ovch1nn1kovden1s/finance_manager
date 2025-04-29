import '../../presentation/view_models/category_view_model.dart';
import '../../presentation/view_models/expenses_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class ExpensesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expenseViewModel = Provider.of<ExpenseViewModel>(context, listen: false);
    final categoryViewModel = Provider.of<CategoryViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
      ),
      body: FutureBuilder(
        future: Future.microtask(() => expenseViewModel.getAllUsedCategories()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading'));
          } else {
            return Consumer<ExpenseViewModel>(
              builder: (context, expenseViewModel, child) {
                return Column(
                  children: <Widget>[
                    Container(
                      color: const Color(0xFF67FA8E),
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        children: [
                          Text(expenseViewModel.getNormalDate()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_left),
                                onPressed: () {
                                  expenseViewModel.setScreenDateTime(-1);
                                },
                              ),
                              Spacer(),
                              IconButton(
                                icon: Icon(Icons.arrow_right),
                                onPressed: () {
                                  expenseViewModel.setScreenDateTime(1);
                                },
                              )
                            ],
                          ),
                          Text('${expenseViewModel.getTotalExpensesByDate()}')
                        ],
                      )
                    ),
                    SizedBox(height: 20,),
                    Expanded(
                      child: ListView.builder(
                        itemCount: expenseViewModel.categories.length,
                        itemBuilder: (context, index) {
                          final category = expenseViewModel.categories[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                expenseViewModel.getExpensesByCategory(category);
                                GoRouter.of(context).go('/by_category/${category}');
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(category),
                                  Text('${expenseViewModel.getTotalExpensesByCategory(category)}'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          categoryViewModel.loadCategories();
          context.go('/add');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}