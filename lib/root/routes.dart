import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/features/movie/pages/movie_detail_page.dart';
import 'package:movie_app/features/movie/pages/movies_page.dart';
import 'package:movie_app/features/splash/pages/splash_page.dart';
import 'package:movie_app/utils/common/extensions.dart';

class AppRouter {
  static const splash = '/';
  static const movie_list = 'movies';
  static const movie_detail = 'movie_detail';

  static MaterialPage _splashPageRouteBuilder(
          BuildContext context, GoRouterState state) =>
      MaterialPage(key: state.pageKey, child: const SplashPage());

  static MaterialPage _movieListPageRouteBuilder(
          BuildContext context, GoRouterState state) =>
      MaterialPage(
        key: state.pageKey,
        child: MoviesPage(),
      );

  static MaterialPage _movieDetailPageRouteBuilder(
      BuildContext context, GoRouterState state) {
    final id = state.queryParams['movie_id'] ?? '0';

    return MaterialPage(
        key: state.pageKey, child: MovieDetailPage(movieId: int.parse(id)));
  }

  static MaterialPage _errorWidget(BuildContext context, GoRouterState state) =>
      MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Text(AppRouter.router.location),
          ),
        ),
      );

  static final GoRouter _router = GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: '/',
          name: splash,
          pageBuilder: _splashPageRouteBuilder,
        ),
        GoRoute(
            path: movie_list.toMainPath(),
            name: movie_list,
            pageBuilder: _movieListPageRouteBuilder,
            routes: [
              GoRoute(
                  path: movie_detail,
                  name: movie_detail,
                  pageBuilder: _movieDetailPageRouteBuilder),
            ]),
      ],
      errorPageBuilder: _errorWidget);

  static GoRouter get router => _router;
}
