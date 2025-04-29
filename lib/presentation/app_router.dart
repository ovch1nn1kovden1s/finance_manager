import 'package:go_router/go_router.dart';
import 'ui/expenses_list_screen.dart';
import 'ui/add_expense_screen.dart';
import 'ui/expenses_by_category_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ExpensesListScreen(),
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) => AddExpenseScreen(),
    ),
    GoRoute(
      path: '/by_category/:category_name',
      builder: (context, state) {
        final String category_name = state.pathParameters['category_name']!;
        return ExpensesByCategoryScreen(category_name: category_name);
      },
    )
  ],
);
