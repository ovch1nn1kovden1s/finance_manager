import 'package:go_router/go_router.dart';
import 'ui/expenses_list_screen.dart';
import 'ui/add_expense_screen.dart';

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
  ],
);
