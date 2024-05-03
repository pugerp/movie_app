import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/features/main/bloc/theme_bloc.dart';
import 'package:movie_app/utils/common/default_theme.dart';
import 'package:movie_app/utils/common/extensions.dart';

import '../../root/injections.dart';
import '../../root/routes.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ThemeBloc>(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return ScreenUtilInit(
            minTextAdapt: true,
            splitScreenMode: false,
            child: MaterialApp.router(
              title: 'Movie App',
              debugShowCheckedModeBanner: false,
              theme: DefaultTheme.light,
              darkTheme: DefaultTheme.dark,
              themeMode: state.themeMode,
              routeInformationProvider: AppRouter.router
                  .routeInformationProvider,
              routeInformationParser: AppRouter.router.routeInformationParser,
              routerDelegate: AppRouter.router.routerDelegate,
            ),
          );
        },
      ),
    );
  }
}
