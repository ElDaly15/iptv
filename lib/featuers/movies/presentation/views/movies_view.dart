import 'package:flutter/material.dart';
import 'package:iptv/featuers/movies/presentation/views/widgets/movies_view_body.dart';

class MoviesView extends StatelessWidget {
  const MoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MoviesViewBody(),
    );
  }
}