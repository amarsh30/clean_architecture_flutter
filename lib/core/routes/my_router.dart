import 'package:clean_architecture/features/profile/presentation/pages/all_users_page.dart';
import 'package:clean_architecture/features/profile/presentation/pages/detail_users_page.dart';
import 'package:go_router/go_router.dart';

class MyRouter {
  GoRouter get router => GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        name: "all_users",
        pageBuilder: (context, state) =>
            NoTransitionPage(child: const AllUsersPage()),
        // sub routes
        routes: [
          GoRoute(
            path: "detail-user",
            name: "detail_users",
            pageBuilder: (context, state) => NoTransitionPage(
              child: DetailUsersPage(userId: state.extra as int),
            ),
          ),
        ],
      ),
    ],
  );
}
