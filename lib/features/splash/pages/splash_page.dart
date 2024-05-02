import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/features/splash/bloc/splash_bloc.dart';

import '../../../root/injections.dart';
import '../../../root/routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SplashBloc>()..add(const SplashEvent.started()),
      child: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {},
            success: () {
              context.goNamed(AppRouter.movie_list);
            },
            error: () {},
          );
        },
        builder: (context, state) => _buildPage(context),
      ),
    );
  }

  _buildPage(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash Page'),
      ),
    );
  }
}
