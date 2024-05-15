import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/features/main/bloc/theme_bloc.dart';
import 'package:movie_app/features/movie/bloc/movie_bloc.dart';
import 'package:movie_app/root/routes.dart';
import 'package:movie_app/utils/common/extensions.dart';

import '../../../data/models/movie/movie.dart';
import '../../../root/injections.dart';

class MoviesPage extends StatefulWidget {
  MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<MovieBloc>()..add(const MovieEvent.fetchMovie(initial: true)),
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) => buildPage(context, state),
      ),
    );
  }

  Widget buildPage(BuildContext context, MovieState state) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Movies'),
          actions: [
            GestureDetector(
              onTap: () {
                var currentMode = context.read<ThemeBloc>().state.themeMode;
                context.read<ThemeBloc>().add(
                      currentMode == ThemeMode.light
                          ? const ThemeEvent.switchToDark()
                          : const ThemeEvent.switchToLight(),
                    );
              },
              child: Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) => Icon(
                      state.themeMode == ThemeMode.light
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined),
                ),
              ),
            )
          ],
        ),
        body: state.when(
          initial: handleLoading,
          loading: handleLoading,
          success: (movies, page) {
            return handleSuccess(context, movies, page);
          },
          error: handleError,
        ),
      ),
    );
  }

  Widget handleLoading() => const Center(
        child: CircularProgressIndicator(),
      );

  Widget handleError(String message) => Center(child: Text(message));

  Widget handleSuccess(BuildContext context, List<Movie> movies, int page) =>
      ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) => index < movies.length
            ? movieItem(
                movies[index],
                () {
                  context.goNamed(
                    AppRouter.movie_detail,
                    queryParams: {'movie_id': movies[index].movieId.toString()},
                  );
                },
              )
            : context.read<MovieBloc>().isLoadingLoadMore
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        context.read<MovieBloc>().add(MovieEvent.fetchMovie(
                            initial: false,
                            page: context.read<MovieBloc>().nextPage));
                      },
                      child: Text(
                        'Load More',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
        separatorBuilder: (context, index) => 8.verticalSpace,
        itemCount: movies.length + 1,
      );

  Widget movieItem(Movie movie, onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
            side: const BorderSide(width: 1, color: Colors.grey),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.r),
                  bottomLeft: Radius.circular(4.r)),
              child: Image.network(
                'https://image.tmdb.org/t/p/original/${movie.posterPath}',
                width: 80.w,
                height: 100.w,
                fit: BoxFit.fill,
              ),
            ),
            8.horizontalSpace,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    4.verticalSpace,
                    Text(
                      movie.overview,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
