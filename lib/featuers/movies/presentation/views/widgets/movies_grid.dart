import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as g;
import 'package:iptv/featuers/live_tv/presentation/views/tv_player_view.dart';
import 'package:iptv/featuers/movies/presentation/manager/get_movies/get_movies_cubit.dart';
import 'package:iptv/featuers/movies/presentation/views/widgets/movie_card.dart';

class MoviesGrid extends StatelessWidget {
  final String selectedCategory;

  const MoviesGrid({super.key, required this.selectedCategory});

  int _calculateCrossAxisCount(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    if (width >= 1600) return 6;
    if (width >= 1300) return 5;
    if (width >= 1000) return 4;
    if (width >= 700) return 3;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    final int crossAxisCount = _calculateCrossAxisCount(context);
    return BlocBuilder<GetMoviesCubit, GetMoviesState>(
      builder: (context, state) {
        if (state is GetMoviesLoading) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              return const Card(color: Colors.grey);
            },
          );
        }

        if (state is GetMoviesError) {
          return Center(
            child: Text(
              state.error,
              style: const TextStyle(color: Colors.white),
            ),
          );
        }

        if (state is GetMoviesSuccess) {
          final items = state.moviesContentResponse.content;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final movie = items[index];
              return InkWell(
                onTap: () {
                  g.Get.to(
                    () => TvPlayerView(
                      channelName: movie.name,
                      streamUrl: movie.streamUrl,
                    ),
                    transition: g.Transition.fade,
                    duration: const Duration(milliseconds: 300),
                  );
                },
                child: MovieCard(title: movie.name),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
