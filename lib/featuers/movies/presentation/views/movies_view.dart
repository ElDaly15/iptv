import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iptv/featuers/movies/presentation/manager/get_movies_category/get_movies_category_cubit.dart';
import 'package:iptv/featuers/movies/presentation/views/widgets/movies_view_body.dart';

class MoviesView extends StatelessWidget {
  const MoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetMoviesCategoryCubit(),
      child: const Scaffold(body: MoviesViewBody()),
    );
  }
}
