import 'package:go_router/go_router.dart';
import 'package:new_alegria/features/sales/screens/sales_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const SalesScreen();
      },
    ),
  ],
);
