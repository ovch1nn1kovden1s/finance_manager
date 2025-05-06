import '../../presentation/view_models/category_view_model.dart';
import '../../presentation/view_models/expenses_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';

class ExpensesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expenseViewModel = Provider.of<ExpenseViewModel>(context, listen: false);
    final categoryViewModel = Provider.of<CategoryViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFFD5D5D5),
      appBar: AppBar(
        title: Text(
          'Траты',
          style: TextStyle(
            color: const Color(0xFF68C060),
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF1E5319),
      ),
      body: FutureBuilder(
        future: Future.microtask(() => expenseViewModel.getCategoriesByMonth()),
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
                      color: const Color(0xFF1E5319),
                      width: MediaQuery.of(context).size.width * 1,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_left),
                                color: const Color(0xFFCAFFC5),
                                onPressed: () {
                                  expenseViewModel.setScreenDateTime(-1);
                                  expenseViewModel.getCategoriesByMonth();
                                },
                              ),
                              Spacer(),
                              Text(
                                expenseViewModel.getNormalDate(),
                                style: TextStyle(
                                  color: const Color(0xFFCAFFC5),
                                  fontSize: 20,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                icon: Icon(Icons.arrow_right),
                                color: const Color(0xFFCAFFC5),
                                onPressed: () {
                                  expenseViewModel.setScreenDateTime(1);
                                  expenseViewModel.getCategoriesByMonth();
                                },
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width * 0.95,
                            padding: EdgeInsets.all(22.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFFF2F8F2),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  '${expenseViewModel.getTotalExpensesByDate()}',
                                  style: TextStyle(
                                    color: Color(0xFF1E5319),
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                SizedBox(
                                  height: 150,
                                  child: PieChart(
                                    PieChartData(
                                      sections: expenseViewModel.categoriesbyMonth.map((category) {
                                        return PieChartSectionData(
                                          color: Color(category.color),
                                          radius: 40,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      color: Color(0xFF1E5319),
                                      onPressed: () {
                                        categoryViewModel.loadCategories();
                                        context.go('/add');
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ),
                          SizedBox(height: 5),
                        ],
                      )
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: ListView.builder(
                          itemCount: expenseViewModel.categoriesbyMonth.length,
                          itemBuilder: (context, index) {
                            final category = expenseViewModel.categoriesbyMonth[index];
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFF2F8F2),
                                  padding: EdgeInsets.all(22.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                                onPressed: () {
                                  expenseViewModel.getExpensesByCategoryAndMonth(category.name);
                                  GoRouter.of(context).go('/by_category/${category}');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      category.name,
                                      style: TextStyle(
                                        color: Color(category.color),
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      '${expenseViewModel.getTotalExpensesByCategoryAndMonth(category.name)}',
                                      style: TextStyle(
                                        color: Color(0xFF1E5319),
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}